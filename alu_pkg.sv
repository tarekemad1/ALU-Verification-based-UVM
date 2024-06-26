package alu_pkg;
    import uvm_pkg ::*;
    `include "uvm_macros.svh"
    typedef enum bit[1:0] {AND,NAND,OR,XOR} operation_a;
    typedef enum bit[1:0] {XNOR,AND,NOR,OR} operation_b;
    
    typedef uvm_sequencer sequencer;
endpackage 