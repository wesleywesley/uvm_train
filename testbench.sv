`include "uvm_macros.svh"
`include "uvm_pkg.sv"

import uvm_pkg::*;

`include "transaction.sv"
`include "my_hello_world.sv"
`include "anlsp.sv"
`include "anlsp_test.sv"
`include "my_driver.sv"
`include "my_sequence.sv"
`include "my_sequencer.sv"
`include "triple.sv"


module Testbench();

    logic clk;
    logic rst_n;

    //initialize DUT
    switch switch_dut
    (
        .clk        (clk),
        .reset    (rst_n)
    );

    initial begin
        run_test();
    end

    //clock
    initial begin
        //$display("hello world");
        clk <= 0;
        forever begin
            #5 clk <= ~clk;
        end
    end

    //reset
    initial begin
        rst_n <= 0;
        #100;
        rst_n <= 1;
    end

    //time of simu
    initial begin
        #1000;
        $finish;
    end

    //waveform
    initial begin
        $fsdbDumpfile ("testbench.fsdb");
        $fsdbDumpvars;
    end

endmodule
