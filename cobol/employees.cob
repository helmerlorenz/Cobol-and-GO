      *> Program 2: Employee records, loop, total, and condition (GnuCOBOL 3.1.2).

       IDENTIFICATION DIVISION.                                                *> Marks the beginning of the program identification section.
       PROGRAM-ID. EMPLOYEES.                                                  *> Names this COBOL program EMPLOYEES.

       DATA DIVISION.                                                          *> Begins the section that declares program data.
       WORKING-STORAGE SECTION.                                                *> Defines data storage that remains allocated during execution.

      *> The EMPLOYEE-TABLE group item contains a repeating employee record.
       01 EMPLOYEE-TABLE.                                                       *> Creates the top-level employee table group item.
          05 EMPLOYEE-RECORD OCCURS 3 TIMES.                                   *> Allows three employee-record entries in the table.
             10 EMP-ID     PIC 9(5).                                            *> Defines each employee ID as five numeric digits.
             10 EMP-NAME.                                                       *> Creates a group field for the employee names.
                15 FIRST-NAME PIC X(10).                                         *> Defines the first name as up to ten characters.
                15 LAST-NAME  PIC X(10).                                         *> Defines the last name as up to ten characters.
             10 EMP-SALARY PIC 9(6)V99.                                         *> Defines salary with six integer and two decimal digits.

       01 IDX           PIC 9.                                                 *> Defines an integer loop index for table positions.
       01 TOTAL-SALARY  PIC 9(7)V99 VALUE 0.                                   *> Stores the combined payroll and initializes it to zero.
       01 HIGH-COUNT    PIC 9 VALUE 0.                                         *> Counts salaries above 600.00 and starts at zero.
       01 SALARY-OUT    PIC Z(5)9.99.                                          *> Formats one employee salary for display.
       01 TOTAL-OUT     PIC Z(6)9.99.                                          *> Formats the total payroll for display.

       PROCEDURE DIVISION.                                                     *> Begins the executable instructions of the program.
           MOVE 101 TO EMP-ID(1)                                                *> Sets the first employee ID to 101.
           MOVE "Ana"   TO FIRST-NAME(1)                                        *> Sets the first employee first name to Ana.
           MOVE "Reyes" TO LAST-NAME(1)                                         *> Sets the first employee last name to Reyes.
           MOVE 620.00  TO EMP-SALARY(1)                                        *> Assigns 620.00 to the first employee salary.
           MOVE 102 TO EMP-ID(2)                                                *> Sets the second employee ID to 102.
           MOVE "Ben"   TO FIRST-NAME(2)                                        *> Sets the second employee first name to Ben.
           MOVE "Cruz"  TO LAST-NAME(2)                                         *> Sets the second employee last name to Cruz.
           MOVE 580.50  TO EMP-SALARY(2)                                        *> Assigns 580.50 to the second employee salary.
           MOVE 103 TO EMP-ID(3)                                                *> Sets the third employee ID to 103.
           MOVE "Cora"  TO FIRST-NAME(3)                                        *> Sets the third employee first name to Cora.
           MOVE "Dela"  TO LAST-NAME(3)                                         *> Sets the third employee last name to Dela.
           MOVE 710.25  TO EMP-SALARY(3)                                        *> Assigns 710.25 to the third employee salary.

           PERFORM VARYING IDX FROM 1 BY 1 UNTIL IDX > 3                       *> Loops through employee indexes from 1 through 3.
               MOVE EMP-SALARY(IDX) TO SALARY-OUT                               *> Copies the current salary into its display-format field.
               DISPLAY EMP-ID(IDX) " " FIRST-NAME(IDX) " "                      *> Begins the employee display with ID and first name.
                       LAST-NAME(IDX) " " SALARY-OUT                             *> Continues with last name and formatted salary.
               ADD EMP-SALARY(IDX) TO TOTAL-SALARY                              *> Adds the current salary to the payroll total.
               IF EMP-SALARY(IDX) > 600.00                                     *> Checks whether the current salary exceeds 600.00.
                   ADD 1 TO HIGH-COUNT                                          *> Increases the count of high salaries by one.
               END-IF                                                           *> Ends the salary threshold conditional.
           END-PERFORM                                                          *> Ends the employee table loop.

           MOVE TOTAL-SALARY TO TOTAL-OUT                                       *> Copies the payroll total into its display-format field.
           DISPLAY "Total payroll: " TOTAL-OUT                                  *> Prints the total payroll label and formatted amount.
           DISPLAY "Salaries above 600.00: " HIGH-COUNT                         *> Prints the label and count of qualifying salaries.
           STOP RUN.                                                            *> Stops the COBOL program and returns control.
