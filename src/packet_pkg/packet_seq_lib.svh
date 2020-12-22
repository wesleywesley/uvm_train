class datain_sequence extends uvm_sequence#(packet);
    `uvm_object_utils(datain_sequence)

    function new(string name = "datain_sequence");
        super.new(name);
    endfunction

    task body();
        //packet datain_packet = new("triple_packet");
        packet datain_packet;// = new("triple_packet");
        //void'(datain_packet.randomize());
        `uvm_do(datain_packet);
        $display("datain_sequence ------------------------->");
        datain_packet.print();
    endtask

endclass
