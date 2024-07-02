class config_agent;
    virtual IF vif; 
    uvm_active_passive_enum is_active;  // Corrected enum name

    function new(virtual IF vif, uvm_active_passive_enum is_active);
        this.vif = vif;  
        this.is_active = is_active;
    endfunction

    function uvm_active_passive_enum get_is_active();  // Corrected enum name
        return is_active;
    endfunction
    
endclass