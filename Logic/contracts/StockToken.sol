pragma solidity 0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract StockToken is ERC20 {
    constructor(uint256 _initialsupply) ERC20("StockToken", "STT") {
        _mint(address(this), _initialsupply);
    }

    uint256 public conversionRate = 1500;

    event toppedUp(address indexed Receiver, uint256 Amount);

    function TopUP() public payable {
        uint256 payment = msg.value;
        require(payment > 0, "You need to send some ether");
        uint256 available = this.balanceOf(address(this));
        uint256 needed = payment * conversionRate;

        require(
            needed < (available * 10**18),
            "Not enough tokens available for transfer at the moment"
        );
        _transfer(address(this), msg.sender, needed / (10**18));
        emit toppedUp(msg.sender, payment);
    }
}
