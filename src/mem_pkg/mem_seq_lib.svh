class mem_sequence extends uvm_sequence#(mem);
    `uvm_object_utils(mem_sequence)

    function new(string name = "mem_sequence");
        super.new(name);
    endfunction

    task body();
        mem mem_input;
        `uvm_do(mem_input);
        $display("mem_sequence ------------------------->");
        mem_input.print();
    endtask

endclass
