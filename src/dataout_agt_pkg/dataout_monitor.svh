class dataout_monitor extends uvm_monitor;

    typedef enum {
        IDLE = 0,
        BUSY = 1
    } SM;

    SM state;

    `uvm_component_utils(dataout_monitor)

    function new(string name = "dataout_monitor", uvm_component parent = null);
        super.new(name, parent);
        state = IDLE;
    endfunction

    virtual dataout_intf pkt_out;
    uvm_analysis_port#(packet) mon_analysis_port;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        mon_analysis_port = new("mon_analysis_port", this);
        if (!uvm_config_db#(virtual dataout_intf)::get(this, "", "packet_out*", pkt_out)) begin
            `uvm_error("GET_DB_ERR", $psprintf("%s fail to get pkt_out virtual interface!", this.get_full_name())) 
        end
    endfunction

    virtual task run_phase(uvm_phase phase);

    endtask

endclass
