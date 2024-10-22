package FIFO_Transaction_pkg;

class FIFO_Transaction;
    
parameter FIFO_WIDTH = 16;
parameter FIFO_DEPTH = 8;

rand bit [FIFO_WIDTH-1:0] data_in;
rand bit rst_n, wr_en, rd_en;

bit [FIFO_WIDTH-1:0] data_out;
bit wr_ack, overflow,underflow; 
bit full, empty, almostfull, almostempty ;

int RD_EN_ON_DIST,WR_EN_ON_DIST;

function new( input int RD_EN_ON_DIST=30,WR_EN_ON_DIST=70 );

   this.RD_EN_ON_DIST=RD_EN_ON_DIST ;
   this.WR_EN_ON_DIST=WR_EN_ON_DIST;

endfunction

constraint RST {
    rst_n dist {0:=2, 1:=98};
}

constraint write_enable_dist {
    wr_en dist {1:=WR_EN_ON_DIST, 0:=(100-WR_EN_ON_DIST)};
}

constraint read_enable_dist {
    rd_en dist {1:=RD_EN_ON_DIST, 0:=(100-RD_EN_ON_DIST)};
}

endclass
endpackage 