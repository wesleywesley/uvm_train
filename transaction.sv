
class packet extends uvm_sequence_item;

    rand byte DA;
    rand byte SA;
    rand byte length;
    rand byte Data[];
    rand byte FCS;

    constraint default_range { Data.size() == length; }

    constraint DA_range {DA > 8'hd0; DA < 8'hdf;}

    `uvm_object_utils_begin(packet)
        `uvm_field_int(DA, UVM_ALL_ON)
        `uvm_field_int(SA, UVM_ALL_ON)
        `uvm_field_int(length, UVM_ALL_ON)
        `uvm_field_array_int(Data, UVM_ALL_ON)
        `uvm_field_int(FCS, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "packet");
        super.new(name);
    endfunction : new
 
 
    function int unpack_bytes (ref byte unsigned bytestream[],
                                 input uvm_packer packer=null);

        this.Data.delete();
        this.Data = new[bytestream[2]];

        super.unpack_bytes(bytestream, packer);
    endfunction : unpack_bytes

    function void _compare(packet p1, packet p2);
        if (p2.compare(p1))
            `uvm_info("compare", "p1 == p2", UVM_LOW)
        else
            `uvm_info("compare", "p1 != p2", UVM_LOW)
    endfunction : _compare
            

endclass : packet
