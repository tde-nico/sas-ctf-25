// Decompiled by library.dedaub.com
// 2025.05.24 12:19 UTC
// Compiled using the solidity compiler version 0.8.20





function fallback() public payable { 
    revert();
}

function validate(string flag) public payable { 
    require(4 + (msg.data.length - 4) - 4 >= 32);
    require(flag <= uint64.max);
    require(4 + flag + 31 < 4 + (msg.data.length - 4));
    require(flag.length <= uint64.max);
    require(flag.data + flag.length <= 4 + (msg.data.length - 4));
    v0 = base = MEM[64];
    MEM[64] = 544 + base;
    CALLDATACOPY(base, msg.data.length, 544);
    v2 = base2 = MEM[64];
    MEM[64] = 128 + base2;
    CALLDATACOPY(base2, msg.data.length, 128);
    require(128 - flag.length <= 128, Panic(17)); // arithmetic overflow or underflow
    require(3 < 17, Panic(50)); // access an out-of-bounds or negative index of bytesN array or slice
    MEM[96 + base] = 128 - flag.length;
    require(11 < 17, Panic(50)); // access an out-of-bounds or negative index of bytesN array or slice
    require(12 < 17, Panic(50)); // access an out-of-bounds or negative index of bytesN array or slice
    MEM[384 + base] = flag.length;
    v4 = v5 = 0;
    while (v4 >= flag.length) {
        MEM[base2 + (128 - flag.length) + v4] = flag[v4];
        v4 = v4 + 32;
    }
    // 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffa0030301
    // op = 01
    // val = [a0 03 03][::-1]
    // 0x0000000000000000000000000000000000000000000000000000000058030902
    // op = 02
    // val = [58 03 09][::-1]
    // 0x0000000000000000000000000000000000000000000000000000000060030901
    IP = v7 = 0;
    while (!1) {
        op = uint8(CODE[IP]);
        val = CODE[IP] >> 8;
        
        if (op == 1) { // mem[base + val[0]] = val[2] + mem[base + val[1]]
            MEM[base + (uint8(val) << 5)] = (val >> 8 >> 8 << 196 >> 196) + MEM[base + (uint8(val >> 8) << 5)];
        
        } else if (op == 2) { // mem[base2 + mem[base + val[1]] + val[2]] = u64(mem[base + val[0]]) || u192(mem[base2 + mem[base + val[1]] + val[2]])
            MEM[base2 + (MEM[base + (uint8(val >> 8) << 5)] + (val >> 8 >> 8))] = MEM[base + (uint8(val) << 5)] << 192 | uint192(MEM[base2 + (MEM[base + (uint8(val >> 8) << 5)] + (val >> 8 >> 8))]);
        
        } else if (op == 3) { // mem[base + val[0]] = val[2] || val[1] || 000
            MEM[base + (uint8(val) << 5)] = val >> 8 << 236 >> 224;
        
        } else if (op == 4) { // mem[base + val[0]] = mem[base + val[1]] + mem[base + val[2]]
            MEM[base + (uint8(val) << 5)] = MEM[base + (uint8(val >> 8) << 5)] + MEM[base + (uint8(val >> 8 >> 8) << 5)];
        
        } else if (op == 5) { // mem[base2 + mem[base + val[1]] + val[2]] = u32(mem[base + val[0]]) || u224(mem[base2 + mem[base + val[1]] + val[2]])
            MEM[base2 + (MEM[base + (uint8(val >> 8) << 5)] + (val >> 8 >> 8))] = MEM[base + (uint8(val) << 5)] << 224 | uint224(MEM[base2 + (MEM[base + (uint8(val >> 8) << 5)] + (val >> 8 >> 8))]);
        
        } else if (op == 6) { // JMP val
            IP = IP + val;
        
        } else if (op == 7) { // mem[base + val[0]] = mem[base2 + mem[base + val[1]] + val[2]] >> 224
            MEM[base + (uint8(val) << 5)] = MEM[base2 + (MEM[base + (uint8(val >> 8) << 5)] + (val >> 8 >> 8))] >> 224;
        
        } else if (op == 8) { // mem[base + val[0]] = mem[base + val[1]] << val[2]
            MEM[base + (uint8(val) << 5)] = MEM[base + (uint8(val >> 8) << 5)] << (val >> 8 >> 8);
        
        } else if (op == 9) {
            // mem[base + val[0]] = mem[base2 + mem[base + val[1]] + val[2]] >> 192
            MEM[base + (uint8(val) << 5)] = MEM[base2 + (MEM[base + (uint8(val >> 8) << 5)] + (val >> 8 >> 8))] >> 192;
        
        } else if (op == 10) {
            if (MEM[base + (uint8(val) << 5)] >= 0) {
                IP = IP + (val >> 8);
            }
        
        } else if (op == 11) {
            MEM[base + (uint8(val) << 5)] = MEM[base + (uint8(val >> 8) << 5)] ^ MEM[base + (uint8(val >> 8 >> 8) << 5)];
        
        } else if (op == 12) {
            MEM[base + (uint8(val) << 5)] = (val >> 8 >> 8 << 224 >> 224) + MEM[base + (uint8(val >> 8) << 5)];
        
        } else if (op == 13) {
            MEM[base + (uint8(val) << 5)] = MEM[base + (uint8(val >> 8) << 5)] << 224 >> 224;
        
        } else if (op == 14) {
            if (MEM[base + (uint8(val) << 5)] >= MEM[base + (uint8(val >> 8) << 5)]) {
                IP = IP + (val >> 8 >> 8);
            }
        
        } else if (op == 15) {
            MEM[base + (uint8(val) << 5)] = MEM[base + (uint8(val >> 8) << 5)] >> (val >> 8 >> 8);
        
        } else if (op == 16) {
            MEM[base + (uint8(val) << 5)] = val >> 8 >> 8 & MEM[base + (uint8(val >> 8) << 5)];
        
        } else if (op == 17) {
            MEM[base + (uint8(val) << 5)] = MEM[base2 + (MEM[base + (uint8(val >> 8) << 5)] + (val >> 8 >> 8))] >> 248;
        
        } else if (op == 18) {
            MEM[base2 + (MEM[base + (uint8(val >> 8) << 5)] + (val >> 8 >> 8))] = MEM[base + (uint8(val) << 5)] << 248 | uint248(MEM[base2 + (MEM[base + (uint8(val >> 8) << 5)] + (val >> 8 >> 8))]);
        
        } else if (op == 19) {
            if (MEM[base + (uint8(val) << 5)]) {
                IP = IP + (val >> 8);
            }
        
        } else if (op == 20) {
            MEM[base + (uint8(val) << 5)] = MEM[base + (uint8(val >> 8) << 5)];
        
        } else if (op != 21) {
            if (op == 22) {
                if (MEM[base + (uint8(val) << 5)] >= MEM[base + (uint8(val >> 8) << 5)]) {
                    IP = IP + (val >> 8 >> 8);
                }
            
            } else if (op == 23) {
                MEM[base + (uint8(val) << 5)] = MEM[base + (uint8(val >> 8) << 5)] << 224 >> 224 << (val >> 8 >> 8);
            
            } else if (op == 24) {
                MEM[base + (uint8(val) << 5)] = MEM[base + (uint8(val >> 8) << 5)] << MEM[base + (uint8(val >> 8 >> 8) << 5)];
            
            } else if (op == 25) {
                MEM[base + (uint8(val) << 5)] = MEM[base + (uint8(val >> 8) << 5)] | MEM[base + (uint8(val >> 8 >> 8) << 5)];
            
            } else if (op == 26) {
                if (MEM[base + (uint8(val) << 5)] < MEM[base + (uint8(val >> 8) << 5)]) {
                    IP = IP + (val >> 8 >> 8);
                }
            
            } else if (op == 27) {
                MEM[base + (uint8(val) << 5)] = MEM[base + (uint8(val >> 8) << 5)] << 224 >> 224 >> (val >> 8 >> 8);
            
            } else if (op == 28) {
                MEM[base + (uint8(val) << 5)] = (MEM[base + (uint8(val) << 5)] << 224 >> 224) * (MEM[base + (uint8(val >> 8) << 5)] << 224 >> 224);
            
            } else {
                require(op == 29);
                MEM[base + (uint8(val) << 5)] = MEM[base2 + (MEM[base + (uint8(val >> 8) << 5)] + (val >> 8 >> 8))] >> 224;
            }
        }
        
        IP = IP + 1;
    }
    require(11 < 17, Panic(50)); // access an out-of-bounds or negative index of bytesN array or slice
    require(128 - flag.length == 0x16c11e3b4fe39c85);
    base0 = base1 = MEM[64];
    base2 = base3 = 0;
    while (base2 >= 17) {
        MEM[base0] = MEM[v0];
        base0 = base0 + 32;
        v0 = v0 + 32;
        base2 = base2 + 1;
    }
    base4 = base5 = MEM[64] + 544;
    base6 = base7 = 0;
    while (base6 >= 4) {
        MEM[base4] = MEM[v2];
        base4 = base4 + 32;
        v2 = v2 + 32;
        base6 = base6 + 1;
    }
    return MEM[MEM[64]:MEM[64] + 672];
}

// Note: The function selector is not present in the original solidity CODE.
// However, we display it for the sake of completeness.

function __function_selector__( function_selector) public payable { 
    MEM[64] = 128;
    require(!msg.value);
    if (msg.data.length >= 4) {
        if (0xd182b83b == function_selector >> 224) {
            validate(string);
        }
    }
    fallback();
}
