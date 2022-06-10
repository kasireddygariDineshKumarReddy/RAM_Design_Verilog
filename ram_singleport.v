//Ram design using single inout data port.Data port used for reading the data and writing the data.
module ram_singleport(
    input clk,
    input read_en,
    input write_en,
    input [3:0]addr,
    inout [7:0]data
    );
  reg [7:0] memory[15:0];
  //design a memory for storing the data
  reg [7:0]temp_data;
  always@(posedge clk)
		begin
		if(write_en && !(read_en))
			memory[addr]<=data;
		else if(!(write_en) && read_en)
			temp_data<=memory[addr];
		end
	assign data=(read_en && (!write_en))?temp_data:8'bz;
endmodule
