//v1: test for driver/sequencer/sequence
//v2: test for interface get/set(from testbench.sv)

class triple_test extends uvm_test;

    `uvm_component_utils(triple_test)
    
    datain_driver datain_drv;
    datain_sequence datain_seq;
    datain_sequencer datain_seqer;

    virtual pktin_intf pkt_in;
    
    function new(string name, uvm_component parent);
       super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase (phase);
           begin
               if (!uvm_config_db#(virtual pktin_intf)::get(this, "", "packet_in", pkt_in))
                   `uvm_error("GET_DB_ERR", $psprintf("%s fail to get pkt_in virtual interface!", this.get_full_name())) 
           end

           uvm_config_db#(virtual pktin_intf)::set(this, "datain_drv", "packet_in", pkt_in);
           
           datain_drv = new("datain_drv", this);
           datain_seq = new("datain_seq");
           datain_seqer = new("datain_seqer", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase (phase);
            datain_drv.seq_item_port.connect(datain_seqer.seq_item_export);
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);//for datain_sequence run body()
        datain_seq.start(datain_seqer);//run body()
        phase.drop_objection(this);
    endtask

endclass : triple_test 
