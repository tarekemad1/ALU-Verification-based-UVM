class scoreboard extends uvm_subscriber #(result_transaction);

    `uvm_component_utils(scoreboard);
    uvm_tlm_analysis_fifo#(sequence_item) cmd_fifo ;

    function new(string name , uvm_component parent);
        super.new(name,parent);
    endfunction :new

    function void build_phase(uvm_phase phase);
        cmd_fifo = new("cmd_fifo",this);
    endfunction :build_phase

    function result_transaction golden_model(sequence_item cmd);

        result_transaction result_transaction_h ; 

        if (cmd.mode_a) begin
            case (cmd.op_a)
                AND  : result_transaction_h.result = cmd.in_a &cmd.in_b     ;
                NAND : result_transaction_h.result = !(cmd.in_a & cmd.in_b) ; 
                OR   : result_transaction_h.result = cmd.in_a | cmd.in_b    ;
                XOR  : result_transaction_h.result = cmd.in_a ^ cmd.in_b    ;
            endcase
        end 
        else if (cmd.mode_b) begin
            case (cmd.op_b)
                XNOR      : result_transaction_h.result = !(cmd.in_a ^ cmd.in_b);
                AND_OP_B  : result_transaction_h.result =   cmd.in_a & cmd.in_b   ; 
                NOR       : result_transaction_h.result = !(cmd.in_a | cmd.in_b);
                OR_OP_B   : result_transaction_h.result =   cmd.in_a | cmd.in_b   ;
            endcase
        end 
        return result_transaction_h ;
    endfunction :golden_model

    function void write(result_transaction t);
    
        string data_str ;
        sequence_item cmd ;
        result_transaction predicted; 
        uvm_comparer comparer; 

        do
        if (!cmd_fifo.try_get(cmd)) 
            `uvm_fatal(get_type_name,"No commands yet")
        while (!cmd.rst_n ) ;

        predicted = golden_model(cmd);

        data_str = {cmd.convert2string(),"--> Actual out : ",t.convert2string(),"Expected output ->",predicted.convert2string()};

        if (predicted.do_compare(t,comparer)) 
            `uvm_info("SELF_CHECKER",{"PASS  : ",data_str},UVM_HIGH)
        else
            `uvm_error("SELF_CHECKER",{"FAIL : ",data_str});
        
    endfunction :write
endclass