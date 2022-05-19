-------------------------------------------------------------------------------
-- Title      : Testbench for design "axi_iic"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi_iic_tb.vhd
-- Author     : Praveen Venugopal
-- Company    : 
-- Created    : 2017-10-07
-- Last update: 2017-10-10
-- Platform   : 
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c)  2017
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2017-10-07  1.0      pvenugo  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library axi_iic_v2_0_11;
library unisim;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

entity axi_iic_tb is
    port(
        interrupt : out std_logic_vector(7 downto 0);
        sr        : out std_logic_vector(7 downto 0)
        );
end axi_iic_tb;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

architecture tb of axi_iic_tb is

    component axi_iic_0

        port (
            s_axi_aclk    : in  std_logic;
            s_axi_aresetn : in  std_logic := '1';
            iic2intc_irpt : out std_logic;
            s_axi_awaddr  : in  std_logic_vector (8 downto 0);
            s_axi_awvalid : in  std_logic;
            s_axi_awready : out std_logic;
            s_axi_wdata   : in  std_logic_vector (31 downto 0);
            s_axi_wstrb   : in  std_logic_vector (3 downto 0);
            s_axi_wvalid  : in  std_logic;
            s_axi_wready  : out std_logic;
            s_axi_bresp   : out std_logic_vector(1 downto 0);
            s_axi_bvalid  : out std_logic;
            s_axi_bready  : in  std_logic;
            s_axi_araddr  : in  std_logic_vector(8 downto 0);
            s_axi_arvalid : in  std_logic;
            s_axi_arready : out std_logic;
            s_axi_rdata   : out std_logic_vector (31 downto 0);
            s_axi_rresp   : out std_logic_vector(1 downto 0);
            s_axi_rvalid  : out std_logic;
            s_axi_rready  : in  std_logic;
            sda_i         : in  std_logic;
            sda_o         : out std_logic;
            sda_t         : out std_logic;
            scl_i         : in  std_logic;
            scl_o         : out std_logic;
            scl_t         : out std_logic;
            gpo           : out std_logic_vector(0 downto 0));
    end component;

    component i2c_slave
        port (
            scl_io : inout std_logic;
            sda_io : inout std_logic);
    end component;

    -- component ports
    signal s_axi_aclk    : std_logic := '0';
    signal s_axi_aresetn : std_logic := '1';
    signal iic2intc_irpt : std_logic;
    signal s_axi_awaddr  : std_logic_vector (8 downto 0);
    signal s_axi_awvalid : std_logic := '0';
    signal s_axi_awready : std_logic;
    signal s_axi_wdata   : std_logic_vector (31 downto 0);
    signal s_axi_wstrb   : std_logic_vector (3 downto 0);
    signal s_axi_wvalid  : std_logic := '0';
    signal s_axi_wready  : std_logic;
    signal s_axi_bresp   : std_logic_vector(1 downto 0);
    signal s_axi_bvalid  : std_logic;
    signal s_axi_bready  : std_logic := '0';
    signal s_axi_araddr  : std_logic_vector(8 downto 0);
    signal s_axi_arvalid : std_logic := '0';
    signal s_axi_arready : std_logic;
    signal s_axi_rdata   : std_logic_vector (31 downto 0);
    signal s_axi_rresp   : std_logic_vector(1 downto 0);
    signal s_axi_rvalid  : std_logic := '0';
    signal s_axi_rready  : std_logic;
    signal sda_o         : std_logic;
    signal sda_t         : std_logic;
    signal sda_io        : std_logic;
    signal scl_o         : std_logic;
    signal scl_t         : std_logic;
    signal scl_io        : std_logic;
    signal gpo           : std_logic_vector(0 downto 0);


begin  -- tb

    -- component instantiation

    DUT :  axi_iic_0
        port map (
            s_axi_aclk    => s_axi_aclk,
            s_axi_aresetn => s_axi_aresetn,
            iic2intc_irpt => iic2intc_irpt,
            s_axi_awaddr  => s_axi_awaddr,
            s_axi_awvalid => s_axi_awvalid,
            s_axi_awready => s_axi_awready,
            s_axi_wdata   => s_axi_wdata,
            s_axi_wstrb   => s_axi_wstrb,
            s_axi_wvalid  => s_axi_wvalid,
            s_axi_wready  => s_axi_wready,
            s_axi_bresp   => s_axi_bresp,
            s_axi_bvalid  => s_axi_bvalid,
            s_axi_bready  => s_axi_bready,
            s_axi_araddr  => s_axi_araddr,
            s_axi_arvalid => s_axi_arvalid,
            s_axi_arready => s_axi_arready,
            s_axi_rdata   => s_axi_rdata,
            s_axi_rresp   => s_axi_rresp,
            s_axi_rvalid  => s_axi_rvalid,
            s_axi_rready  => s_axi_rready,
            sda_i         => sda_io,
            sda_o         => sda_o,
            sda_t         => sda_t,
            scl_i         => scl_io,
            scl_o         => scl_o,
            scl_t         => scl_t,
            gpo           => gpo);

    scl_io <= 'Z' when (scl_t = '1') else scl_o;
    sda_io <= 'Z' when (sda_t = '1') else sda_o;
