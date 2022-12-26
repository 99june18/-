

module eight_bit_full_adder_module (a, b, cin, sum, cout);
	input [7:0] a, b;
	input cin;
	output [7:0] sum;
	output cout;

	wire cout_1, cout_2, cout_3, cout_4, cout_5, cout_6, cout_7;

	full_adder_gatelevel_module INST_full_adder_gatelevel_module_1(.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(cout_1));
	full_adder_gatelevel_module INST_full_adder_gatelevel_module_2(.a(a[1]), .b(b[1]), .cin(cout_1), .sum(sum[1]), .cout(cout_2));
	full_adder_gatelevel_module INST_full_adder_gatelevel_module_3(.a(a[2]), .b(b[2]), .cin(cout_2), .sum(sum[2]), .cout(cout_3));
	full_adder_gatelevel_module INST_full_adder_gatelevel_module_4(.a(a[3]), .b(b[3]), .cin(cout_3), .sum(sum[3]), .cout(cout_4));
    full_adder_gatelevel_module INST_full_adder_gatelevel_module_5(.a(a[4]), .b(b[4]), .cin(cout_4), .sum(sum[4]), .cout(cout_5));
    full_adder_gatelevel_module INST_full_adder_gatelevel_module_6(.a(a[5]), .b(b[5]), .cin(cout_5), .sum(sum[5]), .cout(cout_6));
    full_adder_gatelevel_module INST_full_adder_gatelevel_module_7(.a(a[6]), .b(b[6]), .cin(cout_6), .sum(sum[6]), .cout(cout_7));
    full_adder_gatelevel_module INST_full_adder_gatelevel_module_8(.a(a[7]), .b(b[7]), .cin(cout_7), .sum(sum[7]), .cout(cout));

endmodule