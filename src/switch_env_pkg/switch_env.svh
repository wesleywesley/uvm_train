class switch_env extends uvm_env;
    `uvm_object_utils(switch_env)

    datain_agent datain_agt;
    dataout_agent dataout_agt1;
    dataout_agent dataout_agt2;
    dataout_agent dataout_agt3;
    dataout_agent dataout_agt4;
    mem_agent mem_agt;

    switch_scb scbin;

    virtual datain_intf pkt_in; 
    virtual dataout_intf pkt_out1; 
    virtual dataout_intf pkt_out2; 
    virtual dataout_intf pkt_out3; 
    virtual dataout_intf pkt_out4; 
    virtual mem_intf mem_in; 

    function new(string name = "switch_env", uvm_component parent = null);
        super.new(name, parent);
        scbin = new("switch_scbin", this); 
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        datain_agt.datain_mon.mon_analysis_port.connect(scbin.anlse_imp);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        
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
endclass
