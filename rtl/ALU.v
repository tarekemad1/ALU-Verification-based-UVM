//port declaration
module ALU (
input        alu_clk,
input        rst_n,
input        alu_enable,
input        alu_enable_a,
input        alu_enable_b,
input  [1:0] alu_op_a,
input  [1:0] alu_op_b,
input  [7:0] alu_in_a,
input  [7:0] alu_in_b,
input        alu_irq_clr,
output reg    alu_irq,
output reg [7:0] alu_out
);


always @ (posedge alu_clk or negedge rst_n) begin

  if (!rst_n) begin
    alu_irq = 1'b0;
    alu_out = 8'b0; 
  end
  else begin
    if (alu_enable) begin
      if (alu_enable_a & (!alu_enable_b)) begin 
        case (alu_op_a)
          2'b00 : begin
            if (alu_in_b != 8'h0) begin
              alu_out = alu_in_a & alu_in_b;
            
                if (alu_out == 8'hFF)
			             alu_irq = 1'b1;
		            else 	
			             alu_irq = 1'b0;
			      end
            else begin
              alu_out = alu_out;
            end
          end 
          2'b01 : begin
            if ( alu_in_a != 8'hFF & alu_in_b != 8'h03) begin
              alu_out = ~(alu_in_a & alu_in_b);
              if (alu_out == 8'h00)
			             alu_irq = 1'b1;
		            else 	
			             alu_irq = 1'b0;
			      end
            else begin
              alu_out = alu_out;
            end
          end
          2'b10 : begin
            alu_out = (alu_in_a | alu_in_b);
                if (alu_out == 8'hF8)
			             alu_irq = 1'b1;
		            else 	
			             alu_irq = 1'b0;
			    end
          2'b11 : begin
            alu_out = (alu_in_a ^ alu_in_b);
                if (alu_out == 8'h83)
			             alu_irq = 1'b1;
		            else 	
			             alu_irq = 1'b0;
			    end
        endcase
      end //alu_enable_a
      
      else if ((!alu_enable_a) & alu_enable_b) begin 
        case (alu_op_b)
          2'b00 : begin
            alu_out = ~(alu_in_a ^ alu_in_b);
                if (alu_out == 8'hF1)
			             alu_irq = 1'b1;
		            else 	
			             alu_irq = 1'b0;
			    end
          2'b01 : begin
            if (alu_in_b != 8'h03) begin
              alu_out = (alu_in_a & alu_in_b);
                if (alu_out == 8'hF4)
			             alu_irq = 1'b1;
		            else 	
			             alu_irq = 1'b0;
			      end
            else begin
              alu_out = alu_out;
            end 
          end 
          2'b10 :  begin
            if (alu_in_b != 8'h03) begin
              alu_out = ~(alu_in_a | alu_in_b);
                if (alu_out == 8'hF5)
			             alu_irq = 1'b1;
		            else 	
			             alu_irq = 1'b0;
			      end
            else begin
              alu_out = alu_out;
            end
         end 
          2'b11 : begin
            alu_out = alu_in_a | alu_in_b;
                if (alu_out == 8'hFF)
			             alu_irq = 1'b1;
		            else 	
			             alu_irq = 1'b0;
			    end
        endcase
      end //alu_enable_b
      else begin
        //alu_enable_a & alu_enable_b are 0 or 1  ..............
        alu_out = alu_out;
        
      end   
    end //alu_enable = 1
    
    else begin
      //if alu_enable = 0 --> output no change ...............
      alu_out = alu_out;
    end 
  end //else
end


always @ (posedge alu_clk or negedge rst_n) begin
  if (!rst_n) begin
    alu_irq = 1'b0;
    alu_out = 8'b0; 
  end
  
  else begin
    if (alu_irq_clr)
      alu_irq = 1'b0; 
    else
      alu_irq = 1'b1; 
  end
end  
endmodule
