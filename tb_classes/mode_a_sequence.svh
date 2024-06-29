    class mode_a_sequence extends uvm_sequence#(uvm_sequence_item);

        `uvm_object_utils(mode_a_sequence);
        sequence_item command; 
        function new(string name = "mode_a_sequence");
            super.new(name);
        endfunction

        task body;
            repeat(10) begin 
            command = sequence_item::type_id::create("sequence_command");
            start_item(command);
            MODE_A_Randomization: assert (command.randomize()with{command.mode_a==1'b1;})
                else $error("Assertion MODE_A_Randomization failed!");
            finish_item(command);
            end 
        endtask
    endclass