///////////////////////////////////////////////////////////////////////////////
//
// tb_register_file.sv
//
// module: tb_register_file
// hdl: Verilog
//
// author: Berry Xu <berry.xu@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/10ps
// ensure you note the scale (ns) below in $monitor

`include "./register.sv"

module tb_register_file;
    //
    // ---------------- DECLARATIONS OF DATA TYPES ----------------
    //

    //inputs are reg for test bench - or use logic
    parameter DEPTH = 32;
    parameter WIDTH = 32;
    parameter ADDR_WIDTH = $clog2(DEPTH);
    logic clk, enable, rst;
    logic [ADDR_WIDTH-1:0] addr;
    logic [WIDTH-1:0] write_data;
    logic write_en;
    
    //outputs are wire for test bench - or use logic
    wire [WIDTH-1:0] read_data;
    
    //
    // ---------------- INSTANTIATE UNIT UNDER TEST (DUT) ----------------
    //

    register_file dut(.clk(clk), .rst(rst), .enable(enable), .addr(addr), .write_data(write_data), .write_en(write_en), .read_data(read_data));
    //
    // ---------------- INITIALIZE TEST BENCH ----------------
    //
    initial begin : initialize_variables
        {clk, rst, enable, write_data, write_en} <= 0;
    end

    initial begin : dump_variables
      $dumpfile("tb_register_file.vcd"); // for Makefile, make dump file same as module name
      $dumpvars(0, dut);
    end

    /*
    * display variables
    */
    initial begin: display_variables
        //$monitor ($time, "ns\tclk=%b,\trst=%b,\tenable=%b,\taddr=%b,\twrite_data=%b,\twrite_en=%b,\tread_data=%b", clk, rst, enable, addr, write_data, write_en, read_data);
    end

    //
    // ---------------- APPLY INPUT VECTORS ----------------
    //
    // note: following the keyword begin is the name of the block: apply_stimulus
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period
    end

    initial begin : apply_stimuli
        for (integer i = 0; i < 2**ADDR_WIDTH; i=i+1) begin
            repeat (1) @(posedge clk) addr <= i; enable <= 1; write_en<=1; write_data <= $random;
            $display($time, "ns\tclk=%b,\trst=%b,\tenable=%b,\taddr=%h,\twrite_data=%h,\twrite_en=%b,\tread_data=%h", clk, rst, enable, addr, write_data, write_en, read_data);
            #20;
        end
        for (integer i = 0; i < 2**ADDR_WIDTH; i=i+1) begin
            repeat (1) @(posedge clk) addr <= i;
            $display($time, "ns\tclk=%b,\taddr=%h,\tread_data=%h", clk, addr, read_data);
            #20;
        end
        $finish;
    end

endmodule

// `endif // tb_register_file