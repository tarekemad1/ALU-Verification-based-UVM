    class mode_b_sequence extends uvm_sequence#(uvm_sequence_item);

        `uvm_object_utils(mode_b_sequence);
        sequence_item command; 
        function new(string name = "mode_b_sequence");
            super.new(name);
        endfunction

        task body;
            command = sequence_item::type_id::create("command");
            start_item(command);
            MODE_A_Randomization: assert (command.randomize()with{command.mode_b==1'b1;})
                else $error("Assertion MODE_A_Randomization failed!");
            finish_item(command);
        endtask
    endclass