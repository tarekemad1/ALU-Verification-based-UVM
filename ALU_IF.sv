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

    task send_op(input bit reset_n , input bit alu_enable_t ,input bit mode_a ,input bit mode_b ,
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

endinterface