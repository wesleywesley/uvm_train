class datain_driver extends uvm_driver#(packet);
    `uvm_component_utils(datain_driver)

    virtual pktin_intf pkt_in;

    function new(string name = "datain_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        //for triple.sv test, the followed 3 have to be commentted
        if (!uvm_config_db#(virtual pktin_intf)::get(this, "", "packet_in", pkt_in)) begin
            `uvm_error("GET_DB_ERR", $psprintf("%s fail to get pkt_in virtual interface!", this.get_full_name())) 
        end
    endfunction

    task run_phase(uvm_phase phase);
        
        pkt_in.drv_cb.packet_valid <= 0;
        pkt_in.drv_cb.data_in <= 0;

        forever begin
            packet pkt;
            seq_item_port.get_next_item(pkt);
            //seq_item_port.get_next_item(req);
            $display("dadtain_driver ------------------------->");
            pkt.print();
            //req.print();
            
            drive_item(pkt);
            seq_item_port.item_done();
        end
    endtask

    virtual task drive_item(packet pkt);
        byte unsigned m_bytes[];
        pkt.pack_bytes(m_bytes);

        @(pkt_in.drv_cb);

        
        for (int i = 0; i < m_bytes.size(); i++)begin 
            pkt_in.drv_cb.packet_valid <= 1;
            pkt_in.drv_cb.data_in <= m_bytes[i];
            @(pkt_in.drv_cb);

        end

        pkt_in.drv_cb.packet_valid <= 0;
        pkt_in.drv_cb.data_in <= 0;
    endtask
endclass
