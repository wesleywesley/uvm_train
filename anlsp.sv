class my_src extends uvm_component;

    `uvm_component_utils(my_src)

    uvm_analysis_port #(packet) anlsp;

    function new(string name, uvm_component parent = null);
       super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase (phase);
        anlsp = new("analysis_port", this);
    endfunction

    task run_phase(uvm_phase phase);
        packet anlsp_pkt = new("analysis_port_pkt");
        //packet anlsp_pkt = packet::type_id::create("anlsp_pkt", this);
        super.run_phase(phase);
        //packet anlsp_pkt = new("analysis_port_pkt");
        void'(anlsp_pkt.randomize());
        anlsp.write(anlsp_pkt);
    endtask
endclass


`uvm_analysis_imp_decl(_input)
`uvm_analysis_imp_decl(_output)


class my_dst extends uvm_component;

    `uvm_component_utils(my_dst)
    
    uvm_analysis_imp #(packet, my_dst) anlse_imp;
    uvm_analysis_imp_input  #(packet, my_dst) anlse_input_imp;
    uvm_analysis_imp_output #(packet, my_dst) anlse_output_imp;
    
    function new(string name, uvm_component parent = null);
       super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase (phase);
        anlse_imp = new("analse_imp", this);
        anlse_input_imp = new("anlse_input_imp", this);
        anlse_output_imp = new("anlse_output_imp", this);
    endfunction

    function void write(packet pkt);
        pkt.print();
    endfunction

    function void write_input(packet pkt);
        $display("Write_input ------------------------->");
        pkt.print();
    endfunction

    function void write_output(packet pkt);
        $display("Write_output ------------------------->");
        pkt.print();
    endfunction

endclass
