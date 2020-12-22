//`include "uvm_macros.svh"
//`include "uvm_pkg.sv"

import uvm_pkg::*;
import test_pkg::*;


module Testbench();

    logic clk;
    logic rst_n;
    //logic packet_valid;
    //logic [7:0] data_in;

    datain_intf pkt_in(clk);
    dataout_intf pkt_out1(clk);
    dataout_intf pkt_out2(clk);
    dataout_intf pkt_out3(clk);
    dataout_intf pkt_out4(clk);
    mem_intf mem_in(clk);

    //initialize DUT
    switch switch_dut
    (
        .clk            (clk),
        .reset          (rst_n),

        .data_status    (pkt_in.packet_valid),
        .data           (pkt_in.data_in),
    
        .mem_add        (mem_in.mem_addr),
        .mem_data       (mem_in.mem_data),
        //.mem_en
        //.mem_rd_wr

        .port0          (pkt_out1.data_out),
        .port1          (pkt_out2.data_out),
        .port2          (pkt_out3.data_out),
        .port3          (pkt_out4.data_out),

        .read_0          (pkt_out1.read),
        .read_1          (pkt_out2.read),
        .read_2          (pkt_out3.read),
        .read_3          (pkt_out4.read),

        .ready_0          (pkt_out1.ready),
        .ready_1          (pkt_out2.ready),
        .ready_2          (pkt_out3.ready),
        .ready_3          (pkt_out4.ready)
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
        uvm_config_db#(virtual datain_intf)::set(null, "uvm_test_top", "packet_in", pkt_in);
        uvm_config_db#(virtual dataout_intf)::set(null, "uvm_test_top", "packet_out1", pkt_out1);
        uvm_config_db#(virtual dataout_intf)::set(null, "uvm_test_top", "packet_out2", pkt_out2);
        uvm_config_db#(virtual dataout_intf)::set(null, "uvm_test_top", "packet_out3", pkt_out3);
        uvm_config_db#(virtual dataout_intf)::set(null, "uvm_test_top", "packet_out4", pkt_out4);
        uvm_config_db#(virtual mem_intf)::set(null, "uvm_test_top", "mem_in", mem_in);
    end

    initial begin
        //uvm_config_db#(int)::set(null, "*my_agt", "is_active", UVM_ACTIVE);
    end
endmodule
