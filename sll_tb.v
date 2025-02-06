`include "sll.v"
module shift_left_logical_tb;

    // Declare inputs as registers and outputs as wires
    reg [63:0] a;
    reg [4:0] b;
    wire [63:0] out;

    // Instantiate the shift_left_logical module
    shift_left_logical uut (
        .a(a),
        .b(b),
        .out(out)
    );

    // Apply stimulus to the inputs
    initial begin
        // Test case 1: Shift by 0
        a = 64'd17;  // Some arbitrary 64-bit input
        b = 5'b00000;             // No shift
        #10;
        
        // Test case 2: Shift by 1
        b = 5'b00001;             // Shift by 1
        #10;
        
        // Test case 3: Shift by 8
        b = 5'b01000;             // Shift by 8
        #10;
        
        // Test case 4: Shift by 32
        b = 5'b10000;             // Shift by 32
        #10;

        // Test case 5: Shift by 63 (maximum shift)
        b = 5'b11111;             // Shift by 63
        #10;

        // Test case 6: Shift by 16
        b = 5'b01000;             // Shift by 16
        #10;

        // End simulation
        $finish;
    end

    // Monitor the values of inputs and outputs
    initial begin
        $monitor("Time=%0t | a=%d | b=%d | out=%d", $time, a, b, out);
    end

endmodule
