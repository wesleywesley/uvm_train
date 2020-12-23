class datain_sequence extends uvm_sequence#(packet);
    rand bit [7:0] _DA;

    `uvm_object_utils(datain_sequence)

    function new(string name = "datain_sequence");
        super.new(name);
    endfunction

    task body();
        //packet datain_packet = new("triple_packet");
        packet datain_packet;// = new("triple_packet");
        //void'(datain_packet.randomize());
        `uvm_do_with(datain_packet, { DA == _DA; });
        $display("datain_sequence ------------------------->");
        datain_packet.print();
    endtask

endclass
