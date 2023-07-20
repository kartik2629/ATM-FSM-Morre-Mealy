`timescale 1ns / 10ps
module atm(
input [0:1]accNumber,
input [0:1]Pin,
input card_inserted,
input enter,
input with_d,
input dep,
input mini_s,
input clk,
input reset,
input [0:3]amount_in,
output reg [15:0] balance,
output wire accountfound,
output wire pinfound,
output clk_out

    ); 
	 
Clock_divider clk_div( 
.clk(clk), 
.clk_out(clk_out)
    ); 
	 
	 
//registers for account database
integer i;
reg [15:0]amount;
reg accCount;
reg Acc_valid;
reg Pin_valid;
reg pin_enter1;
reg pin_enter2;
reg pin_enter3;
reg Acc_Blocked[3:0];
reg [1:0]AccIndex;
reg [1:0] count[3:0];
reg [1:0] acc_database[3:0];
reg [15:0] balance_database [3:0];
reg [1:0] pin_database[3:0];
//FSM registers 
reg [3:0] state;
reg deposit_enter;
reg withdraw_enter;
reg withdraw_INVALID;
reg deposit_INVALID;
reg deposit_success;
reg withdraw_success;
reg statement_success;
reg Mini_State_Success;

//Timer registers
reg [23:0] timer[0:9]; // 24-bit timer to track elapsed time (up to 24 hours)
  reg [23:0] block_duration=24'b000000000000000000010111; // Duration for account blocking (24 hours)

//MINI STATEMENT for Withdrawal
reg withdraw_valid;
reg [15:0]transaction_withdraw[0:3]; // Array to store transaction details
reg [2:0] transactionCount_withdraw = 0; // Counter to track the number of transactions
reg [15:0]newTransaction_withdraw;
reg [15:0]newamount_withdraw;
reg [15:0]amount_withdraw[0:3];
reg [15:0]newTransactionDetails_withdraw;
integer k;
//MINI STATEMENT FOR DEPOSIT
reg deposit_valid;
reg [15:0]transaction_deposit[0:3]; // Array to store transaction details
reg [2:0] transactionCount_deposit = 0; // Counter to track the number of transactions
reg [15:0]newTransaction_deposit;
reg [15:0]newamount_deposit;
reg [15:0]amount_deposit[0:3];
reg [15:0]newTransactionDetails_deposit;
integer j;

//Acount Database
  initial begin
    $display("Welcome to the ATM");
	 acc_database[0] = 0; 
	 pin_database[0] = 0; 
	 count[0] = 0;
	 balance_database[0] = 0;
	 Acc_Blocked[0]=0;
	 
    acc_database[1] = 1; 
	 pin_database[1] = 1; 
	 count[1] = 0;
	 balance_database[1] = 16'd500;
	 Acc_Blocked[1]=0;
	 
    acc_database[2] = 2; 
	 pin_database[2] = 2; 
	 count[2] = 0;
	 balance_database[2] = 16'd500;
	 Acc_Blocked[2]=0;
	 
    acc_database[3] = 3; 
	 pin_database[3] = 3; 
	 count[3] = 0;
	 balance_database[3] = 16'd500;
	 Acc_Blocked[3]=0;
	 end 
	 
localparam Idle                 =4'b0000;
localparam Pin_Verification     =4'b0001;
localparam Menu                 =4'b0010;
localparam Withdraw             =4'b0011;
localparam Deposit              =4'b0100;
localparam Mini_Statement       =4'b0101;
localparam Finish               =4'b0110;
localparam Blocked              =4'b0111;
localparam Pin_Verification2    =4'b1011;
localparam Pin_Verification3    =4'b1100;
/*//Clock divider to create a 1Hz signal from the system clock
reg [26:0] clock_divider = 27'b0;
wire timer_tick;  // This will pulse high every second

always @(posedge clk or posedge reset) begin
    if (reset) begin
        clock_divider <= 0;
    end else if (clock_divider == 50_000_000 - 1) begin // Adjust this for your clock speed
        clock_divider <= 0;
    end else begin
        clock_divider <= clock_divider + 1;
    end
end

assign timer_tick = (clock_divider == 50_000_000 - 1) ? 1'b1 : 1'b0;*/

//Main FSM 

always@( posedge clk_out or posedge reset) begin
//always@( posedge clk or posedge reset) begin
if(reset)begin 
		balance<=0;
		accCount <=0;
		Acc_valid <= 1'b0;
		Pin_valid <= 0;
		AccIndex <= 0;
		for (i = 0; i < 4; i = i + 1) begin
	   transaction_withdraw[i]<=0;
		amount_withdraw[i]<=0;
		amount_deposit[i]<=0;
		transaction_deposit[i]<=0; 
		end
        transactionCount_withdraw <=1'b0; 
	    newTransaction_withdraw<=1'b0;
		newTransactionDetails_withdraw<=1'b0;
		transactionCount_deposit<=1'b0; 
		newTransaction_deposit<=1'b0;
		newTransactionDetails_deposit<=1'b0;
		deposit_INVALID<=0;
		withdraw_INVALID<=0;
		withdraw_valid<=1'b0;
		deposit_valid<=1'b0;
		deposit_success<=1'b0;
		withdraw_success<=1'b0;
		statement_success<=1'b0;
		Mini_State_Success<=1'b0;
		for (i = 1; i < 4; i = i + 1) begin
		Acc_Blocked[i] <= 1'b0;
	   timer[i] <= 1'b0;
		end
      state <= Idle;
end
else begin
/*if(enter==1)begin
if((accNumber != 2'b00)&&(state==4'b0000))begin
accCount=1;
$display("account enter: %d",accCount);
end
if((Pin !=2'b00)&&(state==4'b0001))begin
pin_enter1=1;
$display("PinV Enter: %d",pin_enter1);
end
if((Pin !=2'b00)&&(state==4'b1011))begin
pin_enter2=1;
end
if((Pin !=2'b00)&&(state==4'b1100))begin
pin_enter3=1;
end
if((amount_in!=4'b0000)&&((state==4'b0011)||(state==4'b0100)))begin
amount= amount_in*(500);
if(state==4'b0011)begin
withdraw_enter=1;
end
else if (state==4'b0100)begin
deposit_enter =1;
end
end
end */
if((accNumber != 2'b00)&&(state==4'b0000)&&(enter==1))begin
accCount=1;    
//$display("account enter: %d",accCount);
end
if((accNumber != 2'b00)&&(accCount==1)) begin

for (i = 1; i < 4; i = i + 1) begin
        if (accNumber == acc_database[i])begin
          if (Acc_Blocked[i]==0) begin
            Acc_valid <= 1;
            AccIndex <= i;
            $display("Account found");
            end
          end 
        end
 state = Idle; 
 accCount=0;
 //$display("STATE: %d",state);     
end 
case(state)
    Idle:
        if(card_inserted & Acc_valid & (Acc_Blocked[AccIndex]== 0))begin
        state = Pin_Verification;
        $display("card_inserted: %d",card_inserted);
        $display("Acc Valid: %d",Acc_valid);
        $display("Acc_Blocked: %d",Acc_Blocked[AccIndex]);
        $display("STATE: %d",state);
        end
  else if((Acc_Blocked[AccIndex]== 1)&&(card_inserted==1))begin
        $display("Account %d is blocked",accNumber);
        $display("Acc Valid: %d",Acc_valid);
        $display("Acc_Blocked: %d",Acc_Blocked[AccIndex]);
        state = Idle;
        $display("STATE: %d",state);
        end
	Pin_Verification:
	   if(Acc_Blocked[AccIndex]==1)begin //more changes to be made
      state = Idle;
      end
		else begin
        if((Pin !=2'b00)&&(enter==1))begin
		pin_enter1=1;
          $display("PinV1 Enter: %d",pin_enter1);
        end
		if((Pin !=2'b00)&&(pin_enter1==1))begin
		if (Pin == pin_database[AccIndex]) begin
		Pin_valid <= 1; 
		if(Pin_valid==1)begin 		  
       state = Menu;
       $display("Pin is correct.");
       $display("Pin valid: %d",Pin_valid);
       $display("STATE: %d",state);
       count[AccIndex]<=0;
	   pin_enter1=0;
       end	 
       end 
		else begin
	  if(Pin != pin_database[AccIndex])begin
      count[AccIndex] <= count[AccIndex] + 1;
      if (count[AccIndex]== 1)begin
      $display("Pin was incorrect. Please enter the correct PIN.");
      $display("Attempted %d time(s)",count[AccIndex]);
      state = Pin_Verification2 ;
      $display("STATE: %d",state);
	   pin_enter1=0; 	
        end	 
        end
        end
		end
		end
	Pin_Verification2:
      if(Pin_Verification2)begin
       if((Pin !=2'b00)&&(enter==1))begin
		pin_enter2=1;
         $display("PinV2 Enter: %d",pin_enter2);
		end 
	   if((Pin != 2'b00)&&(pin_enter2==1))begin
	   if (Pin == pin_database[AccIndex]) begin
	   Pin_valid <= 1;
      if(Pin_valid==1)begin 		  
       state = Menu;
       $display("Pin was correct.");
	   $display("Acc Index: %d",AccIndex);
	   $display("Pin valid: %d",Pin_valid);
       count[AccIndex]<=0;
       $display("STATE: %d",state);
	   pin_enter2=0;
       end
       end
       else begin
	   if(Pin != pin_database[AccIndex])begin
       $display("Pin was incorrect. Please enter the correct PIN.");
       count[AccIndex] <= count[AccIndex] + 1;
       $display("Attempted %d times",count[AccIndex]);
       if (count[AccIndex]== 2)begin
       state = Pin_Verification3 ;
       $display("STATE: %d",state);
		pin_enter2=0;
       end	  
       end
       end
	    end 
      end
	Pin_Verification3:
      if(Pin_Verification3)begin
      if((Pin !=2'b00)&&(enter==1))begin
		pin_enter3=1;
       $display("PinV3 Enter: %d",pin_enter3);
		end 
	    if((Pin != 2'b00)&&(pin_enter3==1))begin
	    if (Pin == pin_database[AccIndex]) begin
	    Pin_valid <= 1;
       if(Pin_valid==1)begin 		  
       state = Menu;
       $display("Pin was correct.");
	    $display("Acc Index: %d",AccIndex);
	    $display("Pin valid: %d",Pin_valid);
       count[AccIndex]<=0;
       pin_enter3=0;
       $display("STATE: %d",state);
       end
       end
       else begin
	    if(Pin != pin_database[AccIndex])begin
       $display("Pin was incorrect. Account will be blocked for 24 hours.");
       count[AccIndex] <= count[AccIndex] + 1;
       $display("Attempted %d times",count[AccIndex]);
       if (count[AccIndex]== 3)begin
       state = Blocked ;
       Acc_Blocked[AccIndex]<=1'b1;
       $display("STATE: %d",state);
       count[AccIndex] <= 0;
       pin_enter3=0;
       end
       end
       end
	   end
      end
	 Blocked:
		 if(Acc_Blocked[AccIndex] ==1'b1)
		 begin
		 $display("The account is blocked please try again after 24 hours");
		 state = Idle ;
		 $display("STATE: %d",state);
		 end
		 
		 
	Menu:
         if(with_d==1)begin
            state = Withdraw;
            $display("STATE: %d",state); 
         end
         else if(dep==1)begin
            state = Deposit;
            $display("STATE: %d",state);
         end  
         else if(mini_s==1) begin
            state = Mini_Statement;
            $display("STATE: %d",state);
         end
       
			 
	Withdraw:
      if(Withdraw)begin
        if((amount_in!=4'b0000)&&(enter==1))begin
        amount= amount_in*(500);
	    withdraw_enter=1; 
        end
      if((amount_in!=4'b0000)&&(withdraw_enter==1))begin
		if(amount>balance_database[AccIndex])begin
		withdraw_INVALID=1;
        $display("withdraw_INVALID %d",withdraw_INVALID);
        if(withdraw_INVALID==1)begin
        $display("Insufficient balance");
		state = Idle;
		$display("STATE: %d",state);
        withdraw_INVALID=0;
		amount=0;
        withdraw_enter=0;
		end
        end
		else if(amount<=balance_database[AccIndex])begin
        withdraw_valid<=1'b1;
        if(withdraw_valid==1'b1)begin
        $display("withdraw");
        balance_database[AccIndex]= $unsigned(balance_database[AccIndex])-$unsigned(amount);
        balance <=balance_database[AccIndex];
        withdraw_success=1'b1;
        $display("withdraw successful");
		$display("Withdrawal Transaction:");
        $display("Amount: %d", amount);
        $display("New Balance: %d", balance_database[AccIndex]); 
        end
        end 
        if(withdraw_success==1'b1)begin
        newTransaction_withdraw = withdraw_success;
        newTransactionDetails_withdraw = balance_database[AccIndex];
        newamount_withdraw = amount;  
        if (transactionCount_withdraw < 4 && newTransaction_withdraw) begin
        // Store the new transaction details in the array
        transaction_withdraw[transactionCount_withdraw] <=
          newTransactionDetails_withdraw;
        amount_withdraw[transactionCount_withdraw] <= newamount_withdraw;
        transactionCount_withdraw <= transactionCount_withdraw + 1;  
        end else if (newTransaction_withdraw) begin
        // Shift the transactions down the list
          for (k = 0; k < 3; k = k + 1) begin
            transaction_withdraw[k] <= transaction_withdraw[k+1];
            amount_withdraw[k] <= amount_withdraw[k+1];
        end
        // Store the new transaction details at the 4th place
        transaction_withdraw[3] <= newTransactionDetails_withdraw;
        amount_withdraw[3] <= newamount_withdraw;
        end
		$display("withdraw_success %d",withdraw_success);
        withdraw_valid<=1'b0;
        state = Finish;
        $display("STATE: %d",state);
        withdraw_success<=1'b0;
		amount=0;
		withdraw_enter=0; 
        end
		end
        end
          
		  		  
   Deposit:
        if(Deposit)begin
        if((amount_in!=4'b0000)&&(enter==1))begin
        amount= amount_in*(500);
	    deposit_enter=1; 
        end
    	if((amount_in!=4'b0000)&&(deposit_enter==1))begin
		if(amount>5000)begin
		deposit_INVALID=1;
		$display("deposit_INVALID %d",deposit_INVALID);
		if(deposit_INVALID==1)begin
        $display("Deposit not Accepted above 10000/-");
		state = Idle;
		$display("STATE: %d",state);
        deposit_INVALID=0;
		amount=0;
        deposit_enter=0;
		end
        end
        else if(amount<=5000)begin
        deposit_valid<=1'b1;
        if(deposit_valid==1'b1)begin
        $display("deposit");
        balance_database[AccIndex]= balance_database[AccIndex]+amount;
        balance <=balance_database[AccIndex];
        deposit_success=1'b1;
        $display("deposit successful");
		$display("Deposit Transaction:");
        $display("Amount: %d", amount);
        $display("New Balance: %d", balance_database[AccIndex]);     
        end
        end 
        if(deposit_success==1'b1)begin
        newTransaction_deposit = deposit_success;
        newTransactionDetails_deposit = balance_database[AccIndex];
        newamount_deposit = amount;
        if (transactionCount_deposit < 4 && newTransaction_deposit) begin
        // Store the new transaction details in the array
        transaction_deposit[transactionCount_deposit] <= newTransactionDetails_deposit;
        amount_deposit[transactionCount_deposit] <= newamount_deposit;
        transactionCount_deposit <= transactionCount_deposit + 1;  
        end else if (newTransaction_deposit) begin
        // Shift the transactions down the list
        for (j = 0; j < 3; j = j + 1) begin
        transaction_deposit[j] <= transaction_deposit[j+1];
        amount_deposit[j] <= amount_deposit[j+1];
        end
        // Store the new transaction details at the 4th place
          transaction_deposit[3] <= newTransactionDetails_deposit;
          amount_deposit[3] <= newamount_deposit;
        end
		$display("deposit_success %d",deposit_success);
        deposit_valid<=1'b0;
        state = Finish;
        $display("STATE: %d",state);
        deposit_success<=1'b0; 
		  amount=0;
        end
		end
        end
		
   Mini_Statement:
     	if(Mini_Statement)begin
		Mini_State_Success<=1'b1;
        if(Mini_State_Success==1'b1)begin
        $display("withdrawal");
          for (k = 3; k >= 0; k = k - 1) begin
            $display("| Transaction%d: | Balance-%d | Amount-%d |", k, transaction_withdraw[k],amount_withdraw[k]);
        end
        $display("Deposit");
          for (j = 3; j >= 0; j = j - 1) begin
            $display("| Transaction%d: | Balance-%d | Amount-%d |", j, transaction_deposit[j],amount_deposit[j]);
		end  
        state = Finish;
        $display("STATE: %d",state);
		Mini_State_Success<=1'b0;
		end  
		end	     
    Finish:
    if(Finish)begin
    state = Idle;
    $display("Thank you for choosing **** banking services");
    $display("STATE: %d",state); 	
    end	 	 
	endcase
if (clk_out) begin
//if (clk) begin
if (Acc_Blocked[1] == 1) begin
timer[1] <= timer[1] + 1;
$display("timer1 countdown: %d",timer[1]);
	    if (timer[1] >= block_duration) begin
	    // Unblocks the account after the block_duration has elapsed
	    Acc_Blocked[1] <= 0;
	    timer[1] <= 0;
	    end
end
if (Acc_Blocked[2] == 1) begin
timer[2] <= timer[2] + 1;
 $display("timer2 countdown: %d",timer[2]);
	    if (timer[2] >= block_duration) begin
	    // Unblocks the account after the block_duration has elapsed
	    Acc_Blocked[2] <= 0;
	    timer[2] <= 0;
	    end
end
if (Acc_Blocked[3] == 1) begin
timer[3] <= timer[3] + 1;
  $display("timer3 countdown: %d",timer[3]);  
	    if (timer[3] >= block_duration) begin
	    // Unblocks the account after the block_duration has elapsed
	    Acc_Blocked[3] <= 0;
	    timer[3] <= 0;
	    end
end
end
end
end
assign accountfound=Acc_valid;
assign pinfound=Pin_valid;
endmodule	 


