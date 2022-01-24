pragma solidity ^0.8.0;

/**
 * @notice `setOwner` is missing a require check, so fuzzer should detect that
 * untrusted address can steal funds via a seqence of calls
 * @custom:ref "Learning to Fuzz from Symbolic Execution with Application to
 * Smart Contracts", by Jingxuan He, Mislav Balunović, Nodar Ambroladze, Petar
 * Tsankov, and Martin Vechev, Figure 2, https://files.sri.inf.ethz.ch/website/papers/ccs19-ilf.pdf
 */
contract ILFCrowdsale {
  uint256 goal = 100000 * (10**18); // 100,000 ETH
  uint256 phase = 0; // 0: Active , 1: Success , 2: Refund
  uint256 raised;
  uint256 end; // crowdsale deadline
  address owner;
  mapping(address => uint256) investments;

  constructor() {
    end = block.timestamp + 60 days;
    owner = msg.sender;
  }

  function invest() public payable {
    require(phase == 0 && raised < goal);
    investments[msg.sender] += msg.value;
    raised += msg.value;
  }

  function setPhase(uint256 newPhase) public {
    require (
      (newPhase == 1 && raised >= goal) ||
      (newPhase == 2 && raised < goal && block.timestamp > end)
    );
    phase = newPhase;
  }

  function setOwner(address newOwner) public {
    // require (msg.sender == owner);
    owner = newOwner;
  }

  function withdraw() public {
    require(phase == 1);
    payable(owner).transfer(raised);
  }

  function refund() public {
    require(phase == 2);
    payable(msg.sender).transfer(investments[msg.sender]);
    investments[msg.sender] = 0;
  }
}
