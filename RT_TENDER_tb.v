`timescale 1ns / 1ps

module RT_TENDER_tb;

    // Inputs
    reg clk;
    reg rstn;

    // Instantiate the Unit Under Test (UUT)
    RT_TENDER RT_TENDER(
        .clk(clk), 
        .rstn(rstn)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $monitor("RT_TENDER %d %d %b %b",RT_TENDER.max_val,RT_TENDER.grp_idx,RT_TENDER.Tensors,RT_TENDER.VPU_memory.vpu_memory[2]);
        // Initialize Inputs
        clk = 0;
        rstn = 0;
        
        // Reset the module
        #10;
        rstn = 1;


        #200;
        $finish; // Stop the simulation
    end

initial begin
  $dumpfile("RT_TENDER.vcd");
  $dumpvars(0, RT_TENDER_tb);
end
endmodule