class command_monitor extends uvm_component;
    
    `uvm_component_utils(command_monitor);

    uvm_analysis_port#(sequence_item) ap ; 
    virtual IF vif;
    function new(string name , uvm_component parent );
        super.new(name , parent);
    endfunction

    function void build_phase(uvm_phase phase); 
        
        ap = new("ap",this);
        if (!uvm_config_db #(virtual IF)::get(null,"*","vif",vif)) begin
            `uvm_fatal(get_type_name,"Failed to get interface ");
        end
        
    endfunction

    function void connect_phase(uvm_phase phase);
        vif.command_monitor_h = this ; 
    endfunction

    function void write_to_monitor(logic alu_enable_a ,logic alu_enable_b,bit[1:0]alu_op_a, bit[1:0] alu_op_b , bit [7:0]alu_in_a , bit [7:0]alu_in_b);

        sequence_item command ;
        command  =new("command");
        command.mode_a =alu_enable_a ;
        command.mode_b =alu_enable_b ; 
        command.op_a   = op2enum_modeA(alu_enable_a,alu_op_a)    ; 
        command.op_b   = op2enum_modeB(alu_enable_b,alu_op_b)    ; 
        command.in_a   = alu_in_a    ; 
        command.in_b   = alu_in_b    ; 
        ap.write(command);
    endfunction
   /*typedef enum bit[1:0] {AND,NAND,OR,XOR} operation_a;
    typedef enum bit[1:0] {XNOR,AND_OP_B,NOR,OR_OP_B} operation_b;*/

    function operation_a op2enum_modeA(logic alu_enable_a,bit[1:0] alu_op_a);
        if (alu_enable_a=='1) begin
            case (alu_op_a)
                2'b00: return AND ; 
                2'b01: return NAND;
                2'b10: return OR  ;
                2'b11: return XOR ; 
            endcase
        end
    endfunction
    function operation_b op2enum_modeB(logic alu_enable_b,bit[1:0] alu_op_b);
        if (alu_enable_b=='1) begin
            case (alu_op_b)
                2'b00 : return XNOR     ; 
                2'b01 : return AND_OP_B ; 
                2'b10 : return NOR      ;
                2'b11 : return OR_OP_B  ; 
            endcase
        end
    endfunction

endclass