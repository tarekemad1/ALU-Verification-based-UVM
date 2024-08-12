class driver extends uvm_driver#(sequence_item) ;
    `uvm_component_utils(driver);
    sequence_item item ; 
    virtual IF vif ;

    function new(string name , uvm_component parent);
        super.new(name , parent);
    endfunction

    function void build_phase(uvm_phase phase );
        super.build_phase(phase);
        if(!uvm_config_db #(virtual IF)::get(null,"*","vif",vif))
            `uvm_error(get_type_name(),"Failed get interface");
    endfunction
    
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin 
            item = sequence_item::type_id::create("item");
            seq_item_port.get_next_item(item);
            drive(item);
            seq_item_port.item_done();

        end 
    endtask
    task drive(sequence_item item);
        vif.rst_n           = item.rst_n ;
        @( posedge vif.clk);
        vif.alu_enable   =item.alu_enable;
        vif.alu_enable_a = item.alu_enable_a;
        vif.alu_enable_b = item.alu_enable_b; 
        vif.alu_op_a     =item.alu_op_a; 
        vif.alu_op_b     =item.alu_op_b; 
        vif.alu_in_a     =item.alu_in_a; 
        vif.alu_in_b     =item.alu_in_b; 
        vif.alu_irq_clr  =item.alu_irq_clr; 
        
    endtask
endclass