class my_driver extends uvm_driver#(packet);
    `uvm_component_utils(my_driver)

    virtual pktin_intf pkt_in;

    function new(string name = "my_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        //for triple.sv test, the followed 3 have to be commentted
        if (!uvm_config_db#(virtual pktin_intf)::get(this, "", "packet_in", pkt_in)) begin
            `uvm_error("GET_DB_ERR", $psprintf("%s fail to get pkt_in virtual interface!", this.get_full_name())) 
        end
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(req);
            $display("my_driver ------------------------->");
            req.print();
            #10;
            seq_item_port.item_done();
        end
    endtask
endclass
