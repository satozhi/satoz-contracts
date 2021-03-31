{\rtf1\ansi\ansicpg1252\cocoartf2578
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 /**\
 *Submitted for verification at BscScan.com on 2021-03-07\
*/\
\
pragma solidity 0.5.16;\
interface IBEP20 \{\
function totalSupply() external view returns (uint256);\
function decimals() external view returns (uint8);\
function symbol() external view returns (string memory);\
function name() external view returns (string memory);\
function getOwner() external view returns (address);\
function balanceOf(address account) external view returns (uint256);\
function transfer(address recipient, uint256 amount) external returns (bool);\
function allowance(address _owner, address spender) external view returns (uint256);\
function approve(address spender, uint256 amount) external returns (bool);\
function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);\
event Transfer(address indexed from, address indexed to, uint256 value);\
event Approval(address indexed owner, address indexed spender, uint256 value);\
\}\
contract Context \{\
constructor () internal \{ \}\
function _msgSender() internal view returns (address payable) \{\
return msg.sender;\
\}\
function _msgData() internal view returns (bytes memory) \{\
this;\
return msg.data;\
\}\
\}\
library SafeMath \{\
function add(uint256 a, uint256 b) internal pure returns (uint256) \{\
uint256 c = a + b;\
require(c >= a, "SafeMath: addition overflow");\
return c;\
\}\
function sub(uint256 a, uint256 b) internal pure returns (uint256) \{\
return sub(a, b, "SafeMath: subtraction overflow");\
\}\
function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) \{\
require(b <= a, errorMessage);\
uint256 c = a - b;\
return c;\
\}\
function mul(uint256 a, uint256 b) internal pure returns (uint256) \{\
if (a == 0) \{\
return 0;\
\}\
uint256 c = a * b;\
require(c / a == b, "SafeMath: multiplication overflow");\
return c;\
\}\
function div(uint256 a, uint256 b) internal pure returns (uint256) \{\
return div(a, b, "SafeMath: division by zero");\
\}\
function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) \{\
require(b > 0, errorMessage);\
uint256 c = a / b;\
return c;\
\}\
function mod(uint256 a, uint256 b) internal pure returns (uint256) \{\
return mod(a, b, "SafeMath: modulo by zero");\
\}\
function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) \{\
require(b != 0, errorMessage);\
return a % b;\
\}\
\}\
contract Ownable is Context \{\
address private _owner;\
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);\
constructor () internal \{\
address msgSender = _msgSender();\
_owner = msgSender;\
emit OwnershipTransferred(address(0), msgSender);\
\}\
function owner() internal view returns (address) \{\
return _owner;\
\}\
modifier onlyOwner() \{\
require(_owner == _msgSender(), "Ownable: caller is not the owner");\
_;\
\}\
function renounceOwnership() internal onlyOwner \{\
emit OwnershipTransferred(_owner, address(0));\
_owner = address(0);\
\}\
function transferOwnership(address newOwner) internal onlyOwner \{\
_transferOwnership(newOwner);\
\}\
function _transferOwnership(address newOwner) internal \{\
require(newOwner != address(0), "Ownable: new owner is the zero address");\
emit OwnershipTransferred(_owner, newOwner);\
_owner = newOwner;\
\}\
\}\
contract Satozhi is Context, IBEP20, Ownable \{\
using SafeMath for uint256;\
mapping (address => uint256) private _balances;\
mapping (address => mapping (address => uint256)) private _allowances;\
mapping (address => uint256) private _accountPoB;\
mapping (address => uint256) private _accountTs;\
uint256 private _blockRewards = 5000000000;\
uint256 private _blockSpacing = 600;\
uint256 private _contractPoB;\
uint256 private _totalSupply;\
uint8 private _decimals;\
string private _symbol;\
string private _name;\
constructor() public \{\
_name = "Satozhi";\
_symbol = "SATOZ";\
_decimals = 8;\
_totalSupply = 2100000000000000;\
_balances[msg.sender] = _totalSupply;\
emit Transfer(address(0), msg.sender, _totalSupply);\
\}\
function blockRewards() external view returns (uint256) \{\
return _blockRewards;\
\}\
function blockSpacing() external view returns (uint256) \{\
return _blockSpacing;\
\}\
function contractPoB() external view returns (uint256) \{\
return _contractPoB;\
\}\
function accountPoB(address account) external view returns (uint256) \{\
return _accountPoB[account];\
\}\
function getOwner() external view returns (address) \{\
return owner();\
\}\
function decimals() external view returns (uint8) \{\
return _decimals;\
\}\
function symbol() external view returns (string memory) \{\
return _symbol;\
\}\
function name() external view returns (string memory) \{\
return _name;\
\}\
function totalSupply() external view returns (uint256) \{\
return _totalSupply;\
\}\
function balanceOf(address account) external view returns (uint256) \{\
uint256 virtualBalance = _virtualRewards(account);\
return _balances[account] + virtualBalance;\
\}\
function transfer(address recipient, uint256 amount) external returns (bool) \{\
_balanceRewards(_msgSender());\
_transfer(_msgSender(), recipient, amount);\
return true;\
\}\
function allowance(address owner, address spender) external view returns (uint256) \{\
return _allowances[owner][spender];\
\}\
function approve(address spender, uint256 amount) external returns (bool) \{\
_balanceRewards(_msgSender());\
_approve(_msgSender(), spender, amount);\
return true;\
\}\
function transferFrom(address sender, address recipient, uint256 amount) external returns (bool) \{\
_balanceRewards(sender);\
_transfer(sender, recipient, amount);\
_approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "BEP20: transfer amount exceeds allowance"));\
return true;\
\}\
function increaseAllowance(address spender, uint256 addedValue) public returns (bool) \{\
_balanceRewards(_msgSender());\
_approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));\
return true;\
\}\
function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) \{\
_balanceRewards(_msgSender());\
_approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "BEP20: decreased allowance below zero"));\
return true;\
\}\
function _virtualRewards(address account) internal view returns (uint256) \{\
uint256 _timediff = block.timestamp-_accountTs[account];\
uint256 _blocks = uint256(_timediff/_blockSpacing);\
if (_timediff>0 && _blocks>0 && _accountTs[account]>0) \{\
uint256 _portion = uint256((100000000*_accountPoB[account])/_contractPoB);\
uint256 _rewards = uint256(((_portion*_blockRewards)/100000000)*_blocks);\
return _rewards;\
\} else \{\
return 0;\
\}\
\}\
function mint(uint256 amount) public onlyOwner returns (bool) \{\
_balanceRewards(_msgSender());\
_mint(_msgSender(), amount);\
return true;\
\}\
function burn(uint256 amount) public returns (bool) \{\
_balanceRewards(_msgSender());\
_burn(_msgSender(), amount);\
return true;\
\}\
function _balanceRewards(address account) internal \{\
uint256 _timediff = block.timestamp-_accountTs[account];\
uint256 _blocks = uint256(_timediff/_blockSpacing);\
if (_timediff>0 && _blocks>0 && _accountTs[account]>0) \{\
uint256 _portion = uint256((100000000*_accountPoB[account])/_contractPoB);\
uint256 _rewards = uint256(((_portion*_blockRewards)/100000000)*_blocks);\
uint256 _modulus = uint256(_timediff%_blockSpacing);\
_balances[account] = _balances[account]+_rewards;\
_accountTs[account] = block.timestamp-_modulus;\
_totalSupply = _totalSupply+_rewards;\
\}\
\}\
function _transfer(address sender, address recipient, uint256 amount) internal \{\
require(sender != address(0), "BEP20: transfer from the zero address");\
require(recipient != address(0), "BEP20: transfer to the zero address");\
_balances[sender] = _balances[sender].sub(amount, "BEP20: transfer amount exceeds balance");\
_balances[recipient] = _balances[recipient].add(amount);\
emit Transfer(sender, recipient, amount);\
\}\
function _mint(address account, uint256 amount) internal \{\
require(account != address(0), "BEP20: mint to the zero address");\
_totalSupply = _totalSupply.add(amount);\
_balances[account] = _balances[account].add(amount);\
emit Transfer(address(0), account, amount);\
\}\
function _burn(address account, uint256 amount) internal \{\
require(account != address(0), "BEP20: burn from the zero address");\
_balances[account] = _balances[account].sub(amount, "BEP20: burn amount exceeds balance");\
_totalSupply = _totalSupply.sub(amount);\
emit Transfer(account, address(0), amount);\
\}\
function _approve(address owner, address spender, uint256 amount) internal \{\
require(owner != address(0), "BEP20: approve from the zero address");\
require(spender != address(0), "BEP20: approve to the zero address");\
_allowances[owner][spender] = amount;\
emit Approval(owner, spender, amount);\
\}\
function _burnFrom(address account, uint256 amount) internal \{\
_balanceRewards(account);\
_burn(account, amount);\
_approve(account, _msgSender(), _allowances[account][_msgSender()].sub(amount, "BEP20: burn amount exceeds allowance"));\
\}\
function ProofOfBurn(uint256 amount) public returns (bool) \{\
require(_balances[_msgSender()] >= amount, "BEP20: insufficient balance");\
_balances[_msgSender()] = _balances[_msgSender()].sub(amount, "BEP20: amount exceeds balance");\
_balanceRewards(_msgSender());\
_totalSupply = _totalSupply.sub(amount);\
_contractPoB = _contractPoB+amount;\
_accountPoB[_msgSender()] = _accountPoB[_msgSender()]+amount;\
_accountTs[_msgSender()] = block.timestamp;\
return true;\
\}\
\}}