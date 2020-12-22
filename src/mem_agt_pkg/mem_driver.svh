class mem_driver extends uvm_driver#(mem);
    `uvm_component_utils(mem_driver)

    virtual mem_intf mem_in;

    function new(string name = "mem_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        //for triple.sv test, the followed 3 have to be commentted
        if (!uvm_config_db#(virtual mem_intf)::get(this, "", "mem_in", mem_in)) begin
            `uvm_error("GET_DB_ERR", $psprintf("%s fail to get mem_in virtual interface!", this.get_full_name())) 
        end
    endfunction

    task run_phase(uvm_phase phase);
        
        mem_in.drv_cb.mem_addr <= 0;
        mem_in.drv_cb.mem_data <= 0;

        forever begin
            mem mem_pkt;
            seq_item_port.get_next_item(mem_pkt);
            //seq_item_port.get_next_item(req);
            $display("mem_in_pkt_driver ------------------------->");
            mem_pkt.print();
            //req.print();
            
            drive_item(mem_pkt);
            seq_item_port.item_done();
        end
    endtask

    virtual task drive_item(mem mem_pkt);

        @(mem_in.drv_cb);

        mem_in.drv_cb.mem_addr <= mem_pkt.memory_addr;
        mem_in.drv_cb.mem_data <= mem_pkt.memory_data;

    endtask
endclass
