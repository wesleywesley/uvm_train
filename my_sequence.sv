class my_sequence extends uvm_sequence#(packet);
    `uvm_object_utils(my_sequence)

    function new(string name = "my_sequence");
        super.new(name);
    endfunction

    task body();
        //packet my_packet = new("triple_packet");
        packet my_packet;// = new("triple_packet");
        //void'(my_packet.randomize());
        `uvm_do(my_packet);
        $display("my_sequence ------------------------->");
        my_packet.print();
    endtask


endclass
