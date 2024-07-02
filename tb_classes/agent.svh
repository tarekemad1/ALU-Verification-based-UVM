class agent extends uvm_agent;
    `uvm_component_utils(agent);
    driver driver_h ; 
    command_monitor command_monitor_h ; 
    result_monitor result_monitor_h ; 
    scoreboard   scoreboard_h ; 
    sequencer sequencer_h ; 
    config_agent config_agent_h ; 
    uvm_tlm_fifo #(sequence_item)   cmd_fifo ;
    uvm_analysis_port #(sequence_item) ap_mon_com ;
    uvm_analysis_port #(result_transaction) ap_mon_res; 

    function new(string name , uvm_component parent);
        super.new(name , parent);
    endfunction :new

    function void build_phase(uvm_phase phase);
        if(!uvm_config_db#(config_agent)::get(this,"","config",config_agent_h))
            `uvm_fatal(get_type_name(),"Failed to retrieve configuraion object");
        is_active = config_agent_h.get_is_active();
        if(get_is_active()== UVM_ACTIVE)
        begin 
            driver_h  = driver::type_id::create("driver_h",this);
            cmd_fifo = new("cmd_fifo"); 
            sequencer_h =new("sequencer_h",this);
        end 
            command_monitor_h =command_monitor ::type_id::create("command_monitor_h",this);
            result_monitor_h = result_monitor ::type_id::create("result_monitor_h",this);
            scoreboard_h     = scoreboard ::type_id::create("scoreboard_h",this);
            ap_mon_com    = new("ap_mon_com",this);
            ap_mon_res    = new("ap_mon_res",this);
    endfunction : build_phase 
endclass