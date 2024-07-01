module top;
    import uvm_pkg::*;
    import alu_pkg::*;
    `include "uvm_macros.svh";
    
    
    bit clk ; 
    initial begin 
        forever #5 clk <= ~clk ; 
    end 

    IF alu_if(clk);
        ALU alu_inst(alu_if);
    initial begin 
        uvm_config_db #(virtual IF)::set(null,"*","alu_if",alu_if);
        run_test();
    end
    
endmodule :top 