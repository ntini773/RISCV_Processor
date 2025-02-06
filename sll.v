'include "slt.v"
module shift_left_logical(input a[63:0],input b[5:0],output out[63:0]);
    genvar i;
    generate
        for(i=0;i<64;i=i+1) begin:shift_gen
             wire slt;
            wire [63:0] shift_amount;  // 64-bit wire for (64 - b)

            assign shift_amount = 64'd64 - {58'b0, b}; // Zero-extend b to 64 bits

            strictly_less slt_inst(.a(i), .b(shift_amount), .less(slt));

            mux2 sll_mux(.sel(slt), .in0(1'b0), .in1(a[i + b]), .out(out[i]));
        end
    endgenerate
endmodule