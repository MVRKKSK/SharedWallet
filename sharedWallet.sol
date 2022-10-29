// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract SharedWallet {
    address owner;
    constructor(){
        owner = msg.sender;
    }
    mapping(address => uint) public allowances;
    modifier isOwner {
        require(msg.sender == owner , "You are not the owner");
        _;
    }
    modifier ownerOrWithdraw(uint _amount) {
        require(msg.sender == owner || allowances[msg.sender] >= _amount , "You are not allowed" );
        _;
    }
    function depisot() public payable{

    }
    function getBalance() isOwner public view returns(uint) {
        return address(this).balance;
    }
    function setAllowances(address _to , uint amount) public isOwner{
        allowances[_to] = amount;
    }
    function reduceAllowances(address _to , uint amount)  internal {
        allowances[_to] -= amount;
    }
    function withdrawMoney(address payable _to , uint _amount) public ownerOrWithdraw(_amount){
        if(msg.sender != owner){
            reduceAllowances(msg.sender , _amount);
        }
        _to.transfer(_amount);
    }
}
