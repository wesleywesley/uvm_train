class my_agent extends uvm_agent;
    `uvm_component_utils(my_agent)

    my_driver       my_drv;
    my_sequence     my_seq;
    my_sequencer    my_seqer;
    my_monitor      my_mon;

    function new(string name = "my_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (get_is_active()) begin
            $display("Active ------------------------->");
            my_drv = new("my_drv", this);
            my_seq = new("my_seq");
            my_seqer = new("my_seqer", this);
        end
            my_mon = new("my_mon", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        if (get_is_active()) begin
            my_drv.seq_item_port.connect(my_seqer.seq_item_export);
        end
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);//for my_sequence run body()
        my_seq.start(my_seqer);//run body()
        phase.drop_objection(this);
    endtask


endclass
