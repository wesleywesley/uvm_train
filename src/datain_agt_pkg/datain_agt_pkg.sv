`include "interface.sv"

package datain_agt_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import packet_pkg::*;


  `include "datain_driver.svh"
  `include "datain_monitor.svh"
  `include "datain_sequencer.svh"
  `include "datain_agent.svh"

endpackage : datain_agt_pkg
