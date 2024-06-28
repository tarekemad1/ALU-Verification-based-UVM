
class env extends uvm_env;
    `uvm_component_utils(env);
    sequencer sequencer_h; 

    function new(string name , uvm_component parent);
        super.new(name , parent);
    endfunction

    function void build_phase(uvm_phase phase);
        sequencer_h = new("sequencer_h",this);
    endfunction

endclass