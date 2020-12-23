
class mem extends uvm_sequence_item;

    rand bit [1:0] memory_addr;
    rand bit [7:0] memory_data;
    rand bit memory_cmd;//

    constraint memory_addr_range {memory_addr >= 2'h0; memory_addr <= 2'h3;}

    `uvm_object_utils_begin(mem)
        `uvm_field_int(memory_addr, UVM_ALL_ON)
        `uvm_field_int(memory_data, UVM_ALL_ON)
        `uvm_field_int(memory_cmd, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "mem");
        super.new(name);
    endfunction : new
 
endclass : mem
