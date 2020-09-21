with Delays;
with CSP;
with MCU.Port_IO;
with MCU.GCLK;
with MCU.Text_Output;

procedure Program is
   System_Clock_Frequency : constant Positive := 4_000_000;
   package Main_Clock_Delays is new Delays (System_Clock_Frequency);

   package Uart3_Text_Out is new MCU.Text_Output(CSP.UART_3.Put_8bit_Data);
   use Uart3_Text_Out;

begin
   --  Initialize LED
   CSP.Pin_B10.Output_High;
   CSP.Pin_B10.Output_Drive;
   Main_Clock_Delays.Delay_Ms (2000);

   --  Configure Input to be a pullup
   CSP.Pin_A02.Output_High;
   CSP.Pin_A02.Configure
      (Pull_Enable  => MCU.Port_IO.Enabled,
       Input_Enable => MCU.Port_IO.Enabled);

   -- Configure a generic clock
   CSP.GCLK_00.Configure(Clock => MCU.GCLK.Internal_16MHz);

   -- Attach it to SERCOM3
   CSP.SERCOM3_CLK.Configure(GCLK => MCU.GCLK.GCLK_00);

   -- Configure Serial Pins
   CSP.Pin_A22.Configure_PMUX(PMUX_Function => MCU.Port_IO.Function_C);
   CSP.Pin_A23.Configure_PMUX(PMUX_Function => MCU.Port_IO.Function_C);
   CSP.Pin_A22.Configure(PMUX_Enable => MCU.Port_IO.Enabled);
   CSP.Pin_A23.Configure(PMUX_Enable => MCU.Port_IO.Enabled);

   CSP.UART_3.Configure(Baud => 16#F628#);

   Put_Line("Hello World from Ada!");

   --  Main Loop
   loop
      if (CSP.Pin_A02.Input_Low) then
         CSP.Pin_B10.Output_Low;
      else
         Main_Clock_Delays.Delay_Ms (1000);
         CSP.Pin_B10.Output_Toggle;
      end if;
   end loop;
end Program;
