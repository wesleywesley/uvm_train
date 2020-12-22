class mem_monitor extends uvm_monitor;

    `uvm_component_utils(mem_monitor)

    function new(string name = "mem_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual mem_intf mem_in;
    uvm_analysis_port#(mem) mon_analysis_port;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        mon_analysis_port = new("mon_analysis_port", this);
        if (!uvm_config_db#(virtual mem_intf)::get(this, "", "mem_in", mem_in)) begin
            `uvm_error("GET_DB_ERR", $psprintf("%s fail to get mem_in virtual interface!", this.get_full_name())) 
        end
    endfunction

    virtual task run_phase(uvm_phase phase);
        
    endtask

endclass
