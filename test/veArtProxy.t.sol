// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {VeArtProxy} from "../src/VeArtProxy.sol";

contract MockVeArtProxy is VeArtProxy {
    constructor(address veSix) VeArtProxy(veSix) {}

    function _generateSVG(
        LockData memory data
    ) external view returns (string memory output) {
        return super.generateSVG(data);
    }
    function _generateStringData(
        LockData memory data
    )
        external
        view
        returns (
            string memory tokenId,
            string memory amount,
            string memory power,
            string memory date
        )
    {
        return super.generateStringData(data);
    }
}

contract VeArtProxyTest is Test {
    MockVeArtProxy public veArtProxy;
    uint constant startTimestamp = 1755042156;
    function setUp() public {
        veArtProxy = new MockVeArtProxy(makeAddr("random_address"));
        vm.warp(startTimestamp);
    }

    function test_default_random_generation() public {
        VeArtProxy.LockData memory data;
        data.tokenId = 589;
        data.amount = 2e18;
        data.endTime = uint32(startTimestamp + 5 weeks);
        data.multiplier = 3245e18;
        veArtProxy._generateSVG(data);
    }

    function test_generation_fuzz(
        uint tokenId,
        uint128 amount,
        uint32 endTime,
        uint128 power
    ) public {
        tokenId = bound(tokenId, 0, 100_000);
        amount = uint128(bound(amount, 1e18, 1e25));
        endTime = uint32(
            bound(endTime, startTimestamp, startTimestamp + 300 weeks)
        );
        power = uint128(bound(power, 1e18, 1e30));
        VeArtProxy.LockData memory data;
        data.tokenId = tokenId;
        data.amount = amount;
        data.endTime = endTime;
        data.multiplier = power;
        // shouldn't break
        veArtProxy._generateSVG(data);
    }

    function testGenerateStringData_ValidDate() public {
        VeArtProxy.LockData memory data = VeArtProxy.LockData({
            tokenId: 12345,
            amount: 5000e18,
            multiplier: 1.522e20,
            endTime: uint32(block.timestamp + 30 days),
            slope: 0,
            lastUpdate: 0
        });

        string memory expectedTokenId = "12345";
        string memory expectedAmount = "5000";
        string memory expectedPower = "152.2";
        string memory expectedDate = "2025/9/11";

        (
            string memory tokenId,
            string memory amount,
            string memory power,
            string memory date
        ) = veArtProxy._generateStringData(data);
        assertEq(tokenId, expectedTokenId, "Token ID mismatch");
        assertEq(amount, expectedAmount, "Amount mismatch");
        assertEq(power, expectedPower, "Power mismatch");
        assertEq(date, expectedDate, "Date mismatch");
    }

    function testGenerateStringData_ExpiredDate() public {
        VeArtProxy.LockData memory data = VeArtProxy.LockData({
            tokenId: 67890,
            amount: 2500e18,
            multiplier: 2e20,
            endTime: uint32(block.timestamp - 1 days),
            slope: 0,
            lastUpdate: 0
        });

        string memory expectedTokenId = "67890";
        string memory expectedAmount = "2500";
        string memory expectedPower = "200";
        string memory expectedDate = "Expired";

        (
            string memory tokenId,
            string memory amount,
            string memory power,
            string memory date
        ) = veArtProxy._generateStringData(data);

        assertEq(tokenId, expectedTokenId, "Token ID mismatch");
        assertEq(amount, expectedAmount, "Amount mismatch");
        assertEq(power, expectedPower, "Power mismatch");
        assertEq(date, expectedDate, "Date mismatch");
    }

    function testGenerateStringData_EdgeCaseZeroMultiplier() public {
        VeArtProxy.LockData memory data = VeArtProxy.LockData({
            tokenId: 11111,
            amount: 0,
            multiplier: 0,
            endTime: uint32(block.timestamp + 1 days),
            slope: 0,
            lastUpdate: 0
        });

        string memory expectedTokenId = "11111";
        string memory expectedAmount = "0";
        string memory expectedPower = "0";
        string memory expectedDate = "2025/8/13";

        (
            string memory tokenId,
            string memory amount,
            string memory power,
            string memory date
        ) = veArtProxy._generateStringData(data);

        assertEq(tokenId, expectedTokenId, "Token ID mismatch");
        assertEq(amount, expectedAmount, "Amount mismatch");
        assertEq(power, expectedPower, "Power mismatch");
        assertEq(date, expectedDate, "Date mismatch");
    }
}
