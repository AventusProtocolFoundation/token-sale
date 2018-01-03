pragma solidity ^0.4.11;

import "./Whitelist.sol";
import "ds-token/token.sol";
import "ds-exec/exec.sol";
import "ds-auth/auth.sol";
import "ds-note/note.sol";
import "ds-math/math.sol";

contract AVTSale is DSMath, DSNote, DSExec {
    Whitelist public whitelist;
    DSToken public avt;

    // AVT PRICES (ETH/AVT)
    uint public constant PRIVATE_SALE_PRICE = 110;
    uint public constant WHITELIST_SALE_PRICE = 92;
    uint public constant PUBLIC_SALE_PRICE = 92;

    uint128 public constant CROWDSALE_SUPPLY = 10000000 ether;
    uint public constant LIQUID_TOKENS = 2500000 ether;
    uint public constant ILLIQUID_TOKENS = 1500000 ether;

    // PURCHASE LIMITS
    uint public constant PRIVATE_SALE_LIMIT = 3000000 ether;
    uint public constant WHITELIST_SALE_LIMIT = 5000000 ether;
    uint public constant PUBLIC_SALE_LIMIT = 6000000 ether;

    uint public privateStart;
    uint public whitelistStart;
    uint public publicStart;
    uint public publicEnd;

    address public aventus;
    address public privateBuyer;

    uint public sold;


    function AVTSale(uint privateStart_, address aventus_, address privateBuyer_, Whitelist whitelist_) {
        avt = new DSToken("AVT");
        
        aventus = aventus_;
        privateBuyer = privateBuyer_;
        whitelist = whitelist_;
        
        privateStart = privateStart_;
        whitelistStart = privateStart + 2 days;
        publicStart = whitelistStart + 1 days;
        publicEnd = publicStart + 7 days;

        avt.mint(CROWDSALE_SUPPLY);
        avt.setOwner(aventus);
        avt.transfer(aventus, LIQUID_TOKENS);
    }

    // overrideable for easy testing
    function time() constant returns (uint) {
        return now;
    }

    function() payable note {
        var (rate, limit) = getRateLimit();

        uint prize = mul(msg.value, rate);

        assert(add(sold, prize) <= limit);

        sold = add(sold, prize);

        avt.transfer(msg.sender, prize);
        exec(aventus, msg.value); // send the ETH to multisig
    }

    function getRateLimit() private constant returns (uint, uint) {
        uint t = time();

        if (t >= privateStart && t < whitelistStart) {
            assert (msg.sender == privateBuyer);

            return (PRIVATE_SALE_PRICE, PRIVATE_SALE_LIMIT);
        }
        else if (t >= whitelistStart && t < publicStart) {
            uint allowance = whitelist.accepted(msg.sender);

            assert (allowance >= msg.value);

            whitelist.accept(msg.sender, allowance - msg.value);

            return (WHITELIST_SALE_PRICE, WHITELIST_SALE_LIMIT);
        }
        else if (t >= publicStart && t < publicEnd)
            return (PUBLIC_SALE_PRICE, PUBLIC_SALE_LIMIT);

        throw;
    }

    function claim() {
        assert(time() >= publicStart + 1 years);

        avt.transfer(aventus, ILLIQUID_TOKENS);
    }
}
