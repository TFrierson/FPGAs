module blinky2_top(
	input clk,
	output LED1,
	output LED2,
	output LED3,
	output LED4,
	output LED5);

	integer counter0;
	integer counter1;

	always@(posedge clk)
	begin
		counter0 <= counter0 + 1;
		if(counter0 >= 12000000)
		begin
			counter0 <= 0;
			counter1 <= counter1 + 1;

			if(counter1 >= 3)
			begin
				counter1 <= 0;
			end

		end
	end

	assign LED1 = (counter1 == 0);
	assign LED2 = (counter1 == 1);
	assign LED3 = (counter1 == 2);
	assign LED4 = (counter1 == 3);
	assign LED5 = 1'b0;

	endmodule
