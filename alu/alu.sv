///////////////////////////////////////////////////////////////////////////////
//
// alu.sv
//
// module: alu
// hdl: Verilog
// modeling: Behavioral Modeling
//
// author: Berry Xu <berry.xu@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////
`ifndef ALU
`define ALU

module alu(inputA, inputB, opcode, result, signed_result, carryout);
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    parameter DATA_WIDTH = 8;
    input logic [DATA_WIDTH-1:0] inputA;
    input logic [DATA_WIDTH-1:0] inputB;
    input logic [3:0] opcode;
    output logic [DATA_WIDTH-1:0] result;
    output logic signed [DATA_WIDTH-1:0] signed_result;
    output logic carryout;
    logic [DATA_WIDTH:0] sum;
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    assign sum = inputA + inputB;

    always @(*)begin
        case (opcode)
            4'b0000:begin 
                        result = sum; // Addition
                        signed_result = $signed(sum);
                    end
            4'b0001:begin 
                        result = inputA - inputB; // Subtraction
                        signed_result = $signed(result);
                    end
            4'b0010:begin
                        result = inputA * inputB; // Multiplication
                        signed_result = $signed(result);
                    end
            4'b0011:begin 
                        result = inputA / inputB; // Division
                        signed_result = $signed(result);
                    end
            4'b0100:begin
                        result = inputA & inputB; // And
                        signed_result = $signed(result);
                    end
            4'b0101:begin 
                        result = inputA | inputB; // Or
                        signed_result = $signed(result);
                    end
            4'b0110:begin
                        result = ~inputA; // Not
                        signed_result = $signed(result);
                    end
            4'b0111:begin
                        result = inputA << inputB; // sll
                        signed_result = inputA <<< inputB;
                    end
            4'b1000:begin
                        result = inputA >> inputB; // slr
                        signed_result = inputA >>> inputB;
                    end
            default: result = 0;
        endcase
    end

    assign carryout = sum[DATA_WIDTH] != 0;

endmodule
`endif // alu