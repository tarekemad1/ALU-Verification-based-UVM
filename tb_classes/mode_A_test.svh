class mode_A_test extends base_test;
    `uvm_component_utils(mode_A_test);
    function new(string name, uvm_component parent);
        super.new(name , parent); 
    endfunction
    
        task run_phase(uvm_phase phase);    
            reset_seq rst_seq_h ; 
            mode_A_seq  sequence_A;
            sequence_A = mode_A_seq::type_id::create("sequence_A");
            rst_seq_h  = reset_seq::type_id::create("reset_seq");
            phase.raise_objection(this);
            sequence_A.start(sequencer_h);
            #40
            rst_seq_h.start(sequencer_h);

            phase.drop_objection(this);   
        endtask :run_phase    

endclass