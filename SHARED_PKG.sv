package SHARED_PKG;

class SHARED_class;
    static int error_count , correct_count;
    static bit test_finished ;

/* //////////////////           EXTRA             //////////////////////////////////
   Here to control if all outputs will be checked in score_board or no
   because the require is to check data out only in score_board and all other flags by assertions
   so i will make score_bord_check = 0 the score board will check data_out only and other flags will be
   checked by assertions 
   if score_bord_check = 1 all outputs will be checked in score board and all flags will be checked also  
   in assertions 
*/
    static bit score_board_check ;

endclass
    
endpackage