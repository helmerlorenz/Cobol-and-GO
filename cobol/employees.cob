      *> Program 2: Employee records, loop, total, condition (GnuCOBOL 3.1.2)
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EMPLOYEES.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *> A group item (record) nested inside a table of 3 entries.
       01 EMPLOYEE-TABLE.
          05 EMPLOYEE-RECORD OCCURS 3 TIMES.
             10 EMP-ID     PIC 9(5).
             10 EMP-NAME.
                15 FIRST-NAME PIC X(10).
                15 LAST-NAME  PIC X(10).
             10 EMP-SALARY PIC 9(6)V99.
       01 IDX           PIC 9.
       01 TOTAL-SALARY  PIC 9(7)V99 VALUE 0.
       01 HIGH-COUNT    PIC 9 VALUE 0.
       01 SALARY-OUT    PIC Z(5)9.99.
       01 TOTAL-OUT     PIC Z(6)9.99.
       PROCEDURE DIVISION.
           MOVE 101 TO EMP-ID(1)
           MOVE "Ana"   TO FIRST-NAME(1)
           MOVE "Reyes" TO LAST-NAME(1)
           MOVE 620.00  TO EMP-SALARY(1)
           MOVE 102 TO EMP-ID(2)
           MOVE "Ben"   TO FIRST-NAME(2)
           MOVE "Cruz"  TO LAST-NAME(2)
           MOVE 580.50  TO EMP-SALARY(2)
           MOVE 103 TO EMP-ID(3)
           MOVE "Cora"  TO FIRST-NAME(3)
           MOVE "Dela"  TO LAST-NAME(3)
           MOVE 710.25  TO EMP-SALARY(3)
           PERFORM VARYING IDX FROM 1 BY 1 UNTIL IDX > 3
               MOVE EMP-SALARY(IDX) TO SALARY-OUT
               DISPLAY EMP-ID(IDX) " " FIRST-NAME(IDX) " "
                       LAST-NAME(IDX) " " SALARY-OUT
               ADD EMP-SALARY(IDX) TO TOTAL-SALARY
               IF EMP-SALARY(IDX) > 600.00
                   ADD 1 TO HIGH-COUNT
               END-IF
           END-PERFORM
           MOVE TOTAL-SALARY TO TOTAL-OUT
           DISPLAY "Total payroll: " TOTAL-OUT
           DISPLAY "Salaries above 600.00: " HIGH-COUNT
           STOP RUN.
