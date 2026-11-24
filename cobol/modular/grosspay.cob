      *> Supplement (Unit 6): Separately compiled subprogram (GnuCOBOL 3.1.2).

       IDENTIFICATION DIVISION.                                                *> Marks the beginning of the program identification section.
       PROGRAM-ID. GROSSPAY.                                                   *> Names this COBOL subprogram GROSSPAY.

       DATA DIVISION.                                                          *> Begins the data declaration section.
       LINKAGE SECTION.                                                        *> Defines fields passed by the calling program.

       01 L-HOURS  PIC 9(3).                                                   *> Defines a three-digit hours parameter.
       01 L-RATE   PIC 9(3)V99.                                                *> Defines a rate parameter with two decimal places.
       01 L-GROSS  PIC 9(6)V99.                                                *> Defines the gross-pay result parameter.

       PROCEDURE DIVISION USING L-HOURS L-RATE L-GROSS.                        *> Begins execution and declares the passed parameters.
           COMPUTE L-GROSS = L-HOURS * L-RATE                                  *> Calculates gross pay and stores it in the result parameter.
           GOBACK.                                                             *> Returns control to the calling COBOL program.
