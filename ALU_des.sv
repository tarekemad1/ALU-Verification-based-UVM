//port declaration
module ALU (
IF.DUT if_dut
);


always @ (posedge if_dut.clk or negedge if_dut.rst_n) begin

  if (!if_dut.rst_n) begin
    if_dut.alu_irq = 1'b0;
    if_dut.alu_out = 8'b0; 
  end
  else begin
    if (if_dut.alu_enable) begin
      if (if_dut.alu_enable_a & (!if_dut.alu_enable_b)) begin 
        case (if_dut.alu_op_a)
          2'b00 : begin
            if (if_dut.alu_in_b != 8'h0) begin
              if_dut.alu_out = if_dut.alu_in_a & if_dut.alu_in_b;
            
                if (if_dut.alu_out == 8'hFF)
			             if_dut.alu_irq = 1'b1;
		            else 	
			             if_dut.alu_irq = 1'b0;
			      end
            else begin
              if_dut.alu_out = if_dut.alu_out;
            end
          end 
          2'b01 : begin
            if ( if_dut.alu_in_a != 8'hFF & if_dut.alu_in_b != 8'h03) begin
              if_dut.alu_out = ~(if_dut.alu_in_a & if_dut.alu_in_b);
              if (if_dut.alu_out == 8'h00)
			             if_dut.alu_irq = 1'b1;
		            else 	
			             if_dut.alu_irq = 1'b0;
			      end
            else begin
              if_dut.alu_out = if_dut.alu_out;
            end
          end
          2'b10 : begin
            if_dut.alu_out = (if_dut.alu_in_a | if_dut.alu_in_b);
                if (if_dut.alu_out == 8'hF8)
			             if_dut.alu_irq = 1'b1;
		            else 	
			             if_dut.alu_irq = 1'b0;
			    end
          2'b11 : begin
            if_dut.alu_out = (if_dut.alu_in_a ^ if_dut.alu_in_b);
                if (if_dut.alu_out == 8'h83)
			             if_dut.alu_irq = 1'b1;
		            else 	
			             if_dut.alu_irq = 1'b0;
			    end
        endcase
      end //if_dut.alu_enable_a
      
      else if ((!if_dut.alu_enable_a) & if_dut.alu_enable_b) begin 
        case (if_dut.alu_op_b)
          2'b00 : begin
            if_dut.alu_out = ~(if_dut.alu_in_a ^ if_dut.alu_in_b);
                if (if_dut.alu_out == 8'hF1)
			             if_dut.alu_irq = 1'b1;
		            else 	
			             if_dut.alu_irq = 1'b0;
			    end
          2'b01 : begin
            if (if_dut.alu_in_b != 8'h03) begin
              if_dut.alu_out = (if_dut.alu_in_a & if_dut.alu_in_b);
                if (if_dut.alu_out == 8'hF4)
			             if_dut.alu_irq = 1'b1;
		            else 	
			             if_dut.alu_irq = 1'b0;
			      end
            else begin
              if_dut.alu_out = if_dut.alu_out;
            end 
          end 
          2'b10 :  begin
            if (if_dut.alu_in_b != 8'h03) begin
              if_dut.alu_out = ~(if_dut.alu_in_a | if_dut.alu_in_b);
                if (if_dut.alu_out == 8'hF5)
			             if_dut.alu_irq = 1'b1;
		            else 	
			             if_dut.alu_irq = 1'b0;
			      end
            else begin
              if_dut.alu_out = if_dut.alu_out;
            end
         end 
          2'b11 : begin
            if_dut.alu_out = if_dut.alu_in_a | if_dut.alu_in_b;
                if (if_dut.alu_out == 8'hFF)
			             if_dut.alu_irq = 1'b1;
		            else 	
			             if_dut.alu_irq = 1'b0;
			    end
        endcase
      end //if_dut.alu_enable_b
      else begin
        //if_dut.alu_enable_a & if_dut.alu_enable_b are 0 or 1  ..............
        if_dut.alu_out = if_dut.alu_out;
        
      end   
    end //if_dut.alu_enable = 1
    
    else begin
      //if if_dut.alu_enable = 0 --> output no change ...............
      if_dut.alu_out = if_dut.alu_out;
    end 
  end //else
end


always @ (posedge if_dut.clk or negedge if_dut.rst_n) begin
  if (!if_dut.rst_n) begin
    if_dut.alu_irq = 1'b0;
    if_dut.alu_out = 8'b0; 
  end
  
  else begin
    if (if_dut.alu_irq_clr)
      if_dut.alu_irq = 1'b0; 
    else
      if_dut.alu_irq = 1'b1; 
  end
end  
endmodule
