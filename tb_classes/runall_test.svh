/*    import uvm_pkg ::*;
    `include "uvm_macros.svh"
    `include "sequence_item.svh"
    `include "env.svh"
    
    `include "mode_a_sequence.svh"
    `include "mode_b_sequence.svh"
    `include "reset_sequence.svh"
    `include "random_sequence.svh"
    `include "runall_sequence.svh"
    `include "base_test.svh"
program runall_test;
endprogram */
    class runall_test extends base_test;
    `uvm_component_utils(runall_test);
    runall_sequence runall_sequence_h ; 

    function new(string name , uvm_component parent);
        super.new(name,parent);
        runall_sequence_h =new("runall_sequence_h");
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        runall_sequence_h.start(sequencer_h);
        phase.drop_objection(this);
    endtask
    endclass    
 
