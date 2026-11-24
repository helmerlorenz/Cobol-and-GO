      *> Program 1: Gross pay with overtime + exact-decimal demo (GnuCOBOL 3.1.2)
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PAYROLL.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *> PIC 9(3)V99 = 3 integer digits, implied decimal point, 2 decimals.
       01 HOURS-WORKED    PIC 9(3)    VALUE 45.
       01 HOURLY-RATE     PIC 9(3)V99 VALUE 15.50.
       01 REGULAR-HOURS   PIC 9(3).
       01 OVERTIME-HOURS  PIC 9(3).
       01 GROSS-PAY       PIC 9(6)V99.
       01 PAY-OUT         PIC Z(5)9.99.
       01 RUNNING-TOTAL   PIC 9(3)V99 VALUE 0.
       01 TOTAL-OUT       PIC 9.99.
       01 STEP-NO         PIC 99.
       PROCEDURE DIVISION.
           IF HOURS-WORKED > 40
               MOVE 40 TO REGULAR-HOURS
               SUBTRACT 40 FROM HOURS-WORKED GIVING OVERTIME-HOURS
           ELSE
               MOVE HOURS-WORKED TO REGULAR-HOURS
               MOVE 0 TO OVERTIME-HOURS
           END-IF
           COMPUTE GROSS-PAY = REGULAR-HOURS * HOURLY-RATE
               + OVERTIME-HOURS * HOURLY-RATE * 1.5
           MOVE GROSS-PAY TO PAY-OUT
           DISPLAY "Gross pay: " PAY-OUT
      *> Add 0.10 ten times: fixed-point decimal stays exact.
           PERFORM VARYING STEP-NO FROM 1 BY 1 UNTIL STEP-NO > 10
               ADD 0.10 TO RUNNING-TOTAL
           END-PERFORM
           MOVE RUNNING-TOTAL TO TOTAL-OUT
           DISPLAY "Ten additions of 0.10: " TOTAL-OUT
           IF RUNNING-TOTAL = 1.00
               DISPLAY "Equals 1.00: TRUE"
           ELSE
               DISPLAY "Equals 1.00: FALSE"
           END-IF
           STOP RUN.
