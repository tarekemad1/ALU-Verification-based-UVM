    class random_sequence extends uvm_sequence#(sequence_item);

        `uvm_object_utils(random_sequence);

        sequence_item command; 

        function new(string name ="random_sequence");
            super.new(name);
        endfunction
        task body();
            repeat(400) begin 
                command = sequence_item::type_id::create("command");
                start_item(command);
                Randomize_command: assert (command.randomize())
                    else $error("Assertion Randomize_command failed!");
                finish_item(command);
            end 
            
        endtask
    endclass