--    pu_scl : entity unisim.pullup(pullup_v)
--        port map (
--            o => scl_io);
--    pu_sda: entity unisim.pullup(pullup_v)
--        port map (
--            o => sda_io);

    i2c_slave_1: i2c_slave
        port map (
            scl_io => scl_io,
            sda_io => sda_io);
    
    s_axi_aresetn <= '0', '1' after 100 ns;
    s_axi_aclk    <= not s_axi_aclk after 16 ns/2;
    s_axi_wstrb   <= (others => '1');

    -- waveform generation
    WaveGen_Proc : process

        constant ADDR_GIE : std_logic_vector(8 downto 0) := "000011100";  -- 0x01C
        constant ADDR_ISR : std_logic_vector(8 downto 0) := "000100000";  -- 0x020
        constant ADDR_IER : std_logic_vector(8 downto 0) := "000101000";  -- 0x028
        constant ADDR_CR  : std_logic_vector(8 downto 0) := "100000000";  -- 0x100
        constant ADDR_SR  : std_logic_vector(8 downto 0) := "100000100";  -- 0x104
        constant ADDR_TXFIFO  : std_logic_vector(8 downto 0) := "100001000";  -- 0x108

        procedure AXI_WRITE (
            constant ADDR : in std_logic_vector(8 downto 0);
            constant DATA : in std_logic_vector(31 downto 0)
            ) is
        begin  -- AXI_WRITE
            --start of write access
            wait until rising_edge(s_axi_aclk);
            s_axi_awaddr  <= ADDR;
            s_axi_awvalid <= '1';
            s_axi_wvalid  <= '1';
            s_axi_bready  <= '1';
            s_axi_wdata   <= DATA;
            s_axi_arvalid <= '0';
            s_axi_rready  <= '0';
            while (s_axi_awready = '0') or (s_axi_wready = '0')
            loop
                wait until rising_edge(s_axi_aclk);
                s_axi_awvalid <= not s_axi_awready;
                s_axi_wvalid  <= not s_axi_wready;
                s_axi_bready  <= not s_axi_bvalid;
            end loop;
            s_axi_bready <= not s_axi_bvalid;


            --access is finished
            wait until rising_edge(s_axi_aclk);
            s_axi_bready <= not s_axi_bvalid;
  --          s_axi_awaddr <= (others => '0');
  --          s_axi_wdata  <= (others => '0');
            s_axi_awvalid <= '0';
            s_axi_wvalid  <= '0';
           
        end AXI_WRITE;


        procedure AXI_READ (
            constant ADDR : in std_logic_vector(8 downto 0);
            variable DATA : out std_logic_vector(31 downto 0)
            ) is
        begin  -- AXI_READ
            --start of read access
            wait until rising_edge(s_axi_aclk);
            s_axi_araddr  <= ADDR;
            s_axi_arvalid <= '0';
            s_axi_rready  <= '1';
            s_axi_awvalid <= '0';
            s_axi_wvalid  <= '0';

           while (s_axi_arready = '0')
           loop
                wait until rising_edge(s_axi_aclk);
                s_axi_arvalid <= not s_axi_arready;
            end loop;
           while (s_axi_rvalid = '0')
           loop
                wait until rising_edge(s_axi_aclk);
                s_axi_rready  <= not s_axi_rvalid;
                data := s_axi_rdata;
                s_axi_arvalid <= '0';
                if (ADDR = ADDR_ISR) then
                    interrupt <= s_axi_rdata(7 downto 0); 
                end if;
                if (ADDR = ADDR_SR) then
                    sr <= s_axi_rdata(7 downto 0); 
                end if;

            end loop;

            --access is finished
            wait until rising_edge(s_axi_aclk);
            s_axi_arvalid <= '0';
            s_axi_rready  <= '0';
            wait until rising_edge(s_axi_aclk);         
        end AXI_READ;

        variable data : std_logic_vector(31 downto 0);
        
    begin
        wait until rising_edge(s_axi_aresetn);
        --enable all interrupts
        AXI_WRITE(ADDR_GIE, x"80000000"); 
        AXI_WRITE(ADDR_IER, x"0000003F");
        AXI_READ(ADDR_IER, data);                               
         --Reset TX FIFO
        --AXI_WRITE(ADDR_CR,  x"0000000B");
        --AXI_WRITE(ADDR_CR,  x"00000009");
        wait for 10 us;
        --Clear any pending IRQ
        AXI_READ(ADDR_ISR, data);
        AXI_WRITE(ADDR_ISR, data);
         --Reset TX FIFO
        AXI_WRITE(ADDR_CR,  x"0000000B");  -- reset Tx FIFO only
        AXI_WRITE(ADDR_CR,  x"00000009");  -- set Tx FIFO normal operation 
