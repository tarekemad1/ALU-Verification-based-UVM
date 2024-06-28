    class random_test extends base_test;
        `uvm_component_utils(random_test);

        task run_phase(uvm_phase phase);

            random_sequence random_sequence_h;
            random_sequence_h = new("random_sequence_h");
            phase.raise_objection(this);
            random_sequence_h.start(sequencer_h);
            phase.drop_objection(this);
            
        endtask :run_phase


        function new(string name,uvm_component parent);
            super.new(name,parent);
        endfunction :new

    endclass