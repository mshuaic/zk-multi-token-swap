// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/interfaces/IERC20.sol";
import "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";

contract MockSwapRouter {
    uint256 swappedAmount;

    function exactInputSingle(
        ISwapRouter.ExactInputSingleParams calldata params
    ) public payable returns (uint256) {
        require(swappedAmount > params.amountOutMinimum, "T");
        IERC20 firstToken = IERC20(params.tokenIn);
        IERC20 secondToken = IERC20(params.tokenOut);
        firstToken.transferFrom(msg.sender, address(this), params.amountIn);
        secondToken.transfer(msg.sender, swappedAmount);
        return swappedAmount;
    }

    function setOutAmount(uint256 amount) public {
        swappedAmount = amount;
    }
}
