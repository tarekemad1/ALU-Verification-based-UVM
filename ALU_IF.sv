interface IF(input  bit clk );
   // import alu_pkg ::* ;
    logic        rst_n;
    logic        alu_enable;
    logic        alu_enable_a;
    logic        alu_enable_b;
    logic    [1:0]alu_op_a;
    logic     [1:0]alu_op_b;
    logic     [7:0]alu_in_a;
    logic     [7:0]alu_in_b;
    logic        alu_irq_clr;
    logic        alu_irq;
    logic     [7:0] alu_out;
 
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
        // Wait until alu_irq raises
        (alu_irq == 1'b0 && alu_irq_clr == 1'b0) |-> ##1
        (alu_irq == 1'b1) ##[1:$] // Wait until alu_irq is asserted, and allow for 1 or more cycles for alu_irq_clr to be asserted
        (alu_irq_clr == 1'b1) ##1
        (alu_irq == 1'b0); // Expect alu_irq to be deasserted in the next cycle
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