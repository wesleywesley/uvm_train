class dataout_agent extends uvm_agent;
    `uvm_component_utils(dataout_agent)

    dataout_driver       dataout_drv;

    dataout_sequencer    dataout_seqer;
    dataout_monitor      dataout_mon;

    function new(string name = "dataout_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (get_is_active()) begin
            $display("Active ------------------------->");
            dataout_drv = new("dataout_drv", this);
            //dataout_seq = new("dataout_seq");
            dataout_seqer = new("dataout_seqer", this);
        end
            dataout_mon = new("dataout_mon", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        if (get_is_active()) begin
            dataout_drv.seq_item_port.connect(dataout_seqer.seq_item_export);
        end
    endfunction

endclass
