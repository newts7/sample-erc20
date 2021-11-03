// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/** 
 * @title Ballot
 * @dev Implements voting process along with vote delegation
 */
contract Divya {
   
   string public constant name = "Divya";
   string public constant symbol = "DIVYA";
   uint8 public constant decimals = 18;
   
       
   mapping ( address => uint256) balances;
   mapping ( address => mapping(address => uint256)) allowed;
   
   
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
    event Transfer(address indexed from, address indexed to, uint tokens);

   uint256 totalSupply_;
   constructor(uint256 total){
       totalSupply_ = total;
       balances[msg.sender] = total;
   }
   
    function totalSupply() public view returns (uint256){
        return totalSupply_;
    }

    
    function balanceOf(address tokenOwner) public view returns (uint){
        return balances[tokenOwner];
    }
    
    function allowance(address tokenOwner, address delegate) public view returns (uint){
        return allowed[tokenOwner][delegate];
    }
    function transfer(address to, uint tokens) public payable returns (bool){
        require(tokens <= balances[msg.sender]);
        balances[to] = balances[to] + tokens;
        balances[msg.sender] = balances[msg.sender] - tokens;
        emit Transfer(msg.sender,to, tokens);
        return true;
    }
    
    
    function approve(address delegate, uint tokens)  public returns (bool){
        allowed[msg.sender][delegate] = tokens;
        emit Approval(msg.sender, delegate, tokens);
        return true;
    }
    function transferFrom(address from, address to, uint tokens) public returns (bool){
        require(tokens <= balances[from]);
        require(tokens <= allowed[from][msg.sender]);
        
        balances[to] = balances[to] + tokens;
        allowed[from][msg.sender] = allowed[from][msg.sender] - tokens;
        balances[from] = balances[from]-tokens;
        return true;
    }
   
}
