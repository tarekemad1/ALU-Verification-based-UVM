class result_transaction extends uvm_transaction;

    `uvm_object_utils(result_transaction);
    bit[7:0] result ;
    function new(string name ="");
        super.new(name);
    endfunction
    function void do_copy(uvm_object rhs );

        result_transaction result_h ;

        assert(rhs != null)
            `uvm_fatal(get_type_name(),"Trial for copying null object");

        super.do_copy(rhs);

        if (!$cast(result_h,rhs)) begin
            `uvm_fatal(get_type_name(),"Casting Failed");
        end

       result = result_h.result ; 
        
    endfunction
    function bit do_compare(uvm_object rhs , uvm_comparer comparer);

        bit equal ;
        result_transaction result_h ; 

        Compare : assert (result_h != null)
            else `uvm_fatal(get_type_name(),"Assertion Compare  failed!");
        casting: assert ($cast(result_h,rhs))
            else `uvm_fatal(get_type_name(),"Assertion casting failed!");

        equal =super.do_compare(rhs,comparer) &&  (result_h.result == result);

        return equal ; 
    endfunction

    function string convert2string();
        string s ;
        s= $sformatf("alu_out = %0h",result);
        return s ;
    endfunction
endclass