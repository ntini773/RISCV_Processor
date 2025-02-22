`include "sltu.v"

module set_less_than_unsigned_tb;
    reg [63:0] a, b;
    wire less;

    // Instantiate the module under test
    set_less_than_unsigned uut (
        .a(a),
        .b(b),
        .less(less)
    );

    initial begin
        // Monitor changes
        $monitor("Time = %0t | a = %d | b = %d | less = %b", $time, a, b, less);

        // Test cases
        a = 64'd10;  b = 64'd20;  #10;  // Expect less = 1
        a = 64'd30;  b = 64'd15;  #10;  // Expect less = 0
        a = 64'hFFFFFFFFFFFFFFFF;  b = 64'd0;  #10; // Expect less = 0 (unsigned comparison)
        a = 64'd0;  b = 64'd0;  #10;  // Expect less = 0
        a = 64'd25; b = 64'd25; #10; // Expect less = 0
        a = 64'd100; b = 64'd200; #10; // Expect less = 1

        // Finish simulation
        $finish;
    end
endmodule
