class full_test extends base_test;
    `uvm_component_utils(full_test);
    function new(string name,uvm_component parent);
        super.new(name,parent);
    endfunction


        task run_phase(uvm_phase phase);    
            reset_seq rst_seq_h ; 
            mode_A_seq  sequence_A;
            mode_B_seq  sequence_B;

            sequence_A = mode_A_seq::type_id::create("sequence_A");
            sequence_B = mode_B_seq::type_id::create("sequence_B");
            rst_seq_h  = reset_seq::type_id::create("reset_seq");

            phase.raise_objection(this);
            sequence_A.start(sequencer_h);
            rst_seq_h.start(sequencer_h);
            sequence_B.start(sequencer_h);
            rst_seq_h.start(sequencer_h);
            phase.drop_objection(this);   
        endtask :run_phase  
endclass