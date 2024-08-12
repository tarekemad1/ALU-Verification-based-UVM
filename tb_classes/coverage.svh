class coverag extends uvm_subscriber#(sequence_item);
    `uvm_component_utils(coverag);
    sequence_item item  ;
    uvm_analysis_imp#(sequence_item,coverag) cvrg_imp;

    covergroup ALU_SIGNALS;
        RESEST:coverpoint item.rst_n {bins RESET_ACTIV = {0};bins RESET_DEACTIVE ={1};}
        GENERAL_ENABLE:coverpoint item.alu_enable {bins ALU_EN ={1} ; bins ALU_NOT_EN ={0}; }
        MODE_A:coverpoint item.alu_enable_a{bins EN_MODE_A ={1} ;bins NOT_EN_MODE_A = {0}; }
        MODE_B:coverpoint item.alu_enable_b{bins EN_MODE_B={1}; bins NOT_EN_MODE_B = {0};}
        OPERATION_A: coverpoint item.alu_op_a 
        {
            bins AND ={2'b00};
            bins NAND ={2'b01};
            bins OR   = {2'b10};
            bins XOR  = {2'b11};
        }
        OPERATION_B: coverpoint item.alu_op_b
        {
            bins XNOR = {2'b00};
            bins AND  = {2'b01};
            bins NOR  = {2'b10};
            bins OR   = {2'b11};
        }
        IN_A : coverpoint item.alu_in_a {option.auto_bin_max = 6;}
        IN_B : coverpoint item.alu_in_b {option.auto_bin_max = 6;}
        INTRBT_CLEAR : coverpoint item.alu_irq_clr { bins interrupt_clear = {1} ; bins NOT_interrupt_clear = {0} ;} 
    endgroup


    
    function new(string name , uvm_component parent);
        super.new(name,parent);
        ALU_SIGNALS = new();
    endfunction :new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        cvrg_imp = new("cvrg_imp",this);
    endfunction :build_phase


    function void write(sequence_item t );
        item = sequence_item::type_id::create("item");
        $cast(item, t ); 
        ALU_SIGNALS.sample();

    endfunction :write
endclass