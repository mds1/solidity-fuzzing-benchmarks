pragma solidity ^0.8.0;

/**
 * @notice The `revert()` denotes a bug that should be caught
 * @custom:ref "Harvey: A Greybox Fuzzer for Smart Contracts", by Valentin
 * Wüstholz and Maria Christakis, Figure 2, https://arxiv.org/pdf/1905.06944.pdf
 */
contract HarveyFoo {
  int256 private x;
  int256 private y;

  constructor() {
    x = 0;
    y = 0;
  }

  function Bar() public returns (int256) {
    if (x == 42) {
      revert();
      return 1;
    }
    return 0;
  }

  function SetY(int256 ny) public {
    y = ny;
  }

  function IncX() public {
    x++;
  }

  function CopyY() public {
    x = y;
  }
}
