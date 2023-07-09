module ATM_Controller_TB;
  reg clk;
  reg reset;
  reg cardInserted;
  reg cardScanned;
  reg modeSelected;
  reg amountConfirmed;
  reg faceRecognition;
  reg mobileOTP;
  reg transactionCompleted;
  
  wire dispenseCash;
  wire depositCash;
  wire printReceipt;
  wire captureFace;
  wire promptOTP;
  wire [7:0] displayMessage;
  
  // Instantiate the DUT
  ATM_Controller dut (
    .clk(clk),
    .reset(reset),
    .cardInserted(cardInserted),
    .cardScanned(cardScanned),
    .modeSelected(modeSelected),
    .amountConfirmed(amountConfirmed),
    .faceRecognition(faceRecognition),
    .mobileOTP(mobileOTP),
    .transactionCompleted(transactionCompleted),
    .dispenseCash(dispenseCash),
    .depositCash(depositCash),
    .printReceipt(printReceipt),
    .captureFace(captureFace),
    .promptOTP(promptOTP),
    .displayMessage(displayMessage)
  );
  
  // Clock generation
  always #5 clk = ~clk;
  
  // Test case initialization
  initial begin
    clk = 0;
    reset = 1;
    cardInserted = 0;
    cardScanned = 0;
    modeSelected = 0;
    amountConfirmed = 0;
    faceRecognition = 0;
    mobileOTP = 0;
    transactionCompleted = 0;
    
    // Reset the ATM
    #10 reset = 0;
    
    // Insert card
    #20 cardInserted = 1;
    
    // Scan card
    #30 cardScanned = 1;
    
    // Select mode
    #40 modeSelected = 1;
    
    // Confirm amount
    #50 amountConfirmed = 1;
    
    // Perform face recognition
    #60 faceRecognition = 1;
    
    // Perform mobile OTP
    #70 mobileOTP = 1;
    
    // Complete transaction
    #80 transactionCompleted = 1;
    
    // Wait for transaction completion and display output
    #90;
    $display("Display Message: %b", displayMessage);
    $display("Dispense Cash: %b", dispenseCash);
    $display("Deposit Cash: %b", depositCash);
    $display("Print Receipt: %b", printReceipt);
    $display("Capture Face: %b", captureFace);
    $display("Prompt OTP: %b", promptOTP);
    
    // Finish simulation
    #10 $finish;
  end
endmodule
