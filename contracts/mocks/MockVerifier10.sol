// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract MockVerifier10 {
  bool public state;

  function verifyProof(
    uint256[2] memory,
    uint256[2][2] memory,
    uint256[2] memory,
    uint256[19] memory
  ) public view returns (bool) {
    return state;
  }

  function setState(bool newState) public {
    state = newState;
  }
}
