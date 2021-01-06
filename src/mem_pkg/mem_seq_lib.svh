class mem_sequence extends uvm_sequence#(mem);

    rand bit [7:0] DA = 8'hbd;

    rand bit RW = 1'b1;  //1: write , 0: read

    `uvm_object_utils(mem_sequence)

    function new(string name = "mem_sequence");
        super.new(name);
    endfunction

    task body();
        mem mem_input;
        `uvm_do_with(mem_input, {memory_data == DA; memory_cmd == RW;});
        $display("mem_sequence ------------------------->");
        mem_input.print();
    endtask

endclass
