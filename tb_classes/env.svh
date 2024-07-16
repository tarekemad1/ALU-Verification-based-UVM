class env extends uvm_env;
    `uvm_component_utils(env);
    
    agent agent_h ; 
    config_agent config_agent_h; 
    virtual  IF vif ;
    scoreboard scoreboard_h;
    coverage coverage_h ; 
    function new(string name , uvm_component parent);
        super.new(name , parent);
    endfunction

    function void build_phase(uvm_phase phase);
        config_agent_h = new(.vif(vif),.is_active(UVM_ACTIVE));
        scoreboard_h= scoreboard::type_id::create("scoreboard_h",this );
        coverage_h =coverage::type_id::create("coverage_h",this);
        uvm_config_db #(config_agent )::set(this,"agent*","config_agent",config_agent_h);

        agent_h =agent::type_id::create("agent_h",this);
    endfunction
    
    function void connect_phase(uvm_phase phase);
        agent_h.command_monitor_h.ap.connect(coverage_h.analysis_export);
        agent_h.result_monitor_h.ap.connect(scoreboard_h.analysis_export);
        agent_h.command_monitor_h.ap.connect(scoreboard_h.cmd_fifo.analysis_export);
        
    endfunction

endclass