class dataout_driver extends uvm_driver#(packet);
    `uvm_component_utils(dataout_driver)

    virtual dataout_intf pkt_out;

    function new(string name = "dataout_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        //for triple.sv test, the followed 3 have to be commentted
        if (!uvm_config_db#(virtual dataout_intf)::get(this, "", "packet_out", pkt_out)) begin
            `uvm_error("GET_DB_ERR", $psprintf("%s fail to get pkt_out virtual interface!", this.get_full_name())) 
        end
    endfunction

    task run_phase(uvm_phase phase);
        
    endtask
    
endclass
