
# UniswapV3-implementation
A uniswapV3 playground for learning pruposes.

## UniswapV3 - liquidity calculations and swap calculations

**price calculation:**

$$\sqrt{P}=\sqrt{y/x}$$

**tick calculation:**

$$i=\log_{\sqrt{1.0001}}\sqrt{P}$$

**range calculation:**

Uniswap uses Q64.96 number to store the price(sqrtPriceX96)
therefore:

$$ sqrtPriceX96 = sqrtPrice * 2^{96}$$


