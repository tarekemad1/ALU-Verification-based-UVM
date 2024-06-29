    class runall_sequence extends uvm_sequence#(sequence_item);
    `uvm_object_utils(runall_sequence);

    reset_sequence reset_h ;
    mode_a_sequence mode_a_h ;
    mode_b_sequence mode_b_h ;
    random_sequence random_sequence_h; 
    sequencer sequencer_h ; 
    uvm_component uvm_component_h ; 

    function new(string name = "runall_sequence" );
        super.new(name);
        uvm_component_h = uvm_top.find(".*env_h.sequencer_h");
        if(uvm_component_h ==  null)
            `uvm_fatal("RUNALL SEQUENCE", "Failed to get the sequencer");
        if (!$cast(sequencer_h,uvm_component_h)) 
            `uvm_fatal("RUNALL SEQUENCE", "Failed to cast from uvm_component_h.");
        reset_h = reset_sequence::type_id::create("reset_h");
        mode_a_h = mode_a_sequence::type_id::create("mode_a_h");
        mode_b_h =mode_b_sequence ::type_id::create("mode_b_h");
        random_sequence_h = random_sequence::type_id::create("random_sequence_h");
        
    endfunction :new
    task body;
        reset_h.start(sequencer_h);
        mode_a_h.start(sequencer_h);
        mode_b_h.start(sequencer_h);
        random_sequence_h.start(sequencer_h);
    endtask
endclass    

