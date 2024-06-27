program seq;
    class rst_sequence extends uvm_sequence#(sequence_item);

        `uvm_object_utils(rst_sequence);
        sequence_item command ; 
        function new(string name ="rst_sequence");
            super.new(name);
        endfunction
        task body;
            command = sequence_item::type_id::create("rst_sequence");
            start_item(command);
            command.rst_n =1'b0;
            #400;
            command.rst_n =1'b1; 
            finish_item(command);
            
        endtask
    endclass;
        
    endclass
    
endprogram