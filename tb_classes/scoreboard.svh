class scoreboard extends uvm_subscriber#(sequence_item);
    `uvm_component_utils(scoreboard);
    uvm_analysis_imp#(sequence_item,scoreboard) scb_imb;
    sequence_item items_q[$];
    sequence_item act_item; 
    
    function new(string name , uvm_component parent);
        super.new(name,parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        scb_imb= new("scb_imb",this);
    endfunction

    function void write(sequence_item t);
        items_q.push_back(t);
    endfunction

    task run_phase(uvm_phase phase);
        bit[7:0] exp_rslt ;
        super.run_phase(phase);
         
        forever begin 
            act_item =sequence_item::type_id::create("act_item");
            wait(items_q.size());
            act_item = items_q.pop_front();
            #10;
            exp_rslt = golden_model(act_item);
            #0;
            compare(act_item.alu_out,exp_rslt);
        end 
    endtask

    function bit[15:0] golden_model(sequence_item item);
        bit[15:0] exp_rslt; 
        if(!item.rst_n )
            exp_rslt = 'h0; 
        else if  (item.alu_enable & item.alu_enable_a)
        begin 
            case (item.alu_op_a)
                AND:exp_rslt = item.alu_in_a & item.alu_in_b;
                NAND:exp_rslt= ~(item.alu_in_a & item.alu_in_b);
                OR: exp_rslt = item.alu_in_a | item.alu_in_b;
                XOR:exp_rslt = item.alu_in_a ^ item.alu_in_b ;
            endcase    
        end 
        else if (item.alu_enable & item.alu_enable_b)
        begin
            case (item.alu_op_b)
                XNOR :exp_rslt   = ~(item.alu_in_a ^ item.alu_in_b);
                AND_OP_B:exp_rslt= item.alu_in_a & item.alu_in_b;
                NOR:exp_rslt     = ~(item.alu_in_a | item.alu_in_b);
                OR_OP_B:exp_rslt = item.alu_in_a | item.alu_in_b; 
            endcase
        end
        return exp_rslt; 
    endfunction
    function void compare(bit[15:0] actual_rslt,bit[15:0] exp_rslt);
        string  s ;
        s ={act_item.convert2string()};
        if (exp_rslt != actual_rslt) 
        begin
            `uvm_error("SELF_CHECKER", {"FAIL : ", s, $sformatf("       Actual Result = %0h     Expected Result = %0h", actual_rslt, exp_rslt)});

        end 
        else
            `uvm_info("SELF_CHECKER", {"SUCCESS : ", s, $sformatf("     Actual Result = %0h     Expected Result = %0h", actual_rslt, exp_rslt)}, UVM_MEDIUM);

    endfunction


endclass :scoreboard