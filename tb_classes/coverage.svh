class coverage extends uvm_subscriber #(sequence_item);
    `uvm_component_utils(coverage); 
    virtual IF vif;
    bit[7:0] a;
    bit[7:0] b;
    bit rst_n;
    bit alu_en;
    operation_a op_a;
    operation_b op_b;
    bit mode_a;
    bit mode_b;

    covergroup Cov_grp @(vif.cb);
        IN_A: coverpoint a {
            bins zeros = {'h00};
            bins low[4] = {['h01:'h02], ['h04:'h0F]};
            bins mid[4] = {['h10:'hF0]};
            bins high[4] = {['hF1:'hF4], ['hF6:'hFE]};
            bins Not_allowed_in_MODE_B = {'hF5};
            bins ones = {'hFF};
        }
        IN_B: coverpoint b {
            bins zeros = {'h00};
            bins low[4] = {['h01:'h02], ['h03:'h0F]};
            bins Not_allowed_in_MODE_B = {'h03};
            bins mid[4] = {['h10:'hF0]};
            bins high[4] = {['hF1:'hFE]};
            bins ones = {'hFF};
        }
        RESET: coverpoint rst_n {
            bins rst_ON = {0};
            bins rst_OFF = {1};
        }
        ENABLE: coverpoint alu_en {
            bins EN = {1};
            bins NOT_EN = {0};
        }
        OPERATION_A: coverpoint op_a {
            bins AND = {2'b00};
            bins NAND = {2'b01};
            bins OR = {2'b10};
            bins XOR = {2'b11};
        }
        OPERATION_B: coverpoint op_b {
            bins XNOR = {2'b00};
            bins AND = {2'b01};
            bins NOR = {2'b10};
            bins OR = {2'b11};
        }
        MODE_A: coverpoint mode_a {
            bins MODE_A_ON = {1'b1};
            bins MODE_B_ON = default;
        }
        MODE_B: coverpoint mode_b {
            bins MODE_B_ON = {1'b1};
            bins MODE_B_OFF = default;
        }
        cross OPERATION_A, IN_A, IN_B {
            illegal_bins alu_in_a = binsof(OPERATION_A) intersect {NAND} &&
                                    binsof(IN_A.ones);
            illegal_bins alu_in_b = binsof(OPERATION_A) intersect {AND} &&
                                    binsof(IN_B.zeros);
            illegal_bins alu_IN_B = binsof(OPERATION_A) intersect {NAND} &&
                                    binsof(IN_B.Not_allowed_in_MODE_B);
        }
        cross OPERATION_B, IN_A, IN_B {
            illegal_bins alu_in_a = binsof(OPERATION_B) intersect {NOR} &&
                                    binsof(IN_A.Not_allowed_in_MODE_B);
            illegal_bins alu_in_b = binsof(OPERATION_B) intersect {AND} &&
                                    binsof(IN_B.Not_allowed_in_MODE_B);
        }
    endgroup

    function new(string name, uvm_component parent);
        super.new(name, parent);
        Cov_grp = new();
    endfunction

    function void write(sequence_item t);
        a = t.in_a;
        b = t.in_b;
        rst_n = t.rst_n;
        alu_en = t.alu_enable;
        op_a = t.op_a;
        op_b = t.op_b;
        mode_a = t.mode_a;
        mode_b = t.mode_b;
       
    endfunction

endclass
