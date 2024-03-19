// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockUSDT is ERC20 {
    constructor() ERC20("USDT", "USDT") {
        _mint(msg.sender, 10**22);
    }

    function decimals() public view virtual override returns (uint8) {
        return 6;
    }
}
