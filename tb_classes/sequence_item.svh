      class sequence_item extends uvm_sequence_item;

        `uvm_object_utils(sequence_item);

        function new(string name ="");
            super.new(name);
        endfunction

        rand bit[7:0] in_a;
        rand bit[7:0] in_b;
        bit     [7:0] out_alu;
        rand operation_a op_a;
        rand operation_b op_b;
        rand bit mode_a; 
        rand bit mode_b;
        constraint OP_A{
            op_a==AND  -> in_b!='b0;
            op_a==NAND -> (in_a!='hFF && in_b!='h03);
        }
        constraint OP_B{
            op_b==AND_OP_B   -> in_b!='h03;
            op_b==NOR        -> in_a!='hF5;
        }
        function void do_copy(uvm_object rhs);
            sequence_item RHS; 
            NULL: assert (rhs!=null)
                else $fatal("NULL Transaction is trying copied");
            super.do_copy(rhs);
            CASTING: assert ($cast(RHS,rhs))
                else $fatal("Assertion CASTING failed!");
            in_a = RHS.in_a;
            in_b = RHS.in_b;
            op_a = RHS.op_a;
            op_b = RHS.op_b;
            out_alu =RHS.out_alu;
            mode_a =RHS.mode_a;
            mode_b =RHS.mode_b;
            
        endfunction :do_copy
        function bit do_compare(uvm_object rhs, uvm_comparer comparer);
            sequence_item tested ;
            bit same ; 
            if (rhs==null) begin
                `uvm_fatal(get_type_name(),"trying to do comparison with null pointer");
            end
            if(!$cast(tested,rhs)) begin 
                same = 0 ; 
                return same ; 
            end 
            same = super.do_compare(rhs,comparer)
                    && (tested.in_a    == in_a) 
                    && (tested.in_b    == in_b)
                    && (tested.mode_a  == mode_a)
                    && (tested.mode_b  == mode_b)
                    && (tested.out_alu == out_alu)
                    && (tested.op_a    == op_a)
                    && (tested.op_b    == op_b);
            return same ;
        endfunction :do_compare
            function string convert2string();
                string s ; 
                s= {super.convert2string(),$sformatf("Mode(A)=%0d   Mode(B)=%0d     A=%0h   B=%0h   ALU_OUT=%0h
                                                    OP_A=%s    OP_B=%s",mode_a,mode_b,in_a,in_b,out_alu,op_a.name()
                                                    ,op_b.name())};
            endfunction:convert2string
            
        
    endclass
    
