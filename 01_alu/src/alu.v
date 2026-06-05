// ============================================================
// 4-bit ALU
// ------------------------------------------------------------
// Operations (op):
//   3'b000  ADD   A + B
//   3'b001  SUB   A - B
//   3'b010  AND   A & B
//   3'b011  OR    A | B
//   3'b100  XOR   A ^ B
//   3'b101  NOT   ~A  (B ignored)
//   3'b110  SHL   A << 1
//   3'b111  SHR   A >> 1
//
// Flags:
//   zero     — result is 0
//   carry    — carry/borrow out (ADD/SUB only)
//   overflow — signed overflow (ADD/SUB only)
//   negative — MSB of result is 1
// ============================================================

module alu (
    input  [3:0] A,
    input  [3:0] B,
    input  [2:0] op,
    output reg [3:0] result,
    output zero,
    output reg carry,
    output reg overflow,
    output negative
);

    reg [4:0] temp; // 5-bit to capture carry

    always @(*) begin
        carry    = 1'b0;
        overflow = 1'b0;
        temp     = 5'b0;

        case (op)
            3'b000: begin // ADD
                temp     = {1'b0, A} + {1'b0, B};
                result   = temp[3:0];
                carry    = temp[4];
                overflow = (~A[3] & ~B[3] & result[3]) |
                           ( A[3] &  B[3] & ~result[3]);
            end
            3'b001: begin // SUB
                temp     = {1'b0, A} - {1'b0, B};
                result   = temp[3:0];
                carry    = temp[4];          // borrow
                overflow = (~A[3] &  B[3] & result[3]) |
                           ( A[3] & ~B[3] & ~result[3]);
            end
            3'b010: result = A & B;         // AND
            3'b011: result = A | B;         // OR
            3'b100: result = A ^ B;         // XOR
            3'b101: result = ~A;            // NOT
            3'b110: begin                   // SHL
                result = A << 1;
                carry  = A[3];              // shifted-out bit
            end
            3'b111: begin                   // SHR
                result = A >> 1;
                carry  = A[0];              // shifted-out bit
            end
            default: result = 4'b0;
        endcase
    end

    assign zero     = (result == 4'b0);
    assign negative = result[3];

endmodule
