class sequencer extends uvm_sequencer#(sequence_item);

    `uvm_component_utils(sequencer);

    function new(string name , uvm_component parent );
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase );
        super.build_phase(phase);
        `uvm_info(get_type_name(),"build phase of sequencer class",UVM_LOW);
    endfunction
    
endclass