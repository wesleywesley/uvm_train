`include "dataout_interface.sv"

package dataout_agt_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import packet_pkg::*;


  `include "dataout_driver.svh"
  `include "dataout_monitor.svh"
  `include "dataout_sequencer.svh"
  `include "dataout_agent.svh"

endpackage : dataout_agt_pkg
