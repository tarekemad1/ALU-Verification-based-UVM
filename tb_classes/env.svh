//typedef uvm_sequencer#(sequence_item) sequencer;
class env extends uvm_env;
    `uvm_component_utils(env);
    sequencer sequencer_h; 
    agent agent_h ; 
    config_agent config_agent_h; 
    virtual  IF vif ;

    function new(string name , uvm_component parent);
        super.new(name , parent);
    endfunction

    function void build_phase(uvm_phase phase);


        sequencer_h = new("sequencer_h",this);

        config_agent_h = new(.vif(vif),.is_active(UVM_ACTIVE));

        uvm_config_db#(config_agent)::set(this,"agent_*","config_agent",config_agent_h);

        agent_h =agent::type_id::create("agent_h",this);
    endfunction

endclass
/*Error: (vsim-7065) tb_classes/env.svh(22): Illegal assignment to class work.alu_pkg::config_agent from class work.alu_pkg::agent
#    Time: 0 ns  Iteration: 0  Region: /alu_pkg File: alu_pkg.sv
# ** Error: (vsim-13216) tb_classes/env.svh(15): Illegal assignment to type 'virtual vif' from type 'virtual IF':
#    Time: 0 ns  Iteration: 0  Region: /alu_pkg File: alu_pkg.sv
# ** Error: (vsim-8268) tb_classes/agent.svh(31): No Default value for formal 'parent' in task/function new.
#    Time: 0 ns  Iteration: 0  Region: /alu_pkg File: alu_pkg.sv
# ** Error: (vsim-8268) tb_classes/agent.svh(30): No Default value for formal 'parent' in task/function new.
#    Time: 0 ns  Iteration: 0  Region: /alu_pkg File: alu_pkg.sv
# ** Error: (vsim-8754) tb_classes/env.svh(15): Actual inout arg. of type 'virtual IF' for formal 'value' of 'get' is not compatible with the formal's type 'virtual vif'.
#    Time: 0 ns  Iteration: 0  Region: /alu_pkg File: alu_pkg.sv
# ** Error: (vsim-8754) tb_classes/env.svh(22): Actual input arg. of type 'class work.alu_pkg::agent' for formal 'value' of 'set' is not compatible with the formal's type 'class work.alu_pkg::config_agent'.
#    Time: 0 ns  Iteration: 0  Region: /alu_pkg File: alu_pkg.sv*/