//General_station
//All global constants are declared here

`ifndef CONSTANTS
    `define CONSTANTS
    
    `define MASTER
    
    `ifndef MASTER
        `define SLAVE
    `endif
    
    `define TXF 20                          //Transmiter Freq
    `define RXF 100                         //Receiver Freq
    
    `define DATAWIDTH 8                    //Width of the data bits
    
//    `define PREAMBLE 8'b1100_1100           //The first data that is transferred
    `define PREAMBLE {(4){2'b10}}           //The first data that is transferred 
    
//    `define RAM_DEPTH 4                    //Memory size, 8 bits per location
//    `define RAM_ADDRSWIDTH_M 2
//    `define RAM_INITFILE "data.mem"         //The initialization file for the memory
    
    //Uart defines begins
    `define BITCOUNTMAX 8                   
    `define SAMPLECOUNTMAX 10427            //Number of samples that UART sends for each bit (freq/baudrate)
    //Uart defines ends
    
    `define RAM_DEPTH_DATA_BUFF 16
    `define RAM_ADDRSWIDTH_DB 4
//    `define INIT_FILE_DB "uart_test_mem.mem"
    `define INIT_FILE_DB ""
    
    `define VERIF
    
`endif