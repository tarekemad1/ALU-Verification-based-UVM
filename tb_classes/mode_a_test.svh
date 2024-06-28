    class mode_a_test extends base_test;
        `uvm_component_utils(mode_a_test);

        task run_phase(uvm_phase phase);

            mode_a_sequence sequence_A;
            sequence_A = new("sequence_A");
            phase.raise_objection(this);
            sequence_A.start(sequencer_h);
            phase.drop_objection(this);
            
        endtask :run_phase


        function new(string name,uvm_component parent);
            super.new(name,parent);
        endfunction :new

    endclass