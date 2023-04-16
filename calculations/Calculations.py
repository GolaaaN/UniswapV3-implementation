import math

#########################################################
#---calculations python script from uniswapv3book.com---#
#########################################################






q96 = 2**96
eth = 10**18
#functions:
def price_to_tick(p):
    return math.floor(math.log(p, 1.0001))


def price_to_sqrtp(p):
    return int(math.sqrt(p) * q96)


def liquidity0(amount, pa, pb):
    if pa > pb:
        pa, pb = pb, pa
    return (amount * (pa * pb) / q96) / (pb - pa)


def liquidity1(amount, pa, pb):
    if pa > pb:
        pa, pb = pb, pa
    return amount * q96 / (pb - pa)

def liquidity(amount, pa, pb):
    return int(min(liquidity0(amount, pa, pb), liquidity1(amount, pa, pb)))


def calc_amount0(liq, pa, pb):
    if pa > pb:
        pa, pb = pb, pa
    return int(liq * q96 * (pb - pa) / pa / pb)


def calc_amount1(liq, pa, pb):
    if pa > pb:
        pa, pb = pb, pa
    return int(liq * (pb - pa) / q96)

