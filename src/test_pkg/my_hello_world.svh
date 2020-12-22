
class my_hello_world extends uvm_test;

    `uvm_component_utils(my_hello_world)

    function new(string name, uvm_component parent);
       super.new(name, parent);
    endfunction : new

    task run_phase(uvm_phase phase);
        $display("hello world!");

        begin
            packet my_packet = new("my_packet");
            void'(my_packet.randomize());
            my_packet.print();
        end


        //copy
        begin
            packet packet1 = new("packet1");
            packet packet2 = new("packet2");
            void'(packet1.randomize());
            packet1.print();
            void'(packet2.randomize());
            packet2.print();

            packet2.copy(packet1);
            `uvm_info("TEST", "After copy", UVM_LOW)
            packet2.print();

            `uvm_info("TEST", "compare packet 1 :2", UVM_LOW)
            packet1._compare(packet2);
        end

        //clone
        begin
            packet packet3 = new("packet3");
            packet packet4;
            void'(packet3.randomize());
            packet3.print();

            $cast(packet4, packet3.clone());
            `uvm_info("TEST", "After clone", UVM_LOW)
            packet4.print();

            `uvm_info("TEST", "compare packet 3 :4", UVM_LOW)
            packet3._compare(packet4);
        end

        //pack/unpack
        begin
            byte unsigned m_bytes[];
            packet packet5 = new("packet5");
            packet packet6 = new("packet6");
            void'(packet5.randomize());
            packet5.print();

            packet5.pack_bytes(m_bytes);
            `uvm_info(get_type_name(), $sformatf("m_bytes=%p", m_bytes), UVM_LOW)

            void'(packet6.unpack_bytes(m_bytes));
            packet6.print();

            `uvm_info("TEST", "compare packet 5 :6", UVM_LOW)
            packet5._compare(packet6);
        end

    endtask : run_phase

endclass : my_hello_world
