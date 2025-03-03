//////////////////////////////////////////////////////////////////////////////
//
// Module: register_file
//
// register File
//
// hdl: SystemVerilog
// modeling: Behavioral Modeling
//
// author: Berry Xu <berry.xu@cooper.edu
//
///////////////////////////////////////////////////////////////////////////////
`ifndef REGISTER_FILE
`define REGISTER_FILE

`include "register.sv"

module register_file
    //
    // ---------------- DECLARATIONS OF PORT IN/OUT & DATA TYPES ----------------
    //
#(
    parameter DEPTH = 32,  // Number of registers (default 8)
    parameter WIDTH = 32,   // Width of each register (inherited or specified)
    parameter ADDR_WIDTH = $clog2(DEPTH)
) (
    input logic clk,
    input logic rst,
    input logic enable,

    input logic [ADDR_WIDTH-1:0] addr, // Write address
    input logic [WIDTH-1:0] write_data,      // Write data
    input logic write_en,             // Write enable

    output logic [WIDTH-1:0] read_data     // Read data
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    // Array of registers
    register #(.WIDTH(WIDTH)) registers[DEPTH-1:0];

    logic [WIDTH-1:0] mem_internal [DEPTH:0]; // Internal signal for register outputs

    genvar i;
    generate
        for (i = 0; i < DEPTH; i++) begin : register_instances
            register #(.WIDTH(WIDTH)) registers (
                .clk(clk),
                .rst(rst),
                .enable(enable && write_en && (addr == i)), // Simplified enable logic
                .d(write_data),
                .q(mem_internal[i]) // Output not directly connected within the array
            );
        end
    endgenerate

    always_ff @(posedge clk) begin
        read_data <= mem_internal[addr];
    end
endmodule
`endif // register_file