package alu_pkg;
    import uvm_pkg ::*;
    `include "uvm_macros.svh"
    typedef enum bit[1:0] {AND,NAND,OR,XOR} operation_a;
    typedef enum bit[1:0] {XNOR,AND_OP_B,NOR,OR_OP_B} operation_b;

    typedef uvm_sequencer#(sequence_item) sequencer;
endpackage 