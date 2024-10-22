package FIFO_coverage_pkg;
import FIFO_Transaction_pkg::*;

class FIFO_coverage;
    FIFO_Transaction F_cvg_txn;
    
    covergroup covgrp;
        // EXTRA will cover rst also
        RST                     : coverpoint  F_cvg_txn.rst_n;

        wr_en_rd_en_wr_ack      : cross F_cvg_txn.wr_en , F_cvg_txn.rd_en , F_cvg_txn.wr_ack       iff (F_cvg_txn.rst_n) ; // only if rst deasseted
        wr_en_rd_en_overflow    : cross F_cvg_txn.wr_en , F_cvg_txn.rd_en , F_cvg_txn.overflow     iff (F_cvg_txn.rst_n) ; // only if rst deasseted
        wr_en_rd_en_underflow   : cross F_cvg_txn.wr_en , F_cvg_txn.rd_en , F_cvg_txn.underflow    iff (F_cvg_txn.rst_n) ; // only if rst deasseted
        wr_en_rd_en_full        : cross F_cvg_txn.wr_en , F_cvg_txn.rd_en , F_cvg_txn.full         iff (F_cvg_txn.rst_n) ; // only if rst deasseted
        wr_en_rd_en_empty       : cross F_cvg_txn.wr_en , F_cvg_txn.rd_en , F_cvg_txn.empty        iff (F_cvg_txn.rst_n) ; // only if rst deasseted
        wr_en_rd_en_almostfull  : cross F_cvg_txn.wr_en , F_cvg_txn.rd_en , F_cvg_txn.almostfull   iff (F_cvg_txn.rst_n) ; // only if rst deasseted
        wr_en_rd_en_almostempty : cross F_cvg_txn.wr_en , F_cvg_txn.rd_en , F_cvg_txn.almostempty  iff (F_cvg_txn.rst_n) ; // only if rst deasseted
    
    endgroup

    function void sample_data(input FIFO_Transaction F_txn);
        F_cvg_txn=F_txn;
        covgrp.start();
        covgrp.sample();
        covgrp.stop();
    endfunction

    function new(); 
    covgrp=new();
    endfunction
endclass
    
endpackage