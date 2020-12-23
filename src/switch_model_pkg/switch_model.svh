class switch_scb extends uvm_scoreboard;
    `uvm_object_utils(switch_scb)

    function new(string name = "switch_scb", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    uvm_analysis_imp #(packet,switch_scb) anlse_imp; 

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        anlse_imp = new("anlse_imp", this);
    endfunction
    
    virtual function void write(packet pkt_in);
        pkt_in.print();
        $display("switch scb received packet ------------------------->");
    endfunction

    task run_phase(uvm_phase phase);
        //
    endtask

    virtual function void check_phase(uvm_phase phase);
        //
    endfunction

endclass
