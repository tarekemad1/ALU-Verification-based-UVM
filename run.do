# Compile the design and testbench files
vlog -f tb.f

# Optimize the design with coverage options
vopt top -o top_optimized +acc=npr -coverage

# Simulate with coverage enabled and specify the UVM test name for mode_a_test
vsim -c top_optimized +UVM_TESTNAME=mode_a_test -coverage

# Prevent the simulator from quitting automatically after the run
set NoQuitOnFinish 1

# Run the simulation for mode_a_test
run -all

# Generate a detailed coverage report for mode_a_test
coverage report -details

# Set a custom attribute 'TESTNAME' for mode_a_test in the coverage database
coverage attribute -name TESTNAME -value mode_a_test

# Save the coverage data to a UCDB file named mode_a_test.ucdb
coverage save mode_a_test.ucdb

# Repeat the simulation setup, run, report, attribute setting, and save for mode_b_test

# Simulate with coverage enabled and specify the UVM test name for mode_b_test
vsim -c top_optimized +UVM_TESTNAME=mode_b_test -coverage

# Prevent the simulator from quitting automatically after the run
set NoQuitOnFinish 1

# Run the simulation for mode_b_test
run -all

# Generate a detailed coverage report for mode_b_test
coverage report -details

# Set a custom attribute 'TESTNAME' for mode_b_test in the coverage database
coverage attribute -name TESTNAME -value mode_b_test

# Save the coverage data to a UCDB file named mode_b_test.ucdb
coverage save mode_b_test.ucdb

# Repeat the simulation setup, run, report, attribute setting, and save for random_test

# Simulate with coverage enabled and specify the UVM test name for random_test
vsim -c top_optimized +UVM_TESTNAME=random_test -coverage

# Prevent the simulator from quitting automatically after the run
set NoQuitOnFinish 1

# Run the simulation for random_test
run -all

# Generate a detailed coverage report for random_test
coverage report -details

# Set a custom attribute 'TESTNAME' for random_test in the coverage database
coverage attribute -name TESTNAME -value random_test

# Save the coverage data to a UCDB file named random_test.ucdb
coverage save random_test.ucdb

# Merge all individual UCDB files into a single merged_coverage.ucdb file
vcover merge -o merged_coverage.ucdb random_test.ucdb mode_a_test.ucdb mode_b_test.ucdb

# Generate a comprehensive coverage report from the merged UCDB file
vcover report merged_coverage.ucdb -cvg -details
