
# UniswapV3-implementation
A uniswapV3 playground for learning pruposes.

## UniswapV3 - formulas and calculations

**price formula:**

$$\sqrt{P}=\sqrt{y/x} $$
where is x is token0 amount and y is token1 amount.

**tick formula:**

$$i=\log_{\sqrt{1.0001}}\sqrt{P}$$

**range formula:**

Uniswap uses Q64.96 number to store the price(sqrtPriceX96)
therefore:

$$ sqrtPriceX96 = sqrtPrice * 2^{96}$$

**liquidity formulas:**

$$L = \sqrt{xy}$$

$$L=\Delta{x}{\sqrt{P_b}\sqrt{P_c} \over \sqrt{P_c}-\sqrt{P_a}}$$

$$L={\Delta{y} \over \sqrt{P_c} - \sqrt{P_a}}$$

**amounts formulas:**

$$\Delta{x} = {L(\sqrt{P_b}-\sqrt{P_c}) \over \sqrt{P_b}\sqrt{P_c}}$$

$$\Delta{y} = L(\sqrt{P_c}-\sqrt{P_a})$$



