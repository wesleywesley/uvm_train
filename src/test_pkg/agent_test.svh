class agent_test extends uvm_test;

    `uvm_component_utils(agent_test)
    
    datain_agent datain_agt;
    virtual datain_intf pkt_in; 

    function new(string name, uvm_component parent);
       super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        //super.build_phase (phase);
           begin
               //virtual datain_intf pkt_in;
               if (!uvm_config_db#(virtual datain_intf)::get(this, "", "packet_in", pkt_in))
                   `uvm_error("GET_DB_ERR", $psprintf("%s fail to get pkt_in virtual interface!", this.get_full_name())) 
           end

        //how to transfer to lower level?
        //uvm_config_db#(virtual datain_intf)::set(null, "uvm_test_top.*", "packet_in", pkt_in);
        uvm_config_db#(virtual datain_intf)::set(this, "datain_agt.*", "packet_in", pkt_in);
        uvm_config_db#(int)::set(this, "datain_agt", "is_active", UVM_ACTIVE);

        datain_agt = new("datain_agt", this);

    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);//for datain_sequence run body()

        #100;

        begin
          datain_sequence datain_seq = new("datain_seq");
          datain_seq.start(datain_agt.datain_seqer);//run body()
        end

        #100;

        phase.drop_objection(this);
    endtask

endclass : agent_test 
