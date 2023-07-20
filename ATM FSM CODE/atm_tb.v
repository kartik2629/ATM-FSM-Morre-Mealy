`timescale 1ns / 10ps
module atm_tb;
  reg [0:1]accNumber;
  reg [0:1]Pin;
reg card_inserted;
reg enter;
reg with_d;
reg dep;
reg mini_s;
reg clk;
reg reset;
reg [0:3]amount_in;
wire [15:0] balance;
wire accountfound;
wire pinfound;
  
  atm atm_dut(
    .accNumber(accNumber),
    .Pin(Pin),
    .card_inserted(card_inserted),
    .enter(enter),
    .with_d(with_d),
    .dep(dep),
    .mini_s(mini_s),
    .clk(clk),
    .reset(reset),
    .amount_in(amount_in),
    .balance(balance),
    .accountfound(accountfound),
    .pinfound(pinfound)
  );
  
  always #5 clk = ~clk; // Clock generation
  
  initial begin
    clk = 0;
    reset = 1;
    #10 reset = 0; // Reset the ATM module
    //Test Case 1 :PIN Verification (correct at 1st try) and deposit
    $display("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
    $display("Test Case 1 :PIN Verification (correct at 1st try) and deposit1");
    enter =1;
    accNumber =1;
    #20
    enter =0;
    #10
    card_inserted= 1'b1;
    #20
    card_inserted= 1'b0;
    Pin= 2'b01;
    enter=1;
    #20
    Pin   =0;
    enter =0;
    #10
    dep=1;
    #20
    dep=0;
    enter=1;
    amount_in=2;
    #20
    enter=0;
    #10
    #20
    //Test Case 2 :PIN Verification (correct at 2nd try) and deposit
     $display("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
    $display("Test Case 2 :PIN Verification (correct at 2nd try) and deposit3");
    enter =1;
    accNumber =1;
    #20
    enter =0;
    #10
    card_inserted= 1'b1;
    #20
    card_inserted= 1'b0;
    Pin= 2'b11;
    enter=1;
    #20
    Pin   =0;
    enter =0;
    #20
    Pin= 2'b01;
    enter=1;
    #20
    Pin   =0;
    enter =0;
    #10
    dep=1;
    #20
    dep=0;
    enter=1;
    amount_in=2;
    #20
    enter=0;
    #10
    #20
    //Test Case 3 :PIN Verification (correct at 3rd try) and deposit
    $display("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
    $display("Test Case 3 :PIN Verification (correct at 3rd try) and deposit2");
    enter =1;
    accNumber =1;
    #20
    enter =0;
    #10
    card_inserted= 1'b1;
    #20
    card_inserted= 1'b0;
    Pin= 2'b11;
    enter=1;
    #20
    Pin   =0;
    enter =0;
    #20
    Pin= 2'b11;
    enter=1;
    #15
    Pin   =0;
    enter =0;
     #20
    Pin= 2'b01;
    enter=1;
    #20
    Pin   =0;
    enter =0;
    #10
    dep=1;
    #20
    dep=0;
    enter=1;
    amount_in=1;
    #20
    enter=0;
    #10
    #20
    //Test Case 4 : deposit
    $display("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
    $display("Test Case 4 : deposit4");
    enter =1;
    accNumber =1;
    #20
    enter =0;
    #10
    card_inserted= 1'b1;
    #20
    card_inserted= 1'b0;
    Pin= 2'b01;
    enter=1;
    #20
    Pin   =0;
    enter =0;
    #10
    dep=1;
    #20
    dep=0;
    enter=1;
    amount_in=1;
    #20
    enter=0;
    #10
    #20
    //Test Case 5: Mini Statement
    $display("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
    $display("Test Case 5: Mini Statement");
    enter =1;
    accNumber =1;
    #20
    enter =0;
    #10
    card_inserted= 1'b1;
    #20
    card_inserted= 1'b0;
    Pin= 2'b01;
    enter=1;
    #20
    Pin   =0;
    enter =0;
    #10
    mini_s=1;
    #20
    mini_s=0;
    #20
    //Test Case 6 : Making another deposit to check if mini statement is functioning as intended
     $display("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
    $display("//Test Case 6 : Making another deposit to check if mini statement is functioning as intended");
    enter =1;
    accNumber =1;
    #20
    enter =0;
    #10
    card_inserted= 1'b1;
    #20
    card_inserted= 1'b0;
    Pin= 2'b01;
    enter=1;
    #20
    Pin   =0;
    enter =0;
    #10
    dep=1;
    #20
    dep=0;
    enter=1;
    amount_in=1;
    #20
    enter=0;
    #10
    #20
    //Test Case 7: Mini Statement
    $display("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
    $display("Test Case 7: Mini Statement");
    enter =1;
    accNumber =1;
    #20
    enter =0;
    #10
    card_inserted= 1'b1;
    #20
    card_inserted= 1'b0;
    Pin= 2'b01;
    enter=1;
    #20
    Pin   =0;
    enter =0;
    #10
    mini_s=1;
    #20
    mini_s=0;
    #20
    //TestCase 8 Withdraw 1 
    $display("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
    $display("TestCase 8: Withdraw 1");
    enter =1;
    accNumber =1;
    #20
    enter =0;
    #10
    card_inserted= 1'b1;
    #20
    card_inserted= 1'b0;
    Pin= 2'b01;
    enter=1;
    #20
    Pin   =0;
    enter =0;
    #10
    with_d=1;
    #20
    with_d=0;
    enter=1;
    amount_in=1;
    #20
    enter=0;
    #10
    #20
    //TestCase 9 Withdraw 2  
    $display("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
    $display("TestCase 9: Withdraw 2");
    enter =1;
    accNumber =1;
    #20
    enter =0;
    #10
    card_inserted= 1'b1;
    #20
    card_inserted= 1'b0;
    Pin= 2'b01;
    enter=1;
    #20
    Pin   =0;
    enter =0;
    #10
    with_d=1;
    #20
    with_d=0;
    enter=1;
    amount_in=1;
    #20
    enter=0;
    #10
    #20
    //TestCase 10 Withdraw 3  
    $display("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
    $display("TestCase 10: Withdraw 3");
    enter =1;
    accNumber =1;
    #20
    enter =0;
    #10
    card_inserted= 1'b1;
    #20
    card_inserted= 1'b0;
    Pin= 2'b01;
    enter=1;
    #20
    Pin   =0;
    enter =0;
    #10
    with_d=1;
    #20
    with_d=0;
    enter=1;
    amount_in=1;
    #20
    enter=0;
    #10
    #20
    
    //TestCase 11 Withdraw 4  
    $display("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
    $display("TestCase 11: Withdraw 4");
    enter =1;
    accNumber =1;
    #20
    enter =0;
    #10
    card_inserted= 1'b1;
    #20
    card_inserted= 1'b0;
    Pin= 2'b01;
    enter=1;
    #20
    Pin   =0;
    enter =0;
    #10
    with_d=1;
    #20
    with_d=0;
    enter=1;
    amount_in=1;
    #20
    enter=0;
    #10
    #20
    
    //Test Case 12: Mini Statement for withdraw
    $display("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
    $display("Test Case 12: Mini Statement for withdraw");
    enter =1;
    accNumber =1;
    #20
    enter =0;
    #10
    card_inserted= 1'b1;
    #20
    card_inserted= 1'b0;
    Pin= 2'b01;
    enter=1;
    #20
    Pin   =0;
    enter =0;
    #10
    mini_s=1;
    #20
    mini_s=0;
    #20
    
    //TestCase 13 Withdraw 5  
    $display("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
    $display("TestCase 13: Withdraw 5");
    enter =1;
    accNumber =1;
    #20
    enter =0;
    #10
    card_inserted= 1'b1;
    #20
    card_inserted= 1'b0;
    Pin= 2'b01;
    enter=1;
    #20
    Pin   =0;
    enter =0;
    #10
    with_d=1;
    #20
    with_d=0;
    enter=1;
    amount_in=2;
    #20
    enter=0;
    #10
    #20
    
    //Test Case 14: Mini Statement for withdraw
    $display("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
    $display("Test Case 14: Mini Statement for withdraw");
    enter =1;
    accNumber =1;
    #20
    enter =0;
    #10
    card_inserted= 1'b1;
    #20
    card_inserted= 1'b0;
    Pin= 2'b01;
    enter=1;
    #20
    Pin   =0;
    enter =0;
    #10
    mini_s=1;
    #20
    mini_s=0;
    #20
    //Test Case 15: if the deposit amount exceed 5,000/-
    $display("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
    $display("Test Case 14: if the deposit amount exceed 10,000/-");
    enter =1;
    accNumber =1;
    #20
    enter =0;
    #10
    card_inserted= 1'b1;
    #20
    card_inserted= 1'b0;
    Pin= 2'b01;
    enter=1;
    #20
    Pin   =0;
    enter =0;
    #10
    dep=1;
    #20
    dep=0;
    enter=1;
    amount_in=11;
    #20
    enter=0;
    #10 
    //Test Case 16: if the withdrawal amount exceed the bank account balance
    $display("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
    $display("Test Case 15: if the withdrawal amount exceed the bank account balance");
    enter =1;
    accNumber =1;
    #20
    enter =0;
    #10
    card_inserted= 1'b1;
    #20
    card_inserted= 1'b0;
    Pin= 2'b01;
    enter=1;
    #20
    Pin   =0;
    enter =0;
    #10
    with_d=1;
    #20
    with_d=0;
    enter=1;
    amount_in=4;
    #20
    enter=0;
    #10
    #20
    //Test Case 17:Blocking account
    $display("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
    $display("Test Case 17:Blocking account");
        enter =1;
    accNumber =1;
    #20
    enter =0;
    #10
    card_inserted= 1'b1;
    #20
    card_inserted= 1'b0;
    Pin= 2'b11;
    enter=1;
    #20
    Pin   =0;
    enter =0;
    #20
    Pin= 2'b11;
    enter=1;
    #20
    Pin   =0;
    enter =0;
     #20
    Pin= 2'b11;
    enter=1;
    #20
    Pin   =0;
    enter =0;
    #10
    dep=1;
    #20
    dep=0;
    enter=1;
    amount_in=1;
    #20
    enter=0;
    #10
    #20
    //Test Case 18: Checking if the account is blocked or not while timer is running
    $display("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
    $display("Test Case 18: Checking if the account is blocked or not while timer is running");
    enter =1;
    accNumber =1;
    #20
    enter =0;
    #10
    card_inserted= 1'b1;
    #20
    card_inserted= 1'b0;
    #20
     //Test Case 19: Checking if the account is blocked or not while timer is running
    $display("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
    $display("Test Case 19: Checking if the account is blocked or not while timer is running");
    enter =1;
    accNumber =1;
    #20
    enter =0;
    #10
    card_inserted= 1'b1;
    #20
    card_inserted= 1'b0;
    #20
    //Test Case 20: Checking if the account is blocked or not while timer is running
    $display("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
    $display("Test Case 20 : Checking if the account is blocked or not while timer is running");
    enter =1;
    accNumber =1;
    #20
    enter =0;
    #10
    card_inserted= 1'b1;
    #20
    card_inserted= 1'b0;
    #10
    
    
    
    
    
    $finish; // End simulation
  end

endmodule