// // Copyright (C) 2017 DappHub, LLC

// pragma solidity ^0.4.11;

// import "ds-test/test.sol";
// import "ds-exec/exec.sol";
// import "ds-token/token.sol";

// import "./AvtSale.sol";

// contract AVTSaleUser is DSExec {

//     AVTSale sale;
//     DSToken avt;

//     function AVTSaleUser(AVTSale sale_) {
//         sale = sale_;
//         avt = sale.avt();
//     }

//     function() payable {}

//     function doBuy(uint wad) {
//         exec(sale, wad);
//     }
// }

// contract AVTOwner {

//     DSToken avt;

//     function AVTOwner() {}

//     function setAVT(DSToken avt_) {
//         avt = avt_;
//     }

//     function doStop() {
//         avt.stop();
//     }

//     function() payable {}
// }

// contract TestableAVTSale is AVTSale {

//     function TestableAVTSale(uint time, uint privateStart, uint publicStart, address aventus, address privateBuyer) 
//     AVTSale(privateStart, publicStart, aventus, privateBuyer) {
//         localTime = time;
//     }

//     uint public localTime;

//     function time() constant returns (uint) {
//         return localTime;
//     }

//     function addTime(uint extra) {
//         localTime += extra;
//     }
// }

// contract AVTSaleTest is DSTest, DSExec {
//     TestableAVTSale sale;
//     DSToken avt;
//     AVTOwner aventus;

//     AVTSaleUser user1;


//     function setUp() {
//         aventus = new AVTOwner();
//         sale = new TestableAVTSale(now, now + 1 days, aventus, this);
//         avt = sale.avt();

//         aventus.setAVT(avt);

//         user1 = new AVTSaleUser(sale);
//         exec(user1, 10 ether);
//     }

//     function testTokenOwnership() {
//         aventus.doStop();
//     }

//     function testFoundersLiquidReward() {
//         assertEq(avt.balanceOf(aventus), 1500000 ether);
//     }

//     function testFailClaim() {
//         sale.claim();
//     }

//     function testClaim() {
//         assertEq(avt.balanceOf(aventus), 1500000 ether);
//         sale.addTime(1 days);
//         sale.addTime(1 years);
//         sale.claim();
//         assertEq(avt.balanceOf(aventus), 4000000 ether);
//     }

//     function testPrivateBuy() {
//         exec(sale, 10 ether);
//         assertEq(avt.balanceOf(this), 1100 ether);
//         assertEq(aventus.balance, 10 ether);
//     }

//     function testFailPrivateBuy() {
//         user1.doBuy(9 ether);
//     }

//     function testPublicBuy() {
//         sale.addTime(1 days);
//         user1.doBuy(9 ether);
//         assertEq(avt.balanceOf(user1), 828 ether);
//         assertEq(aventus.balance, 9 ether);

//         exec(sale, 11 ether);
//         assertEq(avt.balanceOf(this), 1012 ether);
//         assertEq(aventus.balance, 20 ether);
//     }

//     // tries to buy 6,000,056 AVT, 
//     // which is greater than PUBLIC_SALE_LIMIT
//     function testFailPublicBuyTooMuch() {
//         sale.addTime(1 days);
//         exec(sale, 65218 ether); 
//     }

//     function testFailClosedSaleLimit() {
//         exec(sale, 27273 ether);
//     }

//     function testFailStartTooEarly() {
//         sale = new TestableAVTSale(now, now + 1 days, now + 2 days, aventus, this);
//         exec(sale, 10 ether);
//     }

//     function testFailBuyAfterClose() {
//         sale.addTime(7 days);
//         exec(sale, 10 ether);
//     }

//     function testFailInitializeWrong() {
//         sale = new TestableAVTSale(now, now + 2 days, now + 1 days, aventus, this);
//     }
// }
