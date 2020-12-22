class datain_sequencer extends uvm_sequencer#(packet);
    `uvm_component_utils(datain_sequencer)

    function new(string name = "datain_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction
endclass
