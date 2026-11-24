      *> Supplement (Unit 6): Main program that calls GROSSPAY.

       IDENTIFICATION DIVISION.                                                *> Marks the beginning of the program identification section.
       PROGRAM-ID. MODMAIN.                                                    *> Names this COBOL program MODMAIN.

       DATA DIVISION.                                                          *> Begins the data declaration section.
       WORKING-STORAGE SECTION.                                                *> Defines variables allocated during program execution.

       01 WS-HOURS  PIC 9(3)    VALUE 38.                                      *> Stores 38 worked hours.
       01 WS-RATE   PIC 9(3)V99 VALUE 15.50.                                   *> Stores the hourly rate as 15.50.
       01 WS-GROSS  PIC 9(6)V99.                                               *> Stores the gross pay returned by GROSSPAY.
       01 GROSS-OUT PIC Z(5)9.99.                                              *> Provides a formatted field for gross-pay display.

       PROCEDURE DIVISION.                                                     *> Begins the executable statements.
           CALL "GROSSPAY" USING WS-HOURS WS-RATE WS-GROSS                     *> Calls GROSSPAY and passes hours, rate, and result fields.
           MOVE WS-GROSS TO GROSS-OUT                                          *> Copies gross pay into the formatted output field.
           DISPLAY "Gross pay: " GROSS-OUT                                     *> Prints the gross-pay label and amount.
           STOP RUN.                                                           *> Stops the COBOL program.
