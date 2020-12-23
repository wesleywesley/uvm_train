
package test_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import mem_pkg::*;
  import packet_pkg::*;
  import datain_agt_pkg::*;
  import dataout_agt_pkg::*;
  import mem_agt_pkg::*;
  import switch_model_pkg::*;
  import switch_env_pkg::*;

  `include "agent_test.svh"

  `include "anlsp.svh"
  `include "anlsp_test.svh"

  `include "my_hello_world.svh"
  `include "triple.svh"

  `include "env_test.svh" //add env based on agent test

endpackage : test_pkg
