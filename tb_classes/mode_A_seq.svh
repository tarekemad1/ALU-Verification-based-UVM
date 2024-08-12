class mode_A_seq extends base_sequence;
    `uvm_object_utils(mode_A_seq);
    sequence_item item ; 
    function new(string name = "mode_A_seq");
        super.new(name); 
    endfunction
    task body(); 
        repeat(200) 
        begin 
            item = sequence_item::type_id::create("item");
            start_item(item); 
            MODE_A_SEQ: assert (item.randomize() with{alu_enable_a ==1'b1;})
                else $error("Assertion MODE A SEQ failed!");
            finish_item(item);
        end 
    endtask
endclass