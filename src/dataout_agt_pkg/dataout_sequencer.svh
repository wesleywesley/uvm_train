class dataout_sequencer extends uvm_sequencer#(packet);
    `uvm_component_utils(dataout_sequencer)

    function new(string name = "dataout_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction
endclass
