class my_monitor extends uvm_monitor;

    typedef enum {
        IDLE = 0,
        BUSY = 1
    } SM;

    SM state;

    `uvm_component_utils(my_monitor)

    function new(string name = "my_monitor", uvm_component parent = null);
        super.new(name, parent);
        state = IDLE;
    endfunction

    virtual pktin_intf pkt_in;
    uvm_analysis_port#(packet) mon_analysis_port;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        mon_analysis_port = new("mon_analysis_port", this);
        if (!uvm_config_db#(virtual pktin_intf)::get(this, "", "packet_in", pkt_in)) begin
            `uvm_error("GET_DB_ERR", $psprintf("%s fail to get pkt_in virtual interface!", this.get_full_name())) 
        end
    endfunction

    virtual task run_phase(uvm_phase phase);

        packet mon_pkt;
        byte unsigned pkt_data_q[$];

        forever begin
            //mon_pkt.Data = pkt_in.data_in; //interface & transaction, compile error?
            @(pkt_in.mon_cb);

            if(this.state == IDLE && pkt_in.mon_cb.packet_valid == 1) begin 
                mon_pkt = packet::type_id::create("mon_pkt", this);
                this.state = BUSY;
            end
 
            if(this.state == BUSY) begin
                if(pkt_in.mon_cb.packet_valid == 1) begin
                    pkt_data_q.push_back(pkt_in.mon_cb.data_in);
                end
                else begin
                    byte unsigned pkt_data_array [];
                    this.state = IDLE;
                    pkt_data_array = new[pkt_data_q.size()];
                    foreach(pkt_data_array[idx]) begin
                        pkt_data_array[idx] = pkt_data_q[idx];
                    end
                    mon_pkt.unpack_bytes(pkt_data_array);
                    $display("my_monitor ------------------------->");
                    mon_pkt.print();

                    begin
                      packet mon_pkt_clone;
                      if($cast(mon_pkt_clone, mon_pkt.clone)) begin
                          mon_analysis_port.write(mon_pkt_clone);
                      end
                    end
                    mon_pkt = null;
                    pkt_data_q.delete();
                end
            end
        end
    endtask

endclass