--        AXI_WRITE(ADDR_GIE, x"80000000");

       ---------------------------------------
        --Send START + address + 1 byte + STOP pattern
        ---------------------------------------
        -- Slave address is 0x6c (7 bit addressing) => 0xD8 address
        --waiting a small time between 2 commands
        AXI_WRITE(ADDR_TXFIFO, x"000001D8");      --START + 1 byte (0xD8)
        --AXI_WRITE(ADDR_TXFIFO, x"000001C0");      --START + 1 byte (0xC0)
        for i in 0 to 299 loop
            AXI_READ(ADDR_ISR, data);
            wait for 100 ns;
            AXI_WRITE(ADDR_ISR, data);
            AXI_READ(ADDR_SR, data);
        end loop;  -- i

        wait for 10 us;
     
      -- 1st Data byte of slave is 0x212 + stop  bit   
   --       AXI_WRITE(ADDR_TXFIFO, x"00000011");      --1 data byte (0x11)
          AXI_WRITE(ADDR_TXFIFO, x"00000212");      --1 data byte (0x12) + STOP bit
          for i in 0 to 299 loop
              AXI_READ(ADDR_ISR, data);
              wait for 100 ns;
              AXI_WRITE(ADDR_ISR, data);
              AXI_READ(ADDR_SR, data);
          end loop;  -- i
  
          wait for 10 us;
      
--      -- 2nd Data byte is 0x12       
--        AXI_WRITE(ADDR_TXFIFO, x"00000012");      --1 data byte (0x12) 

--        for i in 0 to 299 loop
--            AXI_READ(ADDR_ISR, data);
--            wait for 100 ns;
--            AXI_WRITE(ADDR_ISR, data);
--            AXI_READ(ADDR_SR, data);
--        end loop;  -- i

--        wait for 10 us;
        
--        --Address slave that does not exist, expect NACK
--                AXI_WRITE(ADDR_TXFIFO, x"00000008");      -- 1 address byte (0x08)
--                for i in 0 to 299 loop
--                    AXI_READ(ADDR_ISR, data);
--                    wait for 100 ns;
--                    AXI_WRITE(ADDR_ISR, data);
--                    AXI_READ(ADDR_SR, data);
--                end loop;  -- i        
--        wait for 20 us;        
        

      -- Data byte is 0x12       
  --      AXI_WRITE(ADDR_TXFIFO, x"000002EF");      --1 data byte (0xEF) + STOP bit
--        AXI_WRITE(ADDR_TXFIFO, x"000002ab");      --1 data byte (0xab) + STOP bit
--        for i in 0 to 299 loop
--            AXI_READ(ADDR_ISR, data);
--            wait for 100 ns;
--            AXI_WRITE(ADDR_ISR, data);
--            AXI_READ(ADDR_SR, data);
--        end loop;  -- i

--        wait for 10 us;
--           --Reset TX FIFO
--       AXI_WRITE(ADDR_CR,  x"0000000B");  -- reset Tx FIFO only
--       AXI_WRITE(ADDR_CR,  x"00000009");  -- set Tx FIFO normal operation       
--        --Address slave that does not exist, expect NACK
--                AXI_WRITE(ADDR_TXFIFO, x"00000108");      --START + 1 byte (0x08)
--                for i in 0 to 299 loop
--                    AXI_READ(ADDR_ISR, data);
--                    wait for 100 ns;
--                    AXI_WRITE(ADDR_ISR, data);
--                    AXI_READ(ADDR_SR, data);
--                end loop;  -- i        
--        wait for 20 us;
        
