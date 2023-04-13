// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.6;
pragma abicoder v2;

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
        red = new RedToken("RED", "RED", 15);
        blue = new BlueToken("BLUE", "BLU", 15);

        //create factory
        factory = new UniswapV3Factory();
        testPool = UniswapV3Pool(
            factory.createPool(address(red), address(blue), fee)
        );
    }

    function testSwap() public {
        //after the deployment of the factory we create pool with our tokens and 0.3% fees

        testPool.mint(msg.sender, tickLower, tickUpper, 100, "");

        testPool.swap(msg.sender, true, 5, 0, " ");
    }

    function uniswapV3SwapCallback(
        int256 amount0Delta,
        int256 amount1Delta,
        bytes calldata data
    ) external override {
        //approve the pool to spend our tokens.
        red.approve(address(testPool), uint256(amount0Delta));
        blue.approve(address(testPool), uint256(amount1Delta));
        //transfer tokens to the pool adter init the liq.
        red.transfer(address(testPool), uint256(amount0Delta));
        blue.transfer(address(testPool), uint256(amount1Delta));
    }

    function uniswapV3MintCallback(
        uint256 amount0Owed,
        uint256 amount1Owed,
        bytes calldata data
    ) external override {
        //approve the pool to spend our tokens.
        red.approve(address(testPool), amount0Owed);
        blue.approve(address(testPool), amount0Owed);
        //transfer tokens to the pool adter init the liq.
        red.transfer(address(testPool), amount1Owed);
        blue.transfer(address(testPool), amount1Owed);
    }
}
