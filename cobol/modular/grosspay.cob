      *> Supplement (Unit 6): separately compiled subprogram (GnuCOBOL 3.1.2)
       IDENTIFICATION DIVISION.
       PROGRAM-ID. GROSSPAY.
       DATA DIVISION.
       LINKAGE SECTION.
       01 L-HOURS  PIC 9(3).
       01 L-RATE   PIC 9(3)V99.
       01 L-GROSS  PIC 9(6)V99.
       PROCEDURE DIVISION USING L-HOURS L-RATE L-GROSS.
           COMPUTE L-GROSS = L-HOURS * L-RATE
           GOBACK.
