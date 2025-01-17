
class base_test extends uvm_test;

   env       env_h; 
   sequencer sequencer_h;
   
   function void build_phase(uvm_phase phase);
      env_h = env::type_id::create("env_h",this);
   endfunction : build_phase

   function void end_of_elaboration_phase(uvm_phase phase);
      sequencer_h = env_h.agent_h.sequencer_h;
   endfunction : end_of_elaboration_phase


   function new (string name, uvm_component parent);
      super.new(name,parent);
   endfunction : new

endclass