interface dataout_intf #(parameter BW = 10)(input clk);
    logic ready;
    logic read;
    logic [7:0] data_out;

    clocking mon_cb @(posedge clk);
        default input #1 output #2;
        input  ready;
        output  read;
        input  data_out;
    endclocking
    
    clocking drv_cb @(posedge clk);
        default input #1 output #2;
        output  ready;
        input  read;
        output  data_out;
    endclocking

endinterface : dataout_intf
