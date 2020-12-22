//`include "uvm_macros.svh"
//`include "uvm_pkg.sv"

import uvm_pkg::*;
import test_pkg::*;


module Testbench();

    logic clk;
    logic rst_n;
    //logic packet_valid;
    //logic [7:0] data_in;

    pktin_intf pkt_in(clk);

    //initialize DUT
    switch switch_dut
    (
        .clk            (clk),
        .reset          (rst_n),
        .data_status    (pkt_in.packet_valid),
        .data           (pkt_in.data_in)
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

    //raise/drop replace
/*    //time of simu
    initial begin
        #1000;
        $finish;
    end
*/
    //waveform
    initial begin
        $fsdbDumpfile ("testbench.fsdb");
        $fsdbDumpvars;
    end

    initial begin
        //null search from root
        //uvm test top, target
        //name string
        //instance
        uvm_config_db#(virtual pktin_intf)::set(null, "uvm_test_top", "packet_in", pkt_in);
    end

    initial begin
        //uvm_config_db#(int)::set(null, "*my_agt", "is_active", UVM_ACTIVE);
    end
endmodule
