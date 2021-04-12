// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

import "./IERC20.sol";
import "./utils/SafeMath.sol";

contract NipponToken is IERC20 {
    
    string public constant name = "NipponToken";
    string public constant symbol = "NPNT";
    uint8 public constant decimals = 18;
    uint256 totalSupply_ = 100000000000000000000000000;

    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed;

    using SafeMath for uint256;


    constructor() public {
        balances[msg.sender] = totalSupply_;
    }


    function totalSupply() public override view returns (uint256) {
        return totalSupply_;
    }


    function balanceOf(address tokenOwner) public override view returns (uint256) {
        return balances[tokenOwner];
    }


    function transfer(address receiver, uint256 numTokens) public override returns (bool) {
        require(numTokens <= balances[msg.sender]);

        balances[msg.sender] = balances[msg.sender].sub(numTokens);
        balances[receiver] = balances[receiver].add(numTokens);

        emit Transfer(msg.sender, receiver, numTokens);
        return true;
    }


    function approve(address delegate, uint256 numTokens) public override returns (bool) {
        allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }


    function allowance(address owner, address delegate) public override view returns (uint) {
        return allowed[owner][delegate];
    }


    function transferFrom(address owner, address buyer, uint256 numTokens) public override returns (bool) {
        require(numTokens <= balances[owner]);
        require(numTokens <= allowed[owner][msg.sender]);
        
        balances[owner] = balances[owner].sub(numTokens);
        allowed[owner][msg.sender] = allowed[owner][msg.sender].sub(numTokens);
        balances[buyer] = balances[buyer].add(numTokens);
        
        emit Transfer(owner, buyer, numTokens);
        return true;
    }

}