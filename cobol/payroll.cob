      *> Program 1: Gross pay with overtime and exact-decimal demonstration (GnuCOBOL 3.1.2).

       IDENTIFICATION DIVISION.                                                *> Marks the beginning of the program identification section.
       PROGRAM-ID. PAYROLL.                                                    *> Names this COBOL program PAYROLL.

       DATA DIVISION.                                                          *> Begins the declaration section for program data.
       WORKING-STORAGE SECTION.                                                *> Defines variables that remain allocated during execution.

      *> PIC 9(3)V99 has three integer digits, an implied decimal point, and two decimal digits.
       01 HOURS-WORKED    PIC 9(3)    VALUE 45.                                *> Stores 45 worked hours initially.
       01 HOURLY-RATE     PIC 9(3)V99 VALUE 15.50.                             *> Stores the hourly rate as 15.50.
       01 REGULAR-HOURS   PIC 9(3).                                            *> Stores hours paid at the regular rate.
       01 OVERTIME-HOURS  PIC 9(3).                                            *> Stores hours paid at the overtime rate.
       01 GROSS-PAY       PIC 9(6)V99.                                         *> Stores the calculated gross pay.
       01 PAY-OUT         PIC Z(5)9.99.                                        *> Provides formatted output for gross pay.
       01 RUNNING-TOTAL   PIC 9(3)V99 VALUE 0.                                 *> Accumulates exact decimal additions starting at zero.
       01 TOTAL-OUT       PIC 9.99.                                            *> Provides formatted output for the running total.
       01 STEP-NO         PIC 99.                                              *> Stores the loop step number for ten additions.

       PROCEDURE DIVISION.                                                     *> Begins the executable statements of the program.

           IF HOURS-WORKED > 40                                                *> Checks whether the employee worked overtime.
               MOVE 40 TO REGULAR-HOURS                                        *> Assigns 40 hours as regular hours.
               SUBTRACT 40 FROM HOURS-WORKED GIVING OVERTIME-HOURS             *> Calculates the hours beyond 40.
           ELSE                                                                *> Executes when no overtime was worked.
               MOVE HOURS-WORKED TO REGULAR-HOURS                              *> Uses all worked hours as regular hours.
               MOVE 0 TO OVERTIME-HOURS                                        *> Leaves overtime hours at zero.
           END-IF                                                              *> Ends the overtime split conditional.

           COMPUTE GROSS-PAY = REGULAR-HOURS * HOURLY-RATE                     *> Starts gross pay with regular-hour wages.
               + OVERTIME-HOURS * HOURLY-RATE * 1.5                            *> Adds overtime wages at 1.5 times the hourly rate.
           MOVE GROSS-PAY TO PAY-OUT                                           *> Copies gross pay into the formatted display field.
           DISPLAY "Gross pay: " PAY-OUT                                       *> Prints the gross pay label and amount.

      *> Adding 0.10 ten times demonstrates that fixed-point decimal arithmetic stays exact.
           PERFORM VARYING STEP-NO FROM 1 BY 1 UNTIL STEP-NO > 10              *> Repeats the addition ten times.
               ADD 0.10 TO RUNNING-TOTAL                                       *> Adds exactly 0.10 to the running total.
           END-PERFORM                                                         *> Ends the ten-step loop.

           MOVE RUNNING-TOTAL TO TOTAL-OUT                                     *> Copies the accumulated total into the output field.
           DISPLAY "Ten additions of 0.10: " TOTAL-OUT                         *> Prints the accumulated decimal total.

           IF RUNNING-TOTAL = 1.00                                             *> Checks whether the exact running total equals 1.00.
               DISPLAY "Equals 1.00: TRUE"                                     *> Prints true when the equality check succeeds.
           ELSE                                                                *> Executes when the equality check fails.
               DISPLAY "Equals 1.00: FALSE"                                    *> Prints false when the equality check fails.
           END-IF                                                              *> Ends the equality conditional.

           STOP RUN.                                                           *> Stops the COBOL program.
