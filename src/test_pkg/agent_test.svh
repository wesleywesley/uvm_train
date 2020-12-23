class agent_test extends uvm_test;

    `uvm_component_utils(agent_test)
    
    datain_agent datain_agt;
    dataout_agent dataout_agt1;
    dataout_agent dataout_agt2;
    dataout_agent dataout_agt3;
    dataout_agent dataout_agt4;
    mem_agent mem_agt;

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

        uvm_config_db#(virtual datain_intf)::set(this, "datain_agt.*", "packet_in", pkt_in);
        uvm_config_db#(virtual dataout_intf)::set(this, "dataout_agt1.*", "vif", pkt_out1);
        uvm_config_db#(virtual dataout_intf)::set(this, "dataout_agt2.*", "vif", pkt_out2);
        uvm_config_db#(virtual dataout_intf)::set(this, "dataout_agt3.*", "vif", pkt_out3);
        uvm_config_db#(virtual dataout_intf)::set(this, "dataout_agt4.*", "vif", pkt_out4);
        uvm_config_db#(virtual mem_intf)::set(this, "mem_agt.*", "mem_in", mem_in);

        uvm_config_db#(int)::set(this, "datain_agt", "is_active", UVM_ACTIVE);
        uvm_config_db#(int)::set(this, "dataout_agt1", "is_active", UVM_PASSIVE);
        uvm_config_db#(int)::set(this, "dataout_agt2", "is_active", UVM_PASSIVE);
        uvm_config_db#(int)::set(this, "dataout_agt3", "is_active", UVM_PASSIVE);
        uvm_config_db#(int)::set(this, "dataout_agt4", "is_active", UVM_PASSIVE);
        uvm_config_db#(int)::set(this, "mem_agt", "is_active", UVM_ACTIVE);

        datain_agt = new("datain_agt", this);
        dataout_agt1 = new("dataout_agt1", this);
        dataout_agt2 = new("dataout_agt2", this);
        dataout_agt3 = new("dataout_agt3", this);
        dataout_agt4 = new("dataout_agt4", this);
        mem_agt = new("mem_agt", this);

    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);//for datain_sequence run body()

        #500;

        begin
          mem_sequence mem_seq = new("mem_seq");
          mem_seq.start(mem_agt.mem_seqer);//run body()
        end

        #100;

        begin
          datain_sequence datain_seq = new("datain_seq");
          void'( datain_seq.randomize() with { _DA == 8'hbd; }); 
          datain_seq.start(datain_agt.datain_seqer);//run body()
        end

        #1000;

        phase.drop_objection(this);
    endtask

endclass : agent_test 
