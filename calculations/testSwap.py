import Calculations 
import math

def testSwap(amount0 ,amount1, upper, lower):

    print("Lower Tick: " + str(int(Calculations.price_to_tick(lower) - Calculations.price_to_tick(lower) % 60)))
    print("Current Tick: " + str(int(Calculations.price_to_tick(amount1))))
    print("Upper Tick: " + str(int(Calculations.price_to_tick(upper) -Calculations.price_to_tick(upper) % 60) + 60))
    print("sqrtPriceX96: " + str(int(Calculations.price_to_sqrtp(amount1))))
    sqrtp_low = Calculations.price_to_sqrtp(lower)
    sqrtp_cur = Calculations.price_to_sqrtp(amount1)
    sqrtp_upp = Calculations.price_to_sqrtp(upper)
    token0_amt = amount0 * Calculations.eth
    token1_amt = amount1 * Calculations.eth
    liq = int(min(Calculations.liquidity0(token0_amt, sqrtp_cur, sqrtp_upp), Calculations.liquidity1(token1_amt, sqrtp_cur, sqrtp_low)))
    print("Liquidity: ", str(liq))
    print("Amount0: ", str(Calculations.calc_amount0(liq, sqrtp_upp, sqrtp_cur)))
    print("Amount1: ", str(Calculations.calc_amount1(liq, sqrtp_low, sqrtp_cur)))
    print("------------------------------------")

    amount_in = 42 * Calculations.eth
    price_diff = (amount_in * Calculations.q96) // liq
    price_next = sqrtp_cur + price_diff
    
    print("New price: ", (price_next / Calculations.q96) ** 2)
    print("New sqrtP: ", price_next)
    print("New tick:", Calculations.price_to_tick((price_next / Calculations.q96) ** 2))
    amount_in = Calculations.calc_amount1(liq, price_next, sqrtp_cur)
    amount_out = Calculations.calc_amount0(liq, price_next, sqrtp_cur)
    print("USDC in:", amount_in / Calculations.eth)
    print("ETH out:", amount_out / Calculations.eth)
    print(price_next, liq, sqrtp_cur)
    print(amount_in, amount_out)

testSwap(1, 5000, 5500, 4545)
    
