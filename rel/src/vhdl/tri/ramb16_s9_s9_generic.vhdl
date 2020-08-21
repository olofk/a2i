-- © IBM Corp. 2020
-- This softcore is licensed under and subject to the terms of the CC-BY 4.0
-- license (https://creativecommons.org/licenses/by/4.0/legalcode). 
-- Additional rights, including the right to physically implement a softcore 
-- that is compliant with the required sections of the Power ISA 
-- Specification, will be available at no cost via the OpenPOWER Foundation. 
-- This README will be updated with additional information when OpenPOWER's 
-- license is available.


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--library ibm; 
--use ibm.std_ulogic_support.all;
--use ibm.std_ulogic_function_support.all;

entity RAMB16_S9_S9 is
	generic (
		SIM_COLLISION_CHECK : string := "ALL"
	);
	port (
		DOA : out std_logic_vector(7 downto 0);
		DOB : out std_logic_vector(7 downto 0);
		DOPA : out std_logic_vector(0 downto 0);
		DOPB : out std_logic_vector(0 downto 0);
		ADDRA : in std_logic_vector(10 downto 0);
		ADDRB : in std_logic_vector(10 downto 0);
		CLKA : in std_ulogic;
		CLKB : in std_ulogic;
		DIA : in std_logic_vector(7 downto 0);
		DIB : in std_logic_vector(7 downto 0);
		DIPA : in std_logic_vector(0 downto 0);
		DIPB : in std_logic_vector(0 downto 0);
		ENA : in std_ulogic;
		ENB : in std_ulogic;
		SSRA : in std_ulogic;
		SSRB : in std_ulogic;
		WEA : in std_ulogic;
		WEB : in std_ulogic
	);
end RAMB16_S9_S9;

architecture RAMB16_S9_S9 of RAMB16_S9_S9 is

  signal DOUTA, DOUTB   : std_logic_vector(8 downto 0);

  TYPE mem IS ARRAY(0 TO 2047) OF std_ulogic_vector(8 DOWNTO 0);
  SIGNAL ram_block : mem;

begin

DOPA(0) <= DOUTA(8);
DOA    <= DOUTA(7 downto 0);

DOPB(0) <= DOUTB(8);
DOB    <= DOUTB(7 downto 0);

ram: process (clka) is
begin  -- process ram
  if rising_edge(clka) then
    if wea then
      ram_block(to_integer(unsigned(addra))) <= dipa & dia;
    end if;
    douta <= ram_block(to_integer(unsigned(addra)));

    if web then
      ram_block(to_integer(unsigned(addrb))) <= dipb & dib;
    end if;
    doutb <= ram_block(to_integer(unsigned(addrb)));

    --if coll check & wea & web => WARN!!
  end if;
end process ram;

end RAMB16_S9_S9;
