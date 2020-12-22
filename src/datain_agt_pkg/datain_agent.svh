class datain_agent extends uvm_agent;
    `uvm_component_utils(datain_agent)

    datain_driver       datain_drv;

    datain_sequencer    datain_seqer;
    datain_monitor      datain_mon;

    function new(string name = "datain_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (get_is_active()) begin
            $display("Active ------------------------->");
            datain_drv = new("datain_drv", this);
            //datain_seq = new("datain_seq");
            datain_seqer = new("datain_seqer", this);
        end
            datain_mon = new("datain_mon", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        if (get_is_active()) begin
            datain_drv.seq_item_port.connect(datain_seqer.seq_item_export);
        end
    endfunction

endclass
