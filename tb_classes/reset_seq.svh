class reset_seq extends base_sequence;
    `uvm_object_utils(reset_seq);
    sequence_item item ;
    function new(string name = "reset_seq");
        super.new(name );
    endfunction
    task body() ;
        item=sequence_item::type_id::create("item");
        start_item(item);
        RESET_RANDOMIZE: assert (item.randomize() with{rst_n==0;})
            else $error("Assertion RESET_RANDOMIZE failed!");
        finish_item(item);
    endtask
endclass