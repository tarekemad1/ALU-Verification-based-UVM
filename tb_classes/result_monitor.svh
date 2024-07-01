class result_monitor extends uvm_component;

    `uvm_component_utils(result_monitor);
    uvm_analysis_port#(result_transaction) ap ; 
    virtual IF vif ; 
    function new(string name , uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        
        ap  =new("ap",this);
        if (!uvm_config_db#(virtual IF)::get(null,"*","vif",vif)) 
            `uvm_fatal(get_type_name,"Failed to get interface");
        
    endfunction

    function void connect_phase(uvm_phase phase);
        vif.result_monitor_h = this ; 
    endfunction

    function void write_to_monitor(bit[7:0] rslt);

        result_transaction result_transaction_h ;
        result_transaction_h= new("result_transaction_h");
        result_transaction_h.result= rslt;
        ap.write(result_transaction_h);

    endfunction
endclass