class my_driver extends uvm_driver#(packet);
    `uvm_component_utils(my_driver)

    function new(string name = "my_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(req);
            $display("my_driver ------------------------->");
            req.print();
            #10;
            seq_item_port.item_done();
        end
    endtask
endclass
