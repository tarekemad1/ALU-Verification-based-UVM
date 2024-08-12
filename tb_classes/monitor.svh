class monitor extends uvm_monitor;
    `uvm_component_utils(monitor);
    sequence_item item ; 
    virtual IF vif ; 
    uvm_analysis_port#(sequence_item) ap; 
    function new(string name , uvm_component parent);
        super.new(name, parent);
        ap = new("ap",this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase); 
        if(!uvm_config_db#(virtual IF)::get(null,"*","vif",vif))
            `uvm_error(get_type_name(),"Failed to get interface");
    endfunction
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin 
            item = sequence_item::type_id::create("item");
            item.rst_n        = vif.rst_n;
            item.alu_enable   = vif.alu_enable;
            item.alu_enable_a = vif.alu_enable_a;
            item.alu_enable_b = vif.alu_enable_b;
            item.alu_op_a     = op2enum_modeA(vif.alu_enable_a,vif.alu_op_a);
            item.alu_op_b     = op2enum_modeB(vif.alu_enable_b,vif.alu_op_b);
            item.alu_in_a     =  vif.alu_in_a;
            item.alu_in_b     = vif.alu_in_b; 
            item.alu_irq_clr  = vif.alu_irq_clr;
            @(posedge vif.clk);
            @(posedge vif.clk);
            item.alu_irq    = vif.alu_irq ;
            item.alu_out    = vif.alu_out ;
            ap.write(item); 
        end
    endtask
        function op_a_e op2enum_modeA(logic alu_enable_a,bit[1:0] alu_op_a);
        if (alu_enable_a=='1) 
        begin
            case (alu_op_a)
                2'b00: return AND ; 
                2'b01: return NAND;
                2'b10: return OR  ;
                2'b11: return XOR ; 
            endcase
        end
        endfunction :op2enum_modeA
        function op_b_e op2enum_modeB(logic alu_enable_b,bit[1:0] alu_op_b);
        if (alu_enable_b=='1) begin
            case (alu_op_b)
                2'b00 : return XNOR     ; 
                2'b01 : return AND_OP_B ; 
                2'b10 : return NOR      ;
                2'b11 : return OR_OP_B  ; 
            endcase
        end
        endfunction :op2enum_modeB


endclass