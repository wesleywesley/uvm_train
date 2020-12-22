
class anlsp_test extends uvm_test;

    `uvm_component_utils(anlsp_test)
    
    my_src src;
    my_dst dst;

    function new(string name, uvm_component parent);
       super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase (phase);
           src = new("my_src", this);
           dst = new("my_dst", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase (phase);
           src.anlsp.connect(dst.anlse_imp);
           src.anlsp.connect(dst.anlse_input_imp);
           src.anlsp.connect(dst.anlse_output_imp);
    endfunction

/*
    task run_phase(uvm_phase phase);
        $display("analysis port test!");

        begin
           //src.anlsp.write();
        end

    endtask : run_phase
*/
endclass : anlsp_test 
