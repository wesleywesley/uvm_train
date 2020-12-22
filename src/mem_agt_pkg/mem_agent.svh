class mem_agent extends uvm_agent;
    `uvm_component_utils(mem_agent)

    mem_driver       mem_drv;

    mem_sequencer    mem_seqer;
    mem_monitor      mem_mon;

    function new(string name = "mem_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (get_is_active()) begin
            $display("Active ------------------------->");
            mem_drv = new("mem_drv", this);
            //mem_seq = new("mem_seq");
            mem_seqer = new("mem_seqer", this);
        end
            mem_mon = new("mem_mon", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        if (get_is_active()) begin
            mem_drv.seq_item_port.connect(mem_seqer.seq_item_export);
        end
    endfunction

endclass
