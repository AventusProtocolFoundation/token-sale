// Copyright (C) 2015, 2016, 2017  DappHub, LLC

// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND (express or implied).

pragma solidity ^0.4.8;

import "ds-test/test.sol";
import "./math.sol";

contract DSMathTest is DSTest, DSMath {
    
    // uint256 tests

    function testFail_add() {
        add(2 ** 256 - 1, 1);
    }
    function test_add() {
        assertEq(uint(add(0, 0)), 0);
        assertEq(uint(add(0, 1)), 1);
        assertEq(uint(add(1, 1)), 2);
    }

    function testFail_sub() {
        sub(0, 1);
    }
    function test_sub() {
        assertEq(uint(sub(0, 0)), 0);
        assertEq(uint(sub(1, 1)), 0);
        assertEq(uint(sub(2, 1)), 1);
    }

    function testFail_mul() {
        mul(2 ** 254, 6);
    }

    function test_mul() {
        assertEq(uint(mul(0, 1)), 0);
        assertEq(uint(mul(1, 1)), 1);
        assertEq(uint(mul(2, 1)), 2);
    }

    function testFail_div() {
        div(0, 0);
    }

    function test_div() {
        assertEq(uint(div(0, 1)), 0);
        assertEq(uint(div(1, 1)), 1);
        assertEq(uint(div(4, 2)), 2);
    }

    function test_min() {
        assertEq(uint(min(1, 1)), 1);
        assertEq(uint(min(1, 2)), 1);
    }

    function test_max() {
        assertEq(uint(max(1, 1)), 1);
        assertEq(uint(max(1, 2)), 2);
    }


    // uint128 tests

    function testFail_hadd() {
        hadd(2 ** 128 - 1, 1);
    }
    function test_hadd() {
        assertEq(uint(hadd(0, 0)), 0);
        assertEq(uint(hadd(0, 1)), 1);
        assertEq(uint(hadd(1, 1)), 2);
    }

    function testFail_hsub() {
        hsub(0, 1);
    }
    function test_hsub() {
        assertEq(uint(hsub(0, 0)), 0);
        assertEq(uint(hsub(1, 1)), 0);
        assertEq(uint(hsub(2, 1)), 1);
    }

    function testFail_hmul() {
        hmul(2 ** 128 -1, 2);
    }

    function test_hmul() {
        assertEq(uint(hmul(0, 1)), 0);
        assertEq(uint(hmul(1, 1)), 1);
        assertEq(uint(hmul(2, 1)), 2);
    }

    function testFail_hdiv() {
        hdiv(0, 0);
    }

    function test_hdiv() {
        assertEq(uint(hdiv(0, 1)), 0);
        assertEq(uint(hdiv(1, 1)), 1);
        assertEq(uint(hdiv(4, 2)), 2);
    }

    function test_hmin() {
        assertEq(uint(hmin(1, 1)), 1);
        assertEq(uint(hmin(1, 2)), 1);
    }

    function test_hmax() {
        assertEq(uint(hmax(1, 1)), 1);
        assertEq(uint(hmax(1, 2)), 2);
    }

    // int256 tests

    function test_imin() {
        assertEq(int(imin(1, 1)), 1);
        assertEq(int(imin(1, 2)), 1);
        assertEq(int(imin(1, -2)), -2);
    }

    function test_imax() {
        assertEq(int(imax(1, 1)), 1);
        assertEq(int(imax(1, 2)), 2);
        assertEq(int(imax(1, -2)), 1);
    }

    function testFail_wmul_overflow() {
        wmul(2 ** 128 - 1, 1.0 ether + 1 wei);
    }
    function test_wmul_trivial() {
        assertEq(uint(wmul(2 ** 128 - 1, 1.0 ether)), 2 ** 128 - 1);
        assertEq(uint(wmul(0.0 ether, 0.0 ether)), 0.0 ether);
        assertEq(uint(wmul(0.0 ether, 1.0 ether)), 0.0 ether);
        assertEq(uint(wmul(1.0 ether, 0.0 ether)), 0.0 ether);
        assertEq(uint(wmul(1.0 ether, 1.0 ether)), 1.0 ether);
    }
    function test_wmul_fractions() {
        assertEq(uint(wmul(1.0 ether, 0.2 ether)), 0.2 ether);
        assertEq(uint(wmul(2.0 ether, 0.2 ether)), 0.4 ether);
    }

    function testFail_wdiv_zero() {
        wdiv(1.0 ether, 0.0 ether);
    }
    function test_wdiv_trivial() {
        assertEq(uint(wdiv(0.0 ether, 1.0 ether)), 0.0 ether);
        assertEq(uint(wdiv(1.0 ether, 1.0 ether)), 1.0 ether);
    }
    function test_wdiv_fractions() {
        assertEq(uint(wdiv(1.0 ether, 2.0 ether)), 0.5 ether);
        assertEq(uint(wdiv(2.0 ether, 2.0 ether)), 1.0 ether);
    }

}
