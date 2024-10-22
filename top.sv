module top();
    bit clk;

    initial begin
        clk=0;

        forever begin
            #5 clk = ~clk;
        end
    end

    FIFO_Interface FIFO_IF (clk);

    FIFO    DUT (FIFO_IF);
    FIFO_TB TB  (FIFO_IF);
    monitor MON (FIFO_IF);

endmodule