--       --Send START + address  + STOP
--        AXI_WRITE(ADDR_TXFIFO, x"000003D8");      --START + 1 byte (0xD8) + STOP
--        for i in 0 to 299 loop
--            AXI_READ(ADDR_ISR, data);
--            wait for 100 ns;
--            AXI_WRITE(ADDR_ISR, data);
--            AXI_READ(ADDR_SR, data);
--        end loop;  -- i

--        wait for 10 us;

--        AXI_WRITE(ADDR_TXFIFO, x"000001D8");      --START + 1 byte (0xD8)
--        for i in 0 to 299 loop
--            AXI_READ(ADDR_ISR, data);
--            wait for 100 ns;
--            AXI_WRITE(ADDR_ISR, data);
--            AXI_READ(ADDR_SR, data);
--        end loop;  -- i

--        wait for 10 us;
      
--        AXI_WRITE(ADDR_TXFIFO, x"00000212");      --1 byte (0x12) + STOP
--        for i in 0 to 299 loop
--            AXI_READ(ADDR_ISR, data);
--            wait for 100 ns;
--            AXI_WRITE(ADDR_ISR, data);
--            AXI_READ(ADDR_SR, data);
--        end loop;  -- i

--        --Address slave that does not exist, expect NACK
--        AXI_WRITE(ADDR_TXFIFO, x"00000108");      --START + 1 byte (0x08)
--        for i in 0 to 299 loop
--            AXI_READ(ADDR_ISR, data);
--            wait for 100 ns;
--            AXI_WRITE(ADDR_ISR, data);
--            AXI_READ(ADDR_SR, data);
--        end loop;  -- i



wait for 100 us;
        
--        --AXI_WRITE(ADDR_CR,  x"00000000"); --when that line is commented out, next I2C transfer is wrong 
--        --Reset TX FIFO
--        AXI_WRITE(ADDR_CR,  x"0000000B");
--        AXI_WRITE(ADDR_CR,  x"00000009");
        
--        --Send START + address  + STOP
--        AXI_WRITE(ADDR_TXFIFO, x"000003D8");      --START + 1 byte (0xD8)
--        for i in 0 to 999 loop
--            AXI_READ(ADDR_ISR, data);
--            wait for 100 ns;
--            AXI_WRITE(ADDR_ISR, data);
--            AXI_READ(ADDR_SR, data);
--        end loop;  -- i

--        while true loop
--            AXI_READ(ADDR_ISR, data);
--            wait for 100 ns;
--            AXI_READ(ADDR_SR, data);
--        end loop;
                
    end process WaveGen_Proc;

    

end tb;







































































































































































library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;
library unisim;
use unisim.vcomponents.all;



entity i2c_slave is

    port (
        scl_io : inout std_logic;
        sda_io : inout std_logic
        );

end entity;

architecture tb of i2c_slave is

    signal scl_o, scl_i, scl_tri : std_logic;
    signal sda_o, sda_i          : std_logic;
    signal sda_tri               : std_logic := '1';

    signal start_det, stop_det  : std_logic := '0';
    signal address_det, add_ack : std_logic := '0';
    signal address              : std_logic_vector (7 downto 0);
    signal address_with_lsb0    : std_logic_vector (7 downto 0);

    signal command_det, command_ack, cmd0_ack, cmd1_ack, cmd2_ack : std_logic := '0';
    signal cmd_detected0, cmd_detected1, cmd_detected2            : std_logic := '0';
    signal command                                                : std_logic_vector (7 downto 0);
    signal command0                                               : std_logic_vector (7 downto 0);
    signal command1                                               : std_logic_vector (7 downto 0);
    signal command2                                               : std_logic_vector (7 downto 0);

    signal rd_addr_det : std_logic := '0';

    signal command0_cg03   : std_logic_vector (7 downto 0);
    signal command0_cg04   : std_logic_vector (7 downto 0);
    signal command0_cg12   : std_logic_vector (7 downto 0);
    signal command0_cg11   : std_logic_vector (7 downto 0);
    signal command1_cg11   : std_logic_vector (7 downto 0);
    signal command2_cg11   : std_logic_vector (7 downto 0);
    signal command0_tmp435 : std_logic_vector (7 downto 0);
    signal command1_tmp435 : std_logic_vector (7 downto 0);
    signal command0_mux    : std_logic_vector (7 downto 0);

    signal command0_memo_pulse : std_logic;
    signal command1_memo_pulse : std_logic;
    signal command2_memo_pulse : std_logic;

    signal cnt_bit_read  : unsigned(7 downto 0);
    signal cnt_bit_write : unsigned(7 downto 0);

    signal scl_int : std_logic := '0';

    type selected_device_type is (I2C_MUX,
                                    CG11,
                                    CG12,
                                    CG14,
                                    CG21,
                                    CG03,
                                    CG04,
                                    TMP435,
                                    UNKNOWN);
    signal selected_device : selected_device_type;
    signal selected_chain  : std_logic_vector(1 downto 0) := "XX";

    signal cg11_simulate_error : std_logic := '0';  -- No error simulated by default

