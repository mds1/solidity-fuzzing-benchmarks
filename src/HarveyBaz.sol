pragma solidity ^0.8.0;

/**
 * @notice Fuzzer should cover all five execution paths of `baz`
 * @dev See the below reference for more information on the `minimize` comments
 * @custom:ref "Harvey: A Greybox Fuzzer for Smart Contracts", by Valentin
 * Wüstholz and Maria Christakis, Figure 1, https://arxiv.org/pdf/1905.06944.pdf
 */
contract HarveyBaz {
  function baz(int256 a, int256 b, int256 c) public returns (int256) {
    int256 d = b + c;

    // minimize(d < 1 ? 1 - d : 0);
    // minimize(d < 1 ? 0 : d);
    if (d < 1) {
      // minimize(b < 3 ? 3 - b : 0);
      // minimize(b < 3 ? 0 : b - 2);
      if (b < 3) {
        return 1;
      }
      // minimize(a == 42 ? 1 : 0);
      // minimize(a == 42 ? 0 : |a - 42|);
      if (a == 42) {
        return 2;
      }
      return 3;
    } else {
      // minimize(c < 42 ? 42 - c : 0);
      // minimize(c < 42 ? 0 : c - 41);
      if (c < 42) {
        return 4;
      }
      return 5;
    }
  }
}
