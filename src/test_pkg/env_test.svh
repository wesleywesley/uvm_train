class env_test extends uvm_test;

    `uvm_component_utils(env_test)
    
    switch_env e0;
    
    virtual datain_intf pkt_in; 
    virtual dataout_intf pkt_out1; 
    virtual dataout_intf pkt_out2; 
    virtual dataout_intf pkt_out3; 
    virtual dataout_intf pkt_out4; 
    virtual mem_intf mem_in;

    function new(string name, uvm_component parent);
       super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        //super.build_phase (phase);
           begin
               if (!uvm_config_db#(virtual datain_intf)::get(this, "", "packet_in", pkt_in))
                   `uvm_error("GET_DB_ERR", $psprintf("%s fail to get pkt_in virtual interface!", this.get_full_name())) 
               if (!uvm_config_db#(virtual dataout_intf)::get(this, "", "packet_out1", pkt_out1))
                   `uvm_error("GET_DB_ERR", $psprintf("%s fail to get pkt_out1 virtual interface!", this.get_full_name())) 
               if (!uvm_config_db#(virtual dataout_intf)::get(this, "", "packet_out2", pkt_out2))
                   `uvm_error("GET_DB_ERR", $psprintf("%s fail to get pkt_out2 virtual interface!", this.get_full_name())) 
               if (!uvm_config_db#(virtual dataout_intf)::get(this, "", "packet_out3", pkt_out3))
                   `uvm_error("GET_DB_ERR", $psprintf("%s fail to get pkt_out3 virtual interface!", this.get_full_name())) 
               if (!uvm_config_db#(virtual dataout_intf)::get(this, "", "packet_out4", pkt_out4))
                   `uvm_error("GET_DB_ERR", $psprintf("%s fail to get pkt_out4 virtual interface!", this.get_full_name())) 
               if (!uvm_config_db#(virtual mem_intf)::get(this, "", "mem_in", mem_in))
                   `uvm_error("GET_DB_ERR", $psprintf("%s fail to get mem_in virtual interface!", this.get_full_name())) 
           end

        uvm_config_db#(virtual datain_intf)::set(this, "e0.datain_agt.*", "packet_in", pkt_in);
        uvm_config_db#(virtual dataout_intf)::set(this, "e0.dataout_agt1.*", "vif", pkt_out1);
        uvm_config_db#(virtual dataout_intf)::set(this, "e0.dataout_agt2.*", "vif", pkt_out2);
        uvm_config_db#(virtual dataout_intf)::set(this, "e0.dataout_agt3.*", "vif", pkt_out3);
        uvm_config_db#(virtual dataout_intf)::set(this, "e0.dataout_agt4.*", "vif", pkt_out4);
        uvm_config_db#(virtual mem_intf)::set(this, "e0.mem_agt.*", "mem_in", mem_in);

        uvm_config_db#(int)::set(this, "e0.datain_agt", "is_active", UVM_ACTIVE);
        uvm_config_db#(int)::set(this, "e0.dataout_agt1", "is_active", UVM_PASSIVE);
        uvm_config_db#(int)::set(this, "e0.dataout_agt2", "is_active", UVM_PASSIVE);
        uvm_config_db#(int)::set(this, "e0.dataout_agt3", "is_active", UVM_PASSIVE);
        uvm_config_db#(int)::set(this, "e0.dataout_agt4", "is_active", UVM_PASSIVE);
        uvm_config_db#(int)::set(this, "e0.mem_agt", "is_active", UVM_ACTIVE);

        e0 = new("e0", this);
    endfunction

    

endclass : env_test 
