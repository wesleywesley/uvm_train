`include "mem_interface.sv"

package mem_agt_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import mem_pkg::*;


  `include "mem_driver.svh"
  `include "mem_monitor.svh"
  `include "mem_sequencer.svh"
  `include "mem_agent.svh"

endpackage : mem_agt_pkg
