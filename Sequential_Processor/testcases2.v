// finding the sum of an array
x5 contains the address where ans needs to be stored in memory
x23 contains the base address of array in the memory
n in the x24
1 in x22

tempaddress in the x26
sum in the x25
i in the x27
j in the x28    j is 8*i

// for(int i =0; i<n;i++)
// {
//     sum+=a[i];
// }

0        add x27 x0 x0       // i=0
4        add x25 x0 x0       // sum=0
8        add x28 x0 x0       // j=0
12        loop:   beq x27 x24 End     // if i==n then go to end
16                add x26 x28 x23     // tempaddress = baseaddress + j
20                ld x26 0(x26)       // loading the value at tempaddress
24                add x25 x25 x26     // sum+=a[i]
28                add x28 x28 x22     // j++
32                add x27 x27 x22     // i++
36                beq x0 x0 loop      // go to loop
40        End:    sd x25 0(x5)       // storing the sum in the address of x5

// machine code in 64 bits with space
0000000 00000 00000 000 11011 0110011
0000000 00000 00000 000 11001 0110011
0000000 00000 00000 000 11100 0110011

0 000000 11011 11000 000 1110 0 1100011
0000000 11100 10111 000 11010 0110011
000000000000 11010 000 11010 0000011
0000000 11010 11001 000 11001 0110011
0000000 10110 11100 000 11100 0110011
0000000 10110 11011 000 11011 0110011
1 111111 00000 00000 000 0100 1 1100011
0000000 11001 00101 000 00000 0100011

// without space
00000000000000000000110110110011
00000000000000000000110010110011
00000000000000000000111000110011
00000001101111000000111001100011
00000001110010111000110100110011
00000000000011010000110100000011
00000001101011001000110010110011
00000001011011100000111000110011
00000001011011011000110110110011
11111110000000000000010011100011
00000001100100101000000000100011



// counting even no in the array
// 0 is considered as the even number
x22 contains the address where ans needs to be stored in memory
x23 contains the base address of array in the memory
n in the x24
1 in x22
8 in x21

tempaddress in the x26
ans(number of even numbers) in the x25
i in the x27
j in the x28    j is 8*i

// for(int i =0; i<n;i++)
// {
//     if(a[i]|1!=a[i])
//     {
//         ans++;
//     }
// }

add x27 x0 x0       // i=0
add x25 x0 x0       // sum=0
add x28 x0 x0       // j=0
beq x0 x0 loop      // go to loop

check: 
    add x25 x25 x22     // ans++
    beq x0 x0 cont      // go to cont

loop:
    beq x27 x24 End     // if i==n then go to end
    add x26 x28 x23     // tempaddress = baseaddress + j
    ld x26 0(x26)       // loading the value at tempaddress
    or x30 x26 x22       // a[i]|1
    beq x30 x26 check 
cont:
    add x28 x28 x21     // j+=8
    add x27 x27 x22     // i++
    beq x0 x0 loop      // go to loop

End:
    sd x25 0(x22)       // storing the ans in the address of x22


// machine code in 64 bits with space
