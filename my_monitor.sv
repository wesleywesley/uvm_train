class my_monitor extends uvm_monitor;
    `uvm_component_utils(my_monitor)

    function new(string name = "my_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual pktin_intf pkt_in;
    uvm_analysis_port#(packet) mon_analysis_port;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        mon_analysis_port = new("mon_analysis_port", this);
        if (!uvm_config_db#(virtual pktin_intf)::get(this, "", "packet_in", pkt_in)) begin
            `uvm_error("GET_DB_ERR", $psprintf("%s fail to get pkt_in virtual interface!", this.get_full_name())) 
        end
    endfunction

    virtual task run_phase(uvm_phase phase);
        packet test_pkt = packet::type_id::create("test_pkt", this);
        forever begin
            //test_pkt.Data = pkt_in.data_in; //interface & transaction, compile error?
            mon_analysis_port.write(test_pkt);
        end
    endtask
endclass
