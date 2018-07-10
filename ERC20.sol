pragma solidity ^0.4.18;

import 'zeppelin-solidity/contracts/token/StandardToken.sol';

contract SimpleERC20 is StandardToken
{
  string public name = 'SimpleERC20';
  string public symbol = 'SERC20';
  uint public decimals = 5;
  uint public initialSupply = 24666;

  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event Approval(address indexed _owner, address indexed _spender, uint256 _value);

  function SimpleERC20()
  {
    balances[msg.sender] = initialSupply;
    totalSupply = initialSupply;
  }

  mapping(address => uint256) balances;
  mapping(address => mapping(address => uint256)) allowed;

  function balanceOf(address _owner)
  {
    return balances[_owner];
  }

  function transfer(address _to, uint256 _value)
  {
    if (balances[msg.sender] >= _value &&  _value > 0)
    {
      balances[msg.sender] -= _value;
      balances[_to] += _value;
      Transfer(msg.sender, _to, _value);
      return true;
    }
  }

  function transferFrom(address _from, address _to, uint256 _value)
  {
    if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0)
    {
      balances[_to] += _value;
      balances[_from] -= _value;
      allowed[_from][msg.sender] -= _value;
      Transfer(_from, _to, _value);
      return true;
    }
    else
    {
      return false;
    }
  }

  function approve(address _spender, uint256 _value)
  {
    allowed[msg.sender][_spender] = _value;
    Approval(msg.sender, _spender, _value);
    return true;
  }

  function allowence(address _owner, address _spender)
  {
    return allowed[_owner][_spender];
  }
}
