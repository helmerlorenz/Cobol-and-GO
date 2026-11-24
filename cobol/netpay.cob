      *> Program 3: Subprogram-style paragraph with validation (GnuCOBOL 3.1.2)

       IDENTIFICATION DIVISION.                                                *> Marks the beginning of the program identification section.
       PROGRAM-ID. NETPAY.                                                     *> Names this COBOL program NETPAY.

       DATA DIVISION.                                                          *> Begins the declaration section for program data.
       WORKING-STORAGE SECTION.                                                *> Defines variables that persist during program execution.

       01 HOURS-TABLE.                                                         *> Creates a group item that stores sample hour values.
          05 HOURS-ENTRY PIC 9(3) OCCURS 3 TIMES.                              *> Defines three three-digit hour table entries.

       01 IDX          PIC 9.                                                  *> Stores the current index used to access the hours table.
       01 WS-HOURS     PIC 9(3).                                               *> Stores the hours value currently being processed.
       01 WS-RATE      PIC 9(3)V99 VALUE 15.50.                                *> Stores the hourly rate and initializes it to 15.50.
       01 WS-GROSS     PIC 9(6)V99.                                            *> Stores the gross pay before tax.
       01 WS-TAX       PIC 9(6)V99.                                            *> Stores the calculated tax amount.
       01 WS-NET       PIC 9(6)V99.                                            *> Stores the net pay after tax.
       01 NET-OUT      PIC Z(5)9.99.                                           *> Provides a formatted field for displaying net pay.

       01 WS-ERROR     PIC X VALUE "N".                                        *> Stores the validation status flag.
          88 INPUT-OK    VALUE "N".                                            *> Marks "N" as the value indicating valid input.
          88 INPUT-BAD   VALUE "Y".                                            *> Marks "Y" as the value indicating invalid input.

       PROCEDURE DIVISION.                                                     *> Begins the executable statements of the program.

       MAIN-PARA.                                                              *> Defines the main paragraph that controls program execution.
           MOVE 45  TO HOURS-ENTRY(1)                                          *> Assigns 45 hours to the first table entry.
           MOVE 200 TO HOURS-ENTRY(2)                                          *> Assigns 200 hours to the second table entry.
           MOVE 38  TO HOURS-ENTRY(3)                                          *> Assigns 38 hours to the third table entry.

           PERFORM VARYING IDX FROM 1 BY 1 UNTIL IDX > 3                       *> Loops through all three hour entries.
               MOVE HOURS-ENTRY(IDX) TO WS-HOURS                               *> Copies the current entry into the working hours field.
               PERFORM CALC-NET-PAY                                            *> Calls the net-pay calculation paragraph.
               IF INPUT-BAD                                                    *> Checks whether the validation paragraph found invalid hours.
                   DISPLAY "Hours " WS-HOURS ": rejected (over 168)"           *> Displays a rejection message.
               ELSE                                                            *> Executes when the hours value passed validation.
                   MOVE WS-NET TO NET-OUT                                      *> Copies net pay into the display-format field.
                   DISPLAY "Hours " WS-HOURS ": net pay " NET-OUT              *> Displays the valid hours and net pay.
               END-IF                                                          *> Ends the validation result conditional.
           END-PERFORM                                                         *> Ends the loop over all hour entries.

           STOP RUN.                                                           *> Stops the COBOL program.

      *> The CALC-NET-PAY paragraph is invoked with PERFORM and shares working-storage fields.
       CALC-NET-PAY.                                                           *> Defines the paragraph that validates and calculates net pay.
           SET INPUT-OK TO TRUE                                                *> Initializes the validation status to valid.
           IF WS-HOURS > 168                                                   *> Checks whether the hours value exceeds the allowed maximum.
               SET INPUT-BAD TO TRUE                                           *> Changes the validation status to invalid.
           ELSE                                                                *> Executes the pay calculation for valid hours.
               COMPUTE WS-GROSS ROUNDED = WS-HOURS * WS-RATE                   *> Calculates rounded gross pay from hours and rate.
               COMPUTE WS-TAX ROUNDED = WS-GROSS * 0.12                        *> Calculates rounded tax as 12 percent of gross pay.
               SUBTRACT WS-TAX FROM WS-GROSS GIVING WS-NET                     *> Subtracts tax from gross pay to obtain net pay.
           END-IF.                                                             *> Ends the hours validation conditional.
