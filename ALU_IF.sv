interface IF(input bit clk );
    import alu_pkg ::* ;
    logic        rst_n;
    logic        alu_enable;
    logic        alu_enable_a;
    logic        alu_enable_b;
    bit     [1:0]alu_op_a;
    bit     [1:0]alu_op_b;
    bit     [7:0]alu_in_a;
    bit     [7:0]alu_in_b;
    logic        alu_irq_clr;
    logic        alu_irq;
    bit     [7:0] alu_out;
    
    clocking cb @(posedge clk );
            output alu_enable;
            output alu_enable_a;
            output alu_enable_b;
            output alu_op_a ;
            output alu_op_b; 
            output alu_in_a;
            output alu_in_b;
            output alu_irq_clr;
            input alu_irq ;
            input alu_out ; 
    endclocking
    modport DUT (input clk , rst_n ,alu_enable,alu_enable_a,alu_enable_b,alu_op_a,alu_op_b,alu_in_a,alu_in_b,alu_irq_clr,
                 output alu_irq , alu_out);
    modport tb  (clocking cb ,output rst_n);
    function void reset;    
        alu_out = 'b0; 
        alu_irq = 'b0;
    endfunction

    task send_op(input bit reset_n ,input bit alu_enable_t ,input bit mode_a ,input bit mode_b ,
                 input operation_a op_a , input operation_b op_b,input bit[7:0] in_a ,
                 input bit[7:0] in_b,output bit[7:0] alu_out_t);

            rst_n = reset_n ; 
            alu_enable = alu_enable_t;
            alu_enable_a  = mode_a ; 
            alu_enable_b  = mode_b ; 
            alu_op_a      = op_a   ; 
            alu_op_b      = op_b   ; 
            alu_in_a      = in_a   ; 
            alu_in_b      = in_b   ; 
            alu_out_t       = alu_out;
            
    endtask
    command_monitor command_monitor_h ; 
    always @(posedge clk ) begin :moitor_command
        static bit in_command = 0 ;  //assuring new command ;
        if (alu_enable==1) begin
            if (!in_command) begin
                command_monitor_h.write_to_monitor(alu_enable_a , rst_n , alu_enable_b , alu_op_a ,alu_op_b , alu_in_a , alu_in_b);
                in_command=(alu_enable_a || alu_enable_b) ;
            end
            else begin
                in_command='0 ; 
            end         
        end
    end:moitor_command

    result_monitor result_monitor_h ; 

    always @(posedge clk) begin : monitor_result
        if (alu_enable==1) begin
           result_monitor_h.write_to_monitor(alu_out) ;
        end
    end :monitor_result
    always @(posedge clk ) begin : interrupt_raising 
        
    end :interrupt_raising
        sequence seq_alu_op_a_00;
        (alu_enable && alu_enable_a && (alu_op_a == 2'b00) ##1 alu_out ==(8'hFF));
    endsequence :seq_alu_op_a_00

    sequence seq_alu_op_a_01;
        (alu_enable && alu_enable_a && (alu_op_a == 2'b01) ##1 alu_out ==(8'h00));
    endsequence :seq_alu_op_a_01

    sequence seq_alu_op_a_10;
        (alu_enable && alu_enable_a && (alu_op_a == 2'b10) ##1 alu_out ==(8'hF8));
    endsequence :seq_alu_op_a_10

    sequence seq_alu_op_a_11;
        (alu_enable && alu_enable_a && (alu_op_a == 2'b11) ##1 alu_out ==(8'h83));
    endsequence
    ASSERT_MODE_A_OP_00: assert property (@(posedge clk) disable iff (!rst_n) seq_alu_op_a_00 |-> alu_irq)
        else $error("Assertion ASSERT_MODE_A_OP_00 failed!");
    ASSERT_MODE_A_OP_01: assert property (@(posedge clk) disable iff (!rst_n) seq_alu_op_a_01 |-> alu_irq) 
        else $error("Assertion ASSERT_MODE_A_OP_01 failed!");
    ASSERT_MODE_A_OP_10: assert property(@(posedge clk) disable iff (!rst_n) seq_alu_op_a_10  |-> alu_irq)
        else $error("Assertion ASSERT_MODE_A_OP_10 failed! property");
    ASSERT_MODE_A_OP_11: assert property (@(posedge clk) disable iff (!rst_n) seq_alu_op_a_11 |-> alu_irq)
        else $error("Assertion ASSERT_MODE_A_OP_11 failed!");
    
    property interrupt_releasing;
        @(posedge clk) disable iff(!rst_n)
        alu_irq_clr ##1 !alu_irq;
    endproperty

    ASSERT_INTERRUPT_RELEASING: assert property (interrupt_releasing)
        else $error("Assertion INTERRUPT_RELEASING failed!");

    sequence seq_alu_op_b_00;
        (alu_enable && alu_enable_b && (alu_op_b == 2'b00) ##1 alu_out ==(8'hF1));
    endsequence :seq_alu_op_b_00

    sequence seq_alu_op_b_01;
        (alu_enable && alu_enable_b && (alu_op_b == 2'b01) ##1 alu_out ==(8'hF4));
    endsequence :seq_alu_op_b_01

    sequence seq_alu_op_b_10;
        (alu_enable && alu_enable_b && (alu_op_b == 2'b10) ##1 alu_out ==(8'hF5));
    endsequence :seq_alu_op_b_10

    sequence seq_alu_op_b_11;
        (alu_enable && alu_enable_b && (alu_op_b == 2'b11) ##1 alu_out ==(8'hFF));
    endsequence : seq_alu_op_b_11

     ASSERT_MODE_B_OP_00: assert property (@(posedge clk) disable iff (!rst_n) seq_alu_op_b_00 |-> alu_irq)
        else $error("Assertion ASSERT_MODE_B_OP_00 failed!");
    ASSERT_MODE_B_OP_01: assert property (@(posedge clk) disable iff (!rst_n) seq_alu_op_b_01 |-> alu_irq) 
        else $error("Assertion ASSERT_MODE_B_OP_01 failed!");
    ASSERT_MODE_B_OP_10: assert property(@(posedge clk) disable iff (!rst_n) seq_alu_op_b_10  |-> alu_irq)
        else $error("Assertion ASSERT_MODE_B_OP_10 failed! property");
    ASSERT_MODE_B_OP_11: assert property (@(posedge clk) disable iff (!rst_n) seq_alu_op_b_11 |-> alu_irq)
        else $error("Assertion ASSERT_MODE_B_OP_11 failed!");
    

    always @(posedge clk ) begin : release_interrupt
        if(alu_irq & rst_n) begin 
        alu_irq_clr <=1'b0;
        #400 alu_irq_clr <= 1'b1;
        end 
    end:release_interrupt

endinterface