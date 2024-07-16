class agent extends uvm_agent;
    `uvm_component_utils(agent);
    driver driver_h ; 
    command_monitor command_monitor_h ; 
    result_monitor result_monitor_h ; 
    sequencer sequencer_h ; 
    config_agent config_agent_h ; 
    
    function new(string name , uvm_component parent);
        super.new(name , parent);
    endfunction :new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(config_agent)::get(this,"","config_agent",config_agent_h))
            `uvm_fatal(get_type_name(),"Failed to retrieve configuraion object");

        is_active = config_agent_h.get_is_active();
        if(get_is_active()== UVM_ACTIVE)
        begin 
            driver_h  = driver::type_id::create("driver_h",this); 
            sequencer_h =new("sequencer_h",this);
        end 
            
            command_monitor_h =command_monitor ::type_id::create("command_monitor_h",this);
            result_monitor_h  = result_monitor ::type_id::create("result_monitor_h",this);
   
    endfunction : build_phase 
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if (get_is_active()==UVM_ACTIVE) begin
            driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
        end

    endfunction
endclass