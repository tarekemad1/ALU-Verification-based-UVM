typedef enum bit[1:0] {AND,NAND,OR,XOR} op_a_e;
typedef enum bit[1:0] {XNOR,AND_OP_B,NOR,OR_OP_B} op_b_e;


class sequence_item extends uvm_sequence_item ;

    `uvm_object_utils(sequence_item);

    function new(string name =" ");
        super.new(name);
    endfunction

    rand bit         rst_n;
    rand bit        alu_enable;
    rand bit         alu_enable_a;
    rand bit         alu_enable_b;
    rand op_a_e alu_op_a ;
    rand op_b_e alu_op_b ;
    rand bit   [7:0] alu_in_a;
    rand bit   [7:0] alu_in_b;
    rand bit         alu_irq_clr;
    bit     alu_irq;
    bit [7:0] alu_out;
    constraint RESET_CONSTRAINT {rst_n dist{1:=95 , 0:=5};}
    constraint GENERIC_ENABLE_CONSTRAINT{alu_enable dist{1:=98 , 0:=2};}
    constraint MODE_ENABLE_CONSTRAINT{alu_enable_a != alu_enable_b ;}
    constraint OP_A_CONSTRAINT{
        if (alu_enable && alu_enable_a ) {
            alu_op_a==AND -> alu_in_b!='h0;
            alu_op_a==NAND -> (alu_in_a !='hFF && alu_in_b != 'h03);
        }   
    }
    constraint OP_B_CONSTRAINT{
        if(alu_enable && alu_enable_b){
            alu_op_b ==AND_OP_B -> alu_in_b !='h03;
            alu_op_b ==NOR      -> alu_in_b !='hF5;
        }
    }
    constraint INTR_CLR_CONSTRAINT{alu_irq_clr dist{1:=50,0:=50};}
        function string convert2string();
                string s ; 
                s= {super.convert2string(),$sformatf(" Enable =%0d rst_n = %0d Mode(A)=%0d   Mode(B)=%0d     A=%0h   B=%0h   ALU_OUT=%0h    alu_irq= %0d     OP_A=%s    OP_B=%s",alu_enable,rst_n,alu_enable_a,alu_enable_b,alu_in_a,alu_in_b,alu_out,alu_irq,alu_op_a.name()  ,alu_op_b.name())};
                    return s ;
        endfunction:convert2string
        function void post_randomize();
            if(!rst_n && alu_enable)
            begin
                if(alu_enable_a)
                begin 
                if ( alu_op_a==AND && (alu_in_a ==8'hFF || alu_in_b == 8'h03 )) 
                    `uvm_warning("Inputs Conflic",$sformatf("In Mode(A)   inputs A:%0h or B:%0h Not allowed in case %0s",alu_in_a,alu_in_b,alu_op_a.name())); 
                end 
                else
                begin
                if ((alu_op_b==AND_OP_B && alu_in_b==8'h03  ) ||( alu_op_b == NOR && alu_in_a == 8'hF5)) 
                begin
                    `uvm_warning("Inputs Conflic",$sformatf("In MODE(B)  inputs A:%0h or B:%0h Not allowed in case %0s ",alu_in_a,alu_in_b,alu_op_b.name()));     
                end
                end
            end 
        endfunction
endclass