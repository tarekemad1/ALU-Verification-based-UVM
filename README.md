ALU Verification Project

Overview


This project focuses on the verification of an 8-bit Arithmetic Logic Unit (ALU) as shown in the provided design schematic. 
The ALU is responsible for performing a variety of logical and arithmetic operations based on the input control signals. 
The operations are selected using two 2-bit operation select lines (alu_op_a and alu_op_b) for two distinct operations, and the results are generated based on the enabled inputs (alu_enable_a and alu_enable_b).

ALU Design Description

Inputs:


alu_in_a [7:0]: 8-bit input operand A


alu_in_b [7:0]: 8-bit input operand B


alu_op_a [1:0]: 2-bit control signal for operation set A

alu_op_b [1:0]: 2-bit control signal for operation set B

alu_enable_a: Enable signal for operation A

alu_enable_b: Enable signal for operation B

alu_enable: Global enable signal

alu_irq_clr: Interrupt clear signal

alu_clk: Clock signal

rst_n: Active low reset signal


Outputs:


alu_out [7:0]: 8-bit output result from the ALU

alu_irq: Interrupt signal, asserted when a specific condition is met

Operation Modes:

Operation A (alu_enable_a && alu_enable):

00: AND operation

01: NAND operation

10: OR operation

11: XOR operation

Operation B (alu_enable_b && alu_enable):


00: XNOR operation

01: AND operation

10: NOR operation

11: OR operation

Verification Plan


The verification plan for the ALU includes the following key steps:

Test Planning: 

Develop a verification strategy based on the functional specifications of the ALU.

Environment Setup: 

Implement a UVM (Universal Verification Methodology) based testbench, including:

    Drivers: To stimulate the ALU inputs.

    Monitors: To observe and capture the ALU output responses.

    Scoreboards: To compare the expected results with the actual output.

    Assertions: To check for design rule compliance during simulation.

    Test Development: Write directed and random test cases to cover all possible operations and input combinations.

    Coverage Analysis: Collect coverage metrics (code coverage, functional coverage) to ensure that all scenarios have been thoroughly tested.

    Debugging: Analyze any mismatches or failures in the simulation and refine the design or test cases as necessary.

    Reporting: Generate and document the coverage report, highlighting the achieved coverage and identifying any untested scenarios.


Tools & Technologies

    SystemVerilog

    UVM (Universal Verification Methodology)

    QuestaSim: For simulation and debugging

    Coverage tools: To measure and report coverage metrics


Results

    Functional Coverage: Ensure all operations and edge cases are verified.

    Code Coverage: Aim for 100% code coverage to ensure all design code paths are exercised.

    Assertions: Validate key conditions and invariants in the ALU design.



Conclusion


This project ensures the ALU design is robust and meets the specified functional requirements through a comprehensive verification process. 

The UVM-based testbench is modular and reusable, providing a solid foundation for verifying similar designs in the future.






