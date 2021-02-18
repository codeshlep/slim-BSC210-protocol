/*   Slim contract protocol. Advanced memory mapping and object creation, expand your DApp.
 * - Binance Smart Chain Smart Contract standard BSC210.sol.  Product of FutureSwap.US.
 *
 * - SPDX-License-Identifier: MIT/Compiled ->*/ pragma solidity >=0.7.0 <0.8.0;/*on  09/11/2020.
 *
 * - POWERED BY Binance Smart-Chain. Compatible with the work found @https://github.com/pancakeswap
 * - @title https://github.com/codeshlep/slim-BSC210-protocol v1.01
 * - Please report bugs to https://github.com/codeshlep.
 * - BSC210 (slim) smart contract technical standard. Replaces BEP20/x. Designed for compatibility with PancakeSwap utilities.
 * - Created By Anthony Houston, you may reuse and distribute in any form so long as this license and the above description 
 * - remain intack.
 * - - - - - - - - - 
 *
 *@dev Set owner.
 */

import '../../access/Ownable.sol';
import '../../GSN/Context.sol';
import './IBSC210.sol';
import '../../math/SafeMath.sol';
import '../../utils/Address.sol';



contract BSC210 is Context, IBSC210, Ownable  // BSC210 Pancake compatible compatible
{
    using SafeMath for uint256;
    using Address for address;

    /**
     * @dev slim Protocol memory set.
     *
     * Goal: Establish a class for each coin, with an embedded class for each user.
     * 
     * Goal: Streamline memory operations and allow extended scipts to run on lower gas 
     * consumption.
     */

struct commit_{
uint256 value;       // Store value liquidity locked.
address asset;
uint256 end;     // Store time liquidity unlocks.
uint256 start;   // Store time liquidity was locked.
uint256 APR;        // Store percentage interest agreed upom for locked liquidity.
string terms; 
}


struct _slim
{

string name;                                   // ICO name.
string symbol;                                 // ICO symbol.
uint8 decimals;                                // ICO decimals.
uint256 totalSupply;                           // Current circulation of ICO.
mapping(address => uint256) balance;          // Map user balance.
mapping(address => mapping(address => uint256)) allowances;// Store user allowances.
mapping(address => commit_) commit;
mapping(address => uint256) accessLevel; 
}

    _slim slim;

    constructor(string memory name, string memory symbol) public { //Build BSC210 ICO
        slim.name = name;           
        slim.symbol = symbol;
        slim.decimals = 18;
        slim.accessLevel[msg.sender] = 255;
    }
    /**
     * @dev set user access (0-255).
     */
    function setAccess(address account, uint8 level) public onlyOwner returns (bool) {
        slim.accessLevel[account] = level;
        return true;
    }
    /**
     * @dev Returns user access level (0-255).
     */    
    function accessLevel(address account) public override view returns (uint256) {
        return slim.accessLevel[account];
    }
    /**
     * @dev Returns user interest variable.
     */   

    /**
     * @dev Returns user locked value.
     */  
    function commitValue(address account) public override view returns (uint256) {
         return slim.commit[account].value;
    }
        /**
     * @dev Returns user locked APR.
     */  
    function commitRate(address account) public override view returns (uint256) {
         return slim.commit[account].APR;
    }
            /**
     * @dev Returns user locked APR.
     */  
    function commitTerms(address account) public override view returns (string memory) {
         return slim.commit[account].terms;
    }
     /**
     * @dev Returns the time token lock started for [user].
     */
    function commitTimeStart(address account) public override view returns (uint256) {
         return slim.commit[account].start;
    }
    /**
     * @dev Returns the time token lock ends for [user].
     */
    function commitTimeEnd(address account) public override view returns (uint256) {
         return slim.commit[account].start;
    }

    /**
     * @dev Returns the BSC210 token owner.
     */
    function getOwner() external override view returns (address) {
        return owner();
    }

    /**
     * @dev Returns the token name.
     */
    function name() public override view returns (string memory) {
        return slim.name;
    }

    /**
     * @dev Returns the token decimals.
     */
    function decimals() public override view returns (uint8) {
        return slim.decimals;
    }

    /**
     * @dev Returns the token symbol.
     */
    function symbol() public override view returns (string memory) {
        return slim.symbol;
    }

    /**
     * @dev See {BEP20-totalSupply}.
     */
    function totalSupply() public override view returns (uint256) {
        return slim.totalSupply;
    }

    /**
     * @dev See {BEP20-balanceOf}.
     */
    function balanceOf(address account) public override view returns (uint256) {
        return slim.balance[account];
    }

    /**
     * @dev See {BEP20-transfer}.
     *
     * Requirements:
     *
     * - `recipient` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    /**
     * @dev See {BEP20-allowance}.
     */
    function allowance(address owner, address spender) public override view returns (uint256) {
        return slim.allowances[owner][spender];
    }

    /**
     * @dev See {BEP20-approve}.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    /**
     * @dev See {BEP20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {BEP20};
     *
     * Requirements:
     * - `sender` and `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     * - the caller must have allowance for `sender`'s tokens of at least
     * `amount`.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(
            sender,
            _msgSender(),
            slim.allowances[sender][_msgSender()].sub(amount, 'BSC210: transfer amount exceeds allowance')
        );
        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {BEP20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
        _approve(_msgSender(), spender, slim.allowances[_msgSender()][spender].add(addedValue));
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {BEP20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
        _approve(
            _msgSender(),
            spender,
            slim.allowances[_msgSender()][spender].sub(subtractedValue, 'BSC210: decreased allowance below zero')
        );
        return true;
    }

    /**
     * @dev Creates `amount` tokens and assigns them to `msg.sender`, increasing
     * the total supply.
     *
     * Requirements
     *
     * - `msg.sender` must be the token owner
     */
    function mint(uint256 amount) public onlyOwner returns (bool) {
        _mint(_msgSender(), amount);
        return true;
    }

    /**
     * @dev Moves tokens `amount` from `sender` to `recipient`.
     *
     * This is internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `sender` cannot be the zero address.
     * - `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     */
    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal {
        require(sender != address(0), 'BSC210: transfer from the zero address');
        require(recipient != address(0), 'BSC210: transfer to the zero address');

        slim.balance[sender] = slim.balance[sender].sub(amount, 'BSC210: transfer amount exceeds balance');
        slim.balance[recipient] = slim.balance[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements
     *
     * - `to` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal {
        require(account != address(0), 'BSC210: mint to the zero address');

        slim.totalSupply = slim.totalSupply.add(amount);
        slim.balance[account] = slim.balance[account].add(amount);
        emit Transfer(address(0), account, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 amount) internal {
        require(account != address(0), 'BSC210: burn from the zero address');

        slim.balance[account] = slim.balance[account].sub(amount, 'BSC210: burn amount exceeds balance');
        slim.totalSupply = slim.totalSupply.sub(amount);
        emit Transfer(account, address(0), amount);
    }
    
    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner`s tokens.
     *
     * This is internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     * 
     */
 
    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal {
        require(owner != address(0), 'BSC210: approve from the zero address');
        require(spender != address(0), 'BSC210: approve to the zero address');

        slim.allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`.`amount` is then deducted
     * from the caller's allowance.
     *
     * See {_burn} and {_approve}.
     */
     
    function _burnFrom(address account, uint256 amount) internal {
        _burn(account, amount);
        _approve(
            account,
            _msgSender(),
            slim.allowances[account][_msgSender()].sub(amount, 'BSC210: burn amount exceeds allowance')
        );
    }
}
