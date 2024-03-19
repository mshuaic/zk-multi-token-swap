// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import '@openzeppelin/contracts/interfaces/IERC20.sol';
import "hardhat/console.sol";

abstract contract Verifier {
    function verifyProof(uint[2] calldata _pA, uint[2][2] calldata _pB, uint[2] calldata _pC, uint[53] calldata _pubSignals) public virtual view returns (bool);
}

// simplified version of [OdosRouter](https://etherscan.io/address/0x76f4eed9fe41262669d0250b2a97db79712ad855#code)
contract MockOdosRouter {
    struct Token {
        address tokenAddress;
        uint256 amount;
    }

    Verifier public verifier;
    constructor(address _verifier) {
        verifier = Verifier(_verifier);
    }

    function swap(Token[] memory inputs, Token[] memory outputs) public {
        for (uint256 i = 0; i < inputs.length; i++) {
            IERC20(inputs[i].tokenAddress).transferFrom(msg.sender, address(this), inputs[i].amount);
        }
        for (uint256 i = 0; i < outputs.length; i++) {
            IERC20(outputs[i].tokenAddress).transfer(msg.sender, outputs[i].amount);
        }
  }

    function zk_swap(Token[] memory inputs, Token[] memory outputs, uint[2] calldata _pA, uint[2][2] calldata _pB, uint[2] calldata _pC, uint[53] calldata _pubSignals) public {

        //Todo: verify public signals match inputs and outputs
        require(verifier.verifyProof(_pA, _pB, _pC, _pubSignals), "Invalid proof");
        swap(inputs, outputs);
    }
}
