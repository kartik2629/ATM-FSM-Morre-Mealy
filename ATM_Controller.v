module ATM_Controller (
  input wire clk,
  input wire reset,
  input wire cardInserted,
  input wire cardScanned,
  input wire modeSelected,
  input wire amountConfirmed,
  input wire faceRecognition,
  input wire mobileOTP,
  input wire transactionCompleted,
  
  output wire dispenseCash,
  output wire depositCash,
  output wire printReceipt,
  output wire captureFace,
  output wire promptOTP,
  output wire [7:0] displayMessage
);
  // Define the states
  typedef enum logic [3:0] {
    IDLE,
    CARD_INSERTED,
    CARD_SCANNED,
    MODE_SELECTION,
    AMOUNT_CONFIRMATION,
    FACE_RECOGNITION,
    MOBILE_OTP,
    TRANSACTION_PROCESSING,
    TRANSACTION_COMPLETED
  } state_type;
  
  // Define the state register and next state logic
  reg [3:0] state_reg, state_next;
  
  // Define output registers
  reg dispenseCash_reg, depositCash_reg, printReceipt_reg, captureFace_reg, promptOTP_reg;
  reg [7:0] displayMessage_reg;
  
  // Define internal signals
  reg [2:0] invalidPINAttempts_reg;
  reg accountLocked;
  
  // Initialize state and outputs
  initial begin
    state_reg = IDLE;
    dispenseCash_reg = 0;
    depositCash_reg = 0;
    printReceipt_reg = 0;
    captureFace_reg = 0;
    promptOTP_reg = 0;
    displayMessage_reg = 8'b00000000;
    invalidPINAttempts_reg = 3'b0;
    accountLocked = 0;
  end
  
  // State transition and output logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state_reg <= IDLE;
      dispenseCash_reg <= 0;
      depositCash_reg <= 0;
      printReceipt_reg <= 0;
      captureFace_reg <= 0;
      promptOTP_reg <= 0;
      displayMessage_reg <= 8'b00000000;
      invalidPINAttempts_reg <= 3'b0;
      accountLocked <= 0;
    end else begin
      state_reg <= state_next;
      dispenseCash_reg <= 0;
      depositCash_reg <= 0;
      printReceipt_reg <= 0;
      captureFace_reg <= 0;
      promptOTP_reg <= 0;
      displayMessage_reg <= 8'b00000000;
      invalidPINAttempts_reg <= invalidPINAttempts_reg;
      accountLocked <= accountLocked;
      
      // State transition logic
      case (state_reg)
        IDLE:
          if (cardInserted) state_next = CARD_INSERTED;
          else state_next = IDLE;
        
        CARD_INSERTED:
          if (cardScanned) state_next = CARD_SCANNED;
          else state_next = CARD_INSERTED;
        
        CARD_SCANNED:
          if (modeSelected) state_next = MODE_SELECTION;
          else state_next = CARD_SCANNED;
        
        MODE_SELECTION:
          if (amountConfirmed) begin
            if (amountConfirmed > 10000) state_next = FACE_RECOGNITION;
            else state_next = TRANSACTION_PROCESSING;
          end else state_next = MODE_SELECTION;
        
        AMOUNT_CONFIRMATION:
          if (faceRecognition) state_next = MOBILE_OTP;
          else state_next = AMOUNT_CONFIRMATION;
        
        FACE_RECOGNITION:
          if (mobileOTP) state_next = MOBILE_OTP;
          else state_next = FACE_RECOGNITION;
        
        MOBILE_OTP:
          if (transactionCompleted) state_next = TRANSACTION_PROCESSING;
          else state_next = MOBILE_OTP;
        
        TRANSACTION_PROCESSING:
          state_next = TRANSACTION_COMPLETED;
        
        TRANSACTION_COMPLETED:
          state_next = IDLE;
      endcase
      
      // Output logic
      case (state_reg)
        IDLE:
          displayMessage_reg = 8'b00000001; // Prompt for card insertion
          invalidPINAttempts_reg = 3'b0; // Reset invalid PIN attempts counter
          accountLocked = 0; // Account not locked
        
        CARD_INSERTED:
          displayMessage_reg = 8'b00000010; // Prompt for card scanning
          invalidPINAttempts_reg = 3'b0; // Reset invalid PIN attempts counter
          accountLocked = 0; // Account not locked
        
        CARD_SCANNED:
          displayMessage_reg = 8'b00000100; // Prompt for mode selection
          invalidPINAttempts_reg = 3'b0; // Reset invalid PIN attempts counter
          accountLocked = 0; // Account not locked
        
        MODE_SELECTION:
          displayMessage_reg = 8'b00001000; // Prompt for amount confirmation
          invalidPINAttempts_reg = 3'b0; // Reset invalid PIN attempts counter
          accountLocked = 0; // Account not locked
        
        AMOUNT_CONFIRMATION:
          if (amountConfirmed > 10000) begin
            displayMessage_reg = 8'b00010000; // Prompt for face recognition
            captureFace_reg = 1; // Initiate face recognition process
            promptOTP_reg = 0; // Clear mobile OTP prompt
          end else begin
            displayMessage_reg = 8'b00010000; // Prompt for mobile OTP
            captureFace_reg = 0; // Clear face recognition prompt
            promptOTP_reg = 1; // Prompt for mobile OTP
          end
          invalidPINAttempts_reg = 3'b0; // Reset invalid PIN attempts counter
          accountLocked = 0; // Account not locked
        
        FACE_RECOGNITION:
          displayMessage_reg = 8'b00010000; // Prompt for mobile OTP
          captureFace_reg = 0; // Clear face recognition prompt
          promptOTP_reg = 1; // Prompt for mobile OTP
          invalidPINAttempts_reg = 3'b0; // Reset invalid PIN attempts counter
          accountLocked = 0; // Account not locked
        
        MOBILE_OTP:
          displayMessage_reg = 8'b00100000; // Prompt for transaction processing
          captureFace_reg = 0; // Clear face recognition prompt
          promptOTP_reg = 0; // Clear mobile OTP prompt
          invalidPINAttempts_reg = 3'b0; // Reset invalid PIN attempts counter
          accountLocked = 0; // Account not locked
        
        TRANSACTION_PROCESSING:
          displayMessage_reg = 8'b01000000; // Transaction in progress
          dispenseCash_reg = 1; // Dispense cash (for withdrawal)
          depositCash_reg = 1; // Accept cash (for deposit)
          printReceipt_reg = 1; // Print acknowledgment receipt
          invalidPINAttempts_reg = 3'b0; // Reset invalid PIN attempts counter
          accountLocked = 0; // Account not locked
        
        TRANSACTION_COMPLETED:
          displayMessage_reg = 8'b10000000; // Transaction completed
          dispenseCash_reg = 0; // Clear cash dispensing signal
          depositCash_reg = 0; // Clear cash accepting signal
          printReceipt_reg = 0; // Clear receipt printing signal          invalidPINAttempts_reg = 3'b0; // Reset invalid PIN attempts counter
          accountLocked = 0; // Account not locked
      endcase
    end
  end
  
  // Assign outputs
  assign dispenseCash = dispenseCash_reg;
  assign depositCash = depositCash_reg;
  assign printReceipt = printReceipt_reg;
  assign captureFace = captureFace_reg;
  assign promptOTP = promptOTP_reg;
  assign displayMessage = displayMessage_reg;
endmodule
