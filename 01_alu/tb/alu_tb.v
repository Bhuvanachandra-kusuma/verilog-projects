// ============================================================
// Testbench for 4-bit ALU
// ============================================================

`timescale 1ns/1ps

module alu_tb;

    // Inputs
    reg [3:0] A, B;
    reg [2:0] op;

    // Outputs
    wire [3:0] result;
    wire zero, carry, overflow, negative;

    // Instantiate DUT
    alu uut (
        .A(A), .B(B), .op(op),
        .result(result),
        .zero(zero), .carry(carry),
        .overflow(overflow), .negative(negative)
    );

    // Dump waveform
    initial begin
        $dumpfile("sim/alu_wave.vcd");
        $dumpvars(0, alu_tb);
    end

    // Task: run one test and print pass/fail
    task run_test;
        input [3:0] a_in, b_in;
        input [2:0] op_in;
        input [3:0] expected;
        input exp_zero, exp_carry, exp_overflow, exp_negative;
        begin
            A = a_in; B = b_in; op = op_in;
            #10;
            if (result       !== expected      ||
                zero         !== exp_zero      ||
                carry        !== exp_carry     ||
                overflow     !== exp_overflow  ||
                negative     !== exp_negative) begin
                $display("FAIL | op=%b A=%b B=%b | got result=%b z=%b c=%b ov=%b n=%b | exp result=%b z=%b c=%b ov=%b n=%b",
                    op, a_in, b_in,
                    result, zero, carry, overflow, negative,
                    expected, exp_zero, exp_carry, exp_overflow, exp_negative);
            end else begin
                $display("PASS | op=%b A=%04b B=%04b | result=%04b z=%b c=%b ov=%b n=%b",
                    op, a_in, b_in, result, zero, carry, overflow, negative);
            end
        end
    endtask

    initial begin
        $display("=== 4-bit ALU Testbench ===");
        $display("op      A      B    | result z c ov n");
        $display("----------------------------------------------");

        // ADD: unsigned 3+4=7, no flags
        run_test(4'd3,  4'd4,  3'b000, 4'd7,  0, 0, 0, 0);
        // ADD: unsigned 7+9=16, carry out, result=0
        run_test(4'd7,  4'd9,  3'b000, 4'd0,  1, 1, 0, 0);
        // ADD: signed 7+1=8, but 8 doesn't fit in 4-bit signed -> overflow
        run_test(4'd7,  4'd1,  3'b000, 4'd8,  0, 0, 1, 1);

        // SUB: signed: A=1001(-7), B=0100(4), -7-4=-11 -> overflow
        run_test(4'b1001, 4'b0100, 3'b001, 4'b0101, 0, 0, 1, 0);
        // SUB: A=4, B=9 -> borrow, negative, signed: 4-(-7)=11 -> overflow
        run_test(4'd4,  4'b1001, 3'b001, 4'b1011, 0, 1, 1, 1);
        // SUB: 0-0=0
        run_test(4'd0,  4'd0,  3'b001, 4'd0,  1, 0, 0, 0);
        // SUB: simple 5-3=2, no flags
        run_test(4'd5,  4'd3,  3'b001, 4'd2,  0, 0, 0, 0);

        // AND
        run_test(4'b1100, 4'b1010, 3'b010, 4'b1000, 0, 0, 0, 1);
        run_test(4'b1111, 4'b0000, 3'b010, 4'b0000, 1, 0, 0, 0);

        // OR
        run_test(4'b1100, 4'b0011, 3'b011, 4'b1111, 0, 0, 0, 1);
        run_test(4'b0000, 4'b0000, 3'b011, 4'b0000, 1, 0, 0, 0);

        // XOR
        run_test(4'b1010, 4'b1010, 3'b100, 4'b0000, 1, 0, 0, 0);
        run_test(4'b1100, 4'b0110, 3'b100, 4'b1010, 0, 0, 0, 1);

        // NOT
        run_test(4'b1010, 4'bx,   3'b101, 4'b0101, 0, 0, 0, 0);
        run_test(4'b0000, 4'bx,   3'b101, 4'b1111, 0, 0, 0, 1);

        // SHL
        run_test(4'b0011, 4'bx,   3'b110, 4'b0110, 0, 0, 0, 0);
        run_test(4'b1001, 4'bx,   3'b110, 4'b0010, 0, 1, 0, 0);

        // SHR
        run_test(4'b1100, 4'bx,   3'b111, 4'b0110, 0, 0, 0, 0);
        run_test(4'b0001, 4'bx,   3'b111, 4'b0000, 1, 1, 0, 0);

        $display("----------------------------------------------");
        $display("=== Simulation complete ===");
        $finish;
    end

endmodule
