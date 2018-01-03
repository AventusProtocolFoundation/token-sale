/// stop.t.sol -- test for stop.sol

// Copyright (C) 2017  DappHub, LLC

// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND (express or implied).

pragma solidity ^0.4.10;

import "ds-test/test.sol";

import "./stop.sol";

contract User {

    TestThing thing;

    function User(TestThing thing_) {
        thing = thing_;
    }

    function doToggle() {
        thing.toggle();
    }

    function doStop() {
        thing.stop();
    }

    function doStart() {
        thing.start();
    }
}

contract TestThing is DSStop {

    bool public x;

    function toggle() stoppable {
        x = x ? false : true;
    }
}

contract DSStopTest is DSTest {

    TestThing thing;
    User user;

    function setUp() {
        thing = new TestThing();
        user = new User(thing);
    }

    function testSanity() {
        thing.toggle();
        assert(thing.x());
    }

    function testFailStop() {
        thing.stop();
        thing.toggle();
    }

    function testFailStopUser() {
        thing.stop();
        user.doToggle();
    }

    function testStart() {
        thing.stop();
        thing.start();
        thing.toggle();
        assert(thing.x());
    }

    function testStartUser() {
        thing.stop();
        thing.start();
        user.doToggle();
        assert(thing.x());
    }

    function testFailStopAuth() {
        user.doStop();
    }

    function testFailStartAuth() {
        user.doStart();
    }
}