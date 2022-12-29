module xnor_gatelevel_gate (a, b, out); 
	
	input a, b;

	output out;

	wire not_a_out, not_b_out;
	wire and_1_out, and_2_out;

	and_gate INST_and_gate_1 (.a(a), .b(b), .out(and_1_out));
	and_gate INST_and_gate_2 (.a(not_a_out), .b(not_b_out), .out(and_2_out));

	not_gate INST_not_gate_1 (.a(a), .out(not_a_out));
	not_gate INST_not_gate_2 (.a(b), .out(not_b_out));
	
	or_gate INST_or_gate (.a(and_1_out), .b(and_2_out), .out(out));


endmodule