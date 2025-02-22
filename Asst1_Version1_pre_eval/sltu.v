`ifndef SLTU
`define SLTU

module set_less_than_unsigned(input [63:0]a,input [63:0]b,output less);
    genvar i;
    wire [63:0]lt;
    generate
        for(i=0;i<64;i=i+1) begin:less_gen
            wire not_a;
            not(not_a,a[i]);
            and(lt[i], not_a, b[i]);  // lt[i] = ~a[i] & b[i] (a < b condition)
            
        end
    endgenerate

    wire [63:0]chain;
    wire [64:0] enabler;
    wire [64:0] flag;
    wire [63:0] a_not;
    wire [63:0] xorab;
    assign chain[63] = lt[63];
    assign enabler[64] = 1'b0;
    for (i = 63; i >=0; i = i - 1) begin
        wire select,not_enabler;
        xor u1 (xorab[i], a[i],b[i]);
        not u2 (a_not[i], a[i]);
        and u3 (chain[i], a_not[i], b[i]);
        or u4 (enabler[i], enabler[i+1], xorab[i]);
        not u5 (not_enabler, enabler[i+1]);
        and u6 (select, not_enabler, xorab[i]);
        assign flag[i]=select?chain[i]:enabler[i];
    end
    assign less = flag[0];
endmodule

`endif 