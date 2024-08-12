module top;
    import uvm_pkg::*;
    import alu_pkg::*;
    `include "uvm_macros.svh";
    
    
    bit clk = 1 ; 
    initial begin 
        forever #5 clk <= ~clk ; 
    end 
    IF vif(clk);
        ALU alu_inst(clk,vif.rst_n,vif.alu_enable,vif.alu_enable_a,vif.alu_enable_b,vif.alu_op_a,
        vif.alu_op_b,vif.alu_in_a,vif.alu_in_b,vif.alu_irq_clr,vif.alu_irq,vif.alu_out);
    initial begin 
        uvm_config_db #(virtual IF)::set(null,"*","vif",vif);
        run_test();
    end
    
endmodule :top 