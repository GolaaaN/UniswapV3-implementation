// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.6;

import "forge-std/Test.sol";
import "../src/BlueToken.sol";
import "../src/RedToken.sol";
import "../uniswap-v3-core/contracts/UniswapV3Factory.sol"; //factory;
import "../uniswap-v3-core/contracts/UniswapV3Pool.sol"; //pool
import "../uniswap-v3-core/contracts/interfaces/callback/IUniswapV3MintCallback.sol";
import "../uniswap-v3-core/contracts/interfaces/callback/IUniswapV3SwapCallback.sol";

contract UniswapTest is Test, IUniswapV3MintCallback {
    address public redToken;
    address public blueToken;
    UniswapV3Factory public factory;
    UniswapV3Pool testPool;
    uint24 public constant fee = 3000;
    uint24 tickLower;
    uint24 tickUpper;

    function setUp() public {
        //create two tokens
        redToken = new RedToken("RED", "RED", 10);
        blueToken = new BlueToken("BLUE", "BLU", 10);

        //create factory
        factory = new UniswapV3Factory();
        testPool = factory.createPool(redToken, blueToken, fee);
    }

    function testSwap() public {
        //after the deployment of the factory we create pool with our tokens and 0.3% fees

        testPool.mint(msg.sender, tickLower, tickUpper, 100, " ");

        testPool.swap();
    }

    function uniswapV3MintCallback(
        uint256 amount0Owed,
        uint256 amount1Owed,
        bytes calldata data
    ) external override {
        //approve the pool to spend our tokens.
        token0.approve(testPool, 10);
        token1.approve(testPool, 10);
        //transfer tokens to the pool adter init the liq.
        token0.transfer(testPool, 10);
        token1.transfer(testPool, 10);
    }
}
