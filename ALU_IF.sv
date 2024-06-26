interface IF(input bit clk );

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
    modport DUT (input rst_n ,alu_enable,alu_enable_a,alu_enable_b,alu_op_a,alu_op_b,alu_in_a,alu_in_b,alu_irq_clr,
                 output alu_irq , alu_out);
    modport tb  (clocking cb ,output rst_n);
    function void reset;    
        alu_out = 'b0; 
        alu_irq = 'b0;
    endfunction

endinterface