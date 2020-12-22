interface mem_intf #(parameter BW = 8)(input clk);
    logic [1:0] mem_addr;
    logic [7:0] mem_data;

    clocking mon_cb @(posedge clk);
        default input #1 output #2;
        input  mem_addr;
        input  mem_data;
    endclocking
    
    clocking drv_cb @(posedge clk);
        default input #1 output #2;
        output mem_addr;
        output mem_data;
    endclocking

endinterface : mem_intf