begin

    scl_tri <= '1';

    scl_inst : IOBUF
        port map (
            IO => scl_io,
            I  => scl_o,
            O  => scl_int,
            T  => scl_tri);

    sda_inst : IOBUF
        port map (
            IO => sda_io,
            I  => sda_o,
            O  => sda_i,
            T  => sda_tri);

    
    scl_pullup : pullup port map (
        O => scl_io
        );

    sda_pullup : pullup port map (
        O => sda_io
        );

    scl_i <= transport scl_int after 40 ns;


    process (sda_i, scl_i)
    begin
        if (sda_i'event and sda_i = '0') then
            if (scl_i = '1') then
                start_det <= '1';
            end if;
        elsif (scl_i'event and scl_i = '1') then
            start_det <= '0';
        end if;
    end process;


    process (sda_i, scl_i)
    begin
        if (sda_i'event and sda_i = '1') then
            if (scl_i = '1' and sda_i = '1') then
                stop_det <= '1';
--            report "Stop condition detected" severity note;
            end if;
        elsif (scl_i'event and scl_i = '1') then
            stop_det <= '0';
        end if;
    end process;


    process (scl_i)

    begin
        if (scl_i'event and scl_i = '0') then
            if (start_det = '1') then
                cnt_bit_write       <= "00001000";
                cmd_detected0       <= '0';
                cmd_detected1       <= '0';
                cmd_detected2       <= '0';
                address             <= "XXXXXXXX";
                command             <= "XXXXXXXX";
                command0            <= "XXXXXXXX";
                command1            <= "XXXXXXXX";
                command2            <= "XXXXXXXX";
                command0_memo_pulse <= '0';
                command1_memo_pulse <= '0';
                command2_memo_pulse <= '0';
            end if;
        elsif (scl_i'event and scl_i = '1') then
            command0_memo_pulse <= '0';
            command1_memo_pulse <= '0';
            command2_memo_pulse <= '0';
            if (address_det = '0') then
                address (0)          <= sda_i;
                address (7 downto 1) <= address (6 downto 0);
            elsif (add_ack = '1' and cmd_detected0 = '0' and cnt_bit_write > 0 and sda_tri = '1' and rd_addr_det = '0') then
                command0 (0)          <= sda_i;
                command0 (7 downto 1) <= command0 (6 downto 0);
                cnt_bit_write         <= cnt_bit_write - 1;
                if (cnt_bit_write = 1) then
                    cmd_detected0       <= '1';
                    cnt_bit_write       <= "00001000";
                    command0_memo_pulse <= '1';
                end if;
            elsif (add_ack = '1' and cmd_detected1 = '0' and cnt_bit_write > 0 and sda_tri = '1') then
                command1 (0)          <= sda_i;
                command1 (7 downto 1) <= command1 (6 downto 0);
                cnt_bit_write         <= cnt_bit_write - 1;
                if (cnt_bit_write = 1) then
                    cmd_detected1       <= '1';
                    cnt_bit_write       <= "00001000";
                    command1_memo_pulse <= '1';
                end if;
            elsif (add_ack = '1' and cmd_detected2 = '0' and cnt_bit_write > 0 and sda_tri = '1') then
                command2 (0)          <= sda_i;
                command2 (7 downto 1) <= command2 (6 downto 0);
                cnt_bit_write         <= cnt_bit_write - 1;
                if (cnt_bit_write = 1) then
                    cmd_detected2       <= '1';
                    cnt_bit_write       <= "00001000";
                    command2_memo_pulse <= '1';
                end if;
            end if;
        end if;
    end process;

--write or read access
    address_det <= '0' when (address_with_lsb0 = x"D8") and (cg11_simulate_error = '1') else  --CG11
                   '1' when ((address_with_lsb0 = "11100010") or (address_with_lsb0 = "11011000") or (address_with_lsb0 = x"DA") or (address_with_lsb0 = x"D2") or (address_with_lsb0 = x"D4") or (address_with_lsb0 = x"D0") or (address_with_lsb0 = x"98")) else '0';
--read access
    rd_addr_det <= '1' when (address = x"D1") or (address = x"E3") or (address = x"99") or (address = x"D9")else '0';
-- command_det <= '1' when (command = "00100001") else '0';
    command_det <= '1' when ((command = "00000101") or (command = "00000000")) else '0';


    process (scl_i)
    begin
        if (scl_i'event and scl_i = '0') then
            if (stop_det = '1') then
                add_ack      <= '0';
                command_ack  <= '0';
                cmd0_ack     <= '0';
                cmd1_ack     <= '0';
                cmd2_ack     <= '0';
                cnt_bit_read <= "00001000";
            elsif (address_det = '1' and add_ack = '0') then
                sda_tri <= '0';
                sda_o   <= '0';
                add_ack <= '1';
            elsif (cmd_detected0 = '1' and cmd0_ack = '0') then
                sda_tri  <= '0';
                sda_o    <= '0';
                cmd0_ack <= '1';
            elsif (cmd_detected1 = '1' and cmd1_ack = '0') then
                sda_tri  <= '0';
                sda_o    <= '0';
                cmd1_ack <= '1';
            elsif (cmd_detected2 = '1' and cmd2_ack = '0') then
                sda_tri  <= '0';
                sda_o    <= '0';
                cmd2_ack <= '1';
            elsif (rd_addr_det = '1' and cnt_bit_read > 0) then
                sda_tri <= '0';
                if (selected_device = CG12) then
                    sda_o <= command0_cg12(to_integer(cnt_bit_read)-1);
                elsif (selected_device = I2C_MUX) then
                    sda_o <= command0_mux(to_integer(cnt_bit_read)-1);
                elsif (selected_device = CG11) and (command0_cg11 = x"00") and (command1_cg11 = x"25") then
                    sda_o <= command2_cg11(to_integer(cnt_bit_read)-1);
                elsif (selected_device = TMP435) and (command0_tmp435 = x"09") then
                    sda_o <= command1_tmp435(to_integer(cnt_bit_read)-1);
                end if;
                cnt_bit_read <= cnt_bit_read - 1;
            else
                sda_tri <= '1';
            end if;
        end if;
    end process;


    address_with_lsb0 <= address(7 downto 1) & '0';
    process (address_with_lsb0, cg11_simulate_error) begin
                                                         case address_with_lsb0 is
                                                             
                                                             when x"E2" =>
                                                                 selected_device <= I2C_MUX;
                                                                 
                                                             when x"D8" =>
                                                                 if (cg11_simulate_error = '1') then
                                                                     selected_device <= UNKNOWN;
                                                                 else
                                                                     selected_device <= CG11;
                                                                 end if;
                                                                 
                                                             when x"D0" =>
                                                                 selected_device <= CG12;
                                                                 
                                                             when x"DA" =>
                                                                 selected_device <= CG21;
                                                                 
                                                             when x"D2" =>
                                                                 selected_device <= CG03;
                                                                 
                                                             when x"D4" =>
                                                                 selected_device <= CG04;
                                                                 
                                                             when x"98" =>
                                                                 selected_device <= TMP435;
                                                                 
                                                             when others =>
                                                                 selected_device <= UNKNOWN;
                                                                 
                                                         end case;
                                                     end process;

-- command memorisation at the end of a write access
                                                         command0_cg03   <= command0 when ((command0_memo_pulse = '1') and (selected_device = CG03));
                                                         command0_cg04   <= command0 when ((command0_memo_pulse = '1') and (selected_device = CG04));
                                                         command0_cg12   <= command0 when ((command0_memo_pulse = '1') and (selected_device = CG12));
                                                         command0_cg11   <= command0 when ((command0_memo_pulse = '1') and (selected_device = CG11));
                                                         command1_cg11   <= command1 when ((command1_memo_pulse = '1') and (selected_device = CG11));
                                                         command2_cg11   <= command2 when ((command2_memo_pulse = '1') and (selected_device = CG11));
                                                         command0_tmp435 <= command0 when ((command0_memo_pulse = '1') and (selected_device = TMP435));
                                                         command1_tmp435 <= command1 when ((command1_memo_pulse = '1') and (selected_device = TMP435));
                                                         command0_mux    <= command0 when ((command0_memo_pulse = '1') and (selected_device = I2C_MUX));




                                                     end tb;

