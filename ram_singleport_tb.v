`timescale 1ns / 1ps
module ram_singleport_tb;
	reg clk;
	reg read_en;
	reg write_en;
	reg [7:0] addr;
	wire [7:0] data;
	reg [7:0]tmp_data;
	integer i;
	ram_singleport uut (.clk(clk),.read_en(read_en),.write_en(write_en),.addr(addr),.data(data));

	initial
	begin
		clk = 0;
		forever #10 clk=(~clk);		
	end
        task initialize();
		begin
			@(negedge clk)
			begin
			read_en<=0;
			write_en<=0;
			addr<=8'b0;
			end
		end
	endtask
	//Read enable task
	task read_enable();
		@(negedge clk) 
		 begin
			read_en<=1;
			write_en<=0;
		end
	endtask
	//write enable task
	task write_enable();
		@(negedge clk) 
		 begin
			read_en<=0;
			write_en<=1;
		end
	endtask
        initial
		begin
		   initialize();//initialise the values
		   #20;
			write_enable();//enable the write mode
			for(i=0;i<16;i=i+1)
				begin 
				   @(negedge clk)
					begin
				   addr<=i;
					tmp_data<=i;
					end
				end
			#20;
			read_enable();//Enable the read mode		
			for(i=0;i<16;i=i+1)
			  begin
			    @(negedge clk)
			    addr<=i;
				end
			#40;
			$finish;
		end	  
	//drive the values to data during write stage.
	assign data=(write_en && (!read_en))?tmp_data:8'bz;
endmodule

