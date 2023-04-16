// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.6;
pragma abicoder v2;

import "../uniswap-v3-core/contracts/Strings.sol";
import "forge-std/Test.sol";
import "../src/BlueToken.sol";
import "../src/RedToken.sol";
import "../uniswap-v3-core/contracts/UniswapV3Factory.sol"; //factory;
import "../uniswap-v3-core/contracts/UniswapV3Pool.sol"; //pool
import "../uniswap-v3-core/contracts/interfaces/callback/IUniswapV3MintCallback.sol";
import "../uniswap-v3-core/contracts/interfaces/callback/IUniswapV3SwapCallback.sol";

contract UniswapTest is Test, IUniswapV3MintCallback, IUniswapV3SwapCallback {
    RedToken red;
    BlueToken blue;
    address public token0;
    address public token1;
    UniswapV3Factory public factory;
    UniswapV3Pool testPool;
    uint24 public constant fee = 3000;
    int24 tickLower;
    int24 tickUpper;

    function setUp() public {
        //create two tokens
        red = new RedToken("RED", "RED", 5042 ether);
        blue = new BlueToken("BLUE", "BLU", 1 ether);

        //create factory
        factory = new UniswapV3Factory();
        testPool = UniswapV3Pool(
            factory.createPool(address(red), address(blue), fee)
        );
    }

    function testSwap() public {
        //after the deployment of the factory we create pool with our tokens and 0.3% fees
        testPool.initialize(5602277097478614198912276234240);
        testPool.mint(msg.sender, 84000, 87000, 1517882343751509868544, "");

        testPool.swap(
            address(this),
            false,
            42,
            5604469350942327889444743441197,
            ""
        );

        //require(false, Strings.toString(red.balanceOf(address(this))));
        require(false, Strings.toString(blue.balanceOf(address(this))));
    }

    function uniswapV3SwapCallback(
        int256 amount0Delta,
        int256 amount1Delta,
        bytes calldata data
    ) external override {
        (address token0, address token1) = address(red) < address(blue)
            ? (address(red), address(blue))
            : (address(blue), address(red));
        //require(false, "hi");
        //approve the pool to spend our tokens.
        RedToken(token0).approve(address(testPool), uint256(amount0Delta));
        BlueToken(token1).approve(address(testPool), uint256(amount1Delta));
        //transfer tokens to the pool adter init the liq.
        RedToken(token0).transfer(address(testPool), uint256(amount0Delta));
        BlueToken(token1).transfer(address(testPool), uint256(amount1Delta));
    }

    function uniswapV3MintCallback(
        uint256 amount0Owed,
        uint256 amount1Owed,
        bytes calldata data
    ) external override {
        (address token0, address token1) = address(red) < address(blue)
            ? (address(red), address(blue))
            : (address(blue), address(red));
        //require(false, "hi");
        //approve the pool to spend our tokens.
        RedToken(token0).approve(address(testPool), amount0Owed);
        BlueToken(token1).approve(address(testPool), amount1Owed);
        //transfer tokens to the pool adter init the liq.
        RedToken(token0).transfer(address(testPool), amount0Owed);
        BlueToken(token1).transfer(address(testPool), amount1Owed);
    }
}
