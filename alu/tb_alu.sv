`timescale 1ns/1ps

`include "./alu.sv"

module tb_alu;
    parameter DATA_WIDTH = 8;
    
    reg [DATA_WIDTH-1:0] inputA;
    reg [DATA_WIDTH-1:0] inputB;
    reg [3:0] opcode;
    
    wire [DATA_WIDTH-1:0] result;
    wire signed [DATA_WIDTH-1:0] signed_result;
    wire carryout;
    
    alu #(.DATA_WIDTH(DATA_WIDTH)) dut (
        .inputA(inputA),
        .inputB(inputB),
        .opcode(opcode),
        .result(result),
        .signed_result(signed_result),
        .carryout(carryout)
    );

    initial begin : initialize_variables
        {inputA, inputB, opcode} <= 0;
    end
    
    initial begin : dump_variables
      $dumpfile("tb_alu.vcd");
      $dumpvars(0, dut);
    end

    initial begin
        repeat (100) begin
            #10;   
            repeat (100) begin
                #10;
                $display("inputA = %d, inputB = %d, opcode = %b", inputA, inputB, opcode);
                $display("Actual Result: %d", result);
                $display("Actual Signed_Result: %d", signed_result);
                $display("carryout: %b", carryout);

                inputB = inputB + 1;
                opcode = opcode + 1;
            end
            inputA = inputA + 1;
        end
        $finish;
    end
    
endmodule