      *> Program 3: Subprogram-style paragraph with validation (GnuCOBOL 3.1.2)
       IDENTIFICATION DIVISION.
       PROGRAM-ID. NETPAY.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 HOURS-TABLE.
          05 HOURS-ENTRY PIC 9(3) OCCURS 3 TIMES.
       01 IDX          PIC 9.
       01 WS-HOURS     PIC 9(3).
       01 WS-RATE      PIC 9(3)V99 VALUE 15.50.
       01 WS-GROSS     PIC 9(6)V99.
       01 WS-TAX       PIC 9(6)V99.
       01 WS-NET       PIC 9(6)V99.
       01 NET-OUT      PIC Z(5)9.99.
       01 WS-ERROR     PIC X VALUE "N".
          88 INPUT-OK    VALUE "N".
          88 INPUT-BAD   VALUE "Y".
       PROCEDURE DIVISION.
       MAIN-PARA.
           MOVE 45  TO HOURS-ENTRY(1)
           MOVE 200 TO HOURS-ENTRY(2)
           MOVE 38  TO HOURS-ENTRY(3)
           PERFORM VARYING IDX FROM 1 BY 1 UNTIL IDX > 3
               MOVE HOURS-ENTRY(IDX) TO WS-HOURS
               PERFORM CALC-NET-PAY
               IF INPUT-BAD
                   DISPLAY "Hours " WS-HOURS ": rejected (over 168)"
               ELSE
                   MOVE WS-NET TO NET-OUT
                   DISPLAY "Hours " WS-HOURS ": net pay " NET-OUT
               END-IF
           END-PERFORM
           STOP RUN.
      *> A paragraph is invoked with PERFORM; it shares global storage.
       CALC-NET-PAY.
           SET INPUT-OK TO TRUE
           IF WS-HOURS > 168
               SET INPUT-BAD TO TRUE
           ELSE
               COMPUTE WS-GROSS ROUNDED = WS-HOURS * WS-RATE
               COMPUTE WS-TAX ROUNDED = WS-GROSS * 0.12
               SUBTRACT WS-TAX FROM WS-GROSS GIVING WS-NET
           END-IF.
