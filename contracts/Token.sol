// Solidity files have to start with this pragma.
// It will be used by the Solidity compiler to validate its version.
pragma solidity 0.8.11;


import "hardhat/console.sol";


// This is the main building block for smart contracts.
// tx link
// https://rinkeby.etherscan.io/address/0xB49E2fDB0BDf2c2B60900bB5C3680aF818C5dd2d
contract Token {
    // Some string type variables to identify the token.
    // The `public` modifier makes a variable readable from outside the contract.
    string public name = "Token One";
    string public symbol = "TKO";

    // The fixed amount of tokens stored in an unsigned integer type variable.
    uint256 public totalSupply = 500000000;

    // An address type variable is used to store ethereum accounts.
    address public owner;

    // A mapping is a key/value map. Here we store each account balance.
    mapping(address => uint256) balances;

    // allowances
    // spender => allower => amount
    mapping( address=> mapping( address => uint256 ) ) allowances;


    // events
    event Transfer(address indexed _from, address indexed _to, uint256 _amount);
    event Approval(address indexed _from, address indexed _to, uint256 _amount);


    /**
     * Contract initialization.
     *
     * The `constructor` is executed only once when the contract is created.
     */
    constructor() {
        // The totalSupply is assigned to transaction sender, which is the account
        // that is deploying the contract.
        balances[msg.sender] = totalSupply;
        owner = msg.sender;
    }



    modifier onlyOwner() {
        require(msg.sender == owner, "Only Owner");
        _;
    }


    function mint(address to, uint256 amount) onlyOwner external returns(bool) {
        require(to != address(0), "Cant mint to address 0");

        balances[to] += amount;
        return true;
    }


    /**
     * A function to transfer tokens.
     *
     * The `external` modifier makes a function *only* callable from outside
     * the contract.
     */
    function transfer(address to, uint256 amount) external returns(bool) {
        console.log("Sender balance is %s tokens", balances[msg.sender]);
        console.log("Trying to send %s tokens to %s", amount, to);
        // Check if the transaction sender has enough tokens.
        // If `require`'s first argument evaluates to `false` then the
        // transaction will revert.
        require(balances[msg.sender] >= amount, "Not enough tokens");

        // Transfer the amount.
        balances[msg.sender] -= amount;
        balances[to] += amount;

        emit Transfer(to, msg.sender, amount);

        return true;
    }


    /**
     * Read only function to retrieve the token balance of a given account.
     *
     * The `view` modifier indicates that it doesn't modify the contract's
     * state, which allows us to call it without executing a transaction.
     */
    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }



    function allowance(address _owner, address spender) external view returns(uint256) {
        return allowances[spender][_owner];
    }

    function approve(address spender, uint256 amount) external returns(bool) {
        // ensure approval is not to 0x address
        require(spender != address(0), "Spender cant be Zero address");
        
        // ensure account has enough balance
        require(balances[msg.sender] >= amount, "Not enough balance");

        allowances[spender][msg.sender] += amount;

        emit Transfer(spender, msg.sender, amount);

        return true;
    }



}