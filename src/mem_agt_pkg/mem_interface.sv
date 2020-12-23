interface mem_intf #(parameter BW = 10)(input clk);
    logic [1:0] mem_addr;
    logic [7:0] mem_data;
    logic mem_rw;
    logic mem_en;

    clocking mon_cb @(posedge clk);
        default input #1 output #2;
        input  mem_addr;
        input  mem_data;
        input  mem_rw;
        input  mem_en;
    endclocking
    
    clocking drv_cb @(posedge clk);
        default input #1 output #2;
        output mem_addr;
        output mem_data;
        output  mem_rw;
        output  mem_en;
    endclocking

endinterface : mem_intf
