interface datain_intf #(parameter BW = 8)(input clk);
    logic packet_valid;
    logic [7:0] data_in;

    clocking mon_cb @(posedge clk);
        default input #1 output #2;
        input  packet_valid;
        input  data_in;
    endclocking
    
    clocking drv_cb @(posedge clk);
        default input #1 output #2;
        output packet_valid;
        output data_in;
    endclocking

endinterface :datain_intf
