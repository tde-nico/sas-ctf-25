from z3 import *

def small_hash(b: list[BitVecRef]) -> BitVecRef:
    """
    b : list of 8 Z3 8-bit variables
    returns a 64-bit bit-vector
    """
    # little-endian pack
    block = Concat(b[7], b[6], b[5], b[4], b[3], b[2], b[1], b[0])
    lo    = Extract(31, 0,  block)
    hi    = Extract(63, 32, block)

    K  = [ 0xf00dbabe,  0xdeadbeef,  0xbadc0ffe,  0xfeedface ] # round keys
    C  = 0x45d9f3b # avalanche mul

    C  = BitVecVal(C, 32)
    Ks = [BitVecVal(k, 32) for k in K]
    for k in Ks:
        v  = lo ^ k
        v  = RotateLeft(v, 5)
        v  = v * C
        v  = v ^ LShR(v, 16)
        lo, hi = (hi ^ v), lo # feed-back & swap

    return Concat(hi, lo)


code = [BitVec(f'b{i}', 8) for i in range(8)]

s = Solver()
s.add(small_hash(code) == 0x16c11e3b4fe39c85) # 0x16c11e3b4fe39c85

if s.check() == sat:
    m = s.model()
    result = bytes([m[b].as_long() for b in code])
    print(result)  # b'Qy=*}OV('

# SAS{h00t_h00t_7h1s_6uy_w1ll_c0v3r_th3_c0st5_9f03fd}
