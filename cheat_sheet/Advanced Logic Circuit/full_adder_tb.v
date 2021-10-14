module full_adder_test_bench;
    logic carry_in, x, y;
    logic carry_out, z;

    // "dut" stands for "device under test"
    // below, we're basically instantiating a full adder (defined in the code above) that's connected to our logics, for testing purposes
    // the `.name(other_name)` syntax is a "named port map", which lets us connect logics to devices by signal name
    // alternatively, we can just map the signals in order, like `full_adder dut(x, y, carry_in, carry_out, z)`, but this can cause issues if we change the inputs/outputs of the full adder
    full_adder dut(.c_out(carry_out), .sum(z), .c_in(carry_in), .a(x), .b(y));

    // this is a procedural block - inside, the statements are evaluated sequentially from top to bottom
    initial begin // run once at time 0
        carry_in = 0; x = 0; y = 0;
        // delays must be used to ensure statements actually run sequentially - statements in between delays all execute in parallel
        #10 x = 1; // delay 10 time units, then continue and set x to 1
        #10 y = 1; // delay 10 time units, then continue and set y to 1
        #10 carry_in = 1; // delay 10 time units, then continue and set carry_in to 1
        #10 $stop; // delay 10 time units, then stop the simulation (this will not compile if trying to generate hardware from this)
    end

    // now we want to dump the signals out into waveforms so we can see them
    initial $dumpvars(0, full_adder_test_bench); // the first parameter is the dump level (`0` means "dump all variables in the module and in the modules that instantiate it"), and the rest of the parameters are the module or variables to dump
endmodule