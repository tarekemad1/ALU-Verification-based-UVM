class driver extends uvm_driver #(sequence_item);

    `uvm_component_utils(driver);
    
    
    virtual IF vif ; 
    function new(string name , uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        if(!uvm_config_db#(virtual IF)::get(null,"*","vif",vif))
            `uvm_fatal(get_type_name(),"Failed to get interface");
    endfunction
    /*send_op(input bit reset_n , input bit alu_enable_t ,input bit mode_a ,input bit mode_b ,
                 input operation_a op_a , input operation_b op_b,input bit[7:0] in_a ,
                 input bit[7:0] in_b,output bit[7:0] alu_out_t)*/
    task run_phase(uvm_phase phase);

        sequence_item cmd ;

        forever 
        begin 
        bit[7:0] result ;
        seq_item_port.get_next_item(cmd);

        vif.send_op(cmd.rst_n , cmd.alu_enable , cmd.mode_a , cmd.mode_b , cmd.op_a , cmd.op_b , cmd.in_a ,
                    cmd.in_b  , result );

        cmd.out_alu = result ;

        seq_item_port.item_done();

        end 
    endtask
endclass