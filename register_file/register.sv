///////////////////////////////////////////////////////////////////////////////
//
// register.sv
//
// module: d-flip-flop
// hdl: Verilog
// modeling: Behavioral Modeling
//
// author: Berry Xu <berry.xu@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////
`ifndef REGISTER
`define REGISTER

`include "./dff.sv"

module register(clk, rst, enable, d, q);
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    parameter WIDTH = 8;   
    input logic clk, rst, enable;
    input logic [WIDTH-1:0] d;
    output logic [WIDTH-1:0] q;
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    genvar i;
    generate
        for(i = 0; i < WIDTH; i++) begin
            dff flip_flop (.clk(clk), .rst(rst), .enable(enable), .d(d[i]), .q(q[i]));
        end
    endgenerate

endmodule
`endif // register