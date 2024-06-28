    class mode_b_test extends base_test;
        `uvm_component_utils(mode_b_test);

        task run_phase(uvm_phase phase);

            mode_b_sequence sequence_B;
            sequence_B = new("sequence_B");
            phase.raise_objection(this);
            sequence_B.start(sequencer_h);
            phase.drop_objection(this);
            
        endtask :run_phase


        function new(string name,uvm_component parent);
            super.new(name,parent);
        endfunction :new

    endclass