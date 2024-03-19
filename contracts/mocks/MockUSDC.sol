// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";

contract MockUSDC is ERC20, ERC20Permit {
    constructor() ERC20("USDC", "USDC") ERC20Permit("USDC") {
        _mint(msg.sender, 10 ** 22);
    }

    function decimals() public view virtual override returns (uint8) {
        return 6;
    }
}
