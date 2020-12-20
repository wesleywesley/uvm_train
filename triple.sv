//v1: test for driver/sequencer/sequence
//v2: test for interface get/set(from testbench.sv)

class triple_test extends uvm_test;

    `uvm_component_utils(triple_test)
    
    my_driver my_drv;
    my_sequence my_seq;
    my_sequencer my_seqer;

    function new(string name, uvm_component parent);
       super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase (phase);
           begin
               virtual pktin_intf pkt_in;
               if (!uvm_config_db#(virtual pktin_intf)::get(this, "", "packet_in", pkt_in))
                   `uvm_error("GET_DB_ERR", $psprintf("%s fail to get pkt_in virtual interface!", this.get_full_name())) 
           end
           
           my_drv = new("my_drv", this);
           my_seq = new("my_seq");
           my_seqer = new("my_seqer", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase (phase);
            my_drv.seq_item_port.connect(my_seqer.seq_item_export);
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);//for my_sequence run body()
        my_seq.start(my_seqer);//run body()
        phase.drop_objection(this);
    endtask

endclass : triple_test 
