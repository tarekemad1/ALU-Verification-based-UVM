
    class reset_sequence extends uvm_sequence#(sequence_item);

        `uvm_object_utils(reset_sequence);
        sequence_item command ; 
        function new(string name ="reset_sequence");
            super.new(name);
        endfunction
        task body;
            command = sequence_item::type_id::create("reset_sequence");
            start_item(command);
            command.rst_n =1'b0;
            #400;
            command.rst_n =1'b1; 
            finish_item(command);
            
        endtask
    endclass;
        
    
