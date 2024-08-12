class mode_B_test extends base_test;
    `uvm_component_utils(mode_B_test);
    function new(string name, uvm_component parent);
        super.new(name , parent); 
    endfunction
    
        task run_phase(uvm_phase phase);    
            reset_seq rst_seq_h ; 
            mode_B_seq  sequence_B;
            sequence_B = mode_B_seq::type_id::create("sequence_B");
            rst_seq_h  = reset_seq::type_id::create("reset_seq");
            phase.raise_objection(this);
            sequence_B.start(sequencer_h);
            #40
            rst_seq_h.start(sequencer_h);

            phase.drop_objection(this);   
        endtask :run_phase    

endclass