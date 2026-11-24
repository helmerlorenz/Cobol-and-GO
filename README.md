# COBOL vs Go Companion Programs (CCS 239)

Companion code for the term paper **COBOL (1959) vs Go (2009): Business back-end systems**.
Authors: Helmer Lorenz Andalajao, Aurelio Sua.

Three identical problems are solved in both languages (six required programs), plus two
supplements used in the paper (integer-centavo money in Go, and a two-file modularity demo
in both languages).

## Repository layout

```
cobol/
  payroll.cob          Problem 1
  employees.cob        Problem 2
  netpay.cob           Problem 3
  modular/
    grosspay.cob       Supplement: subprogram (Unit 6)
    modmain.cob        Supplement: caller (Unit 6)
go/
  payroll.go           Problem 1
  employees.go         Problem 2
  netpay.go            Problem 3
  payroll_cents.go     Supplement: exact money with integers
  modular/             Supplement: Go module with package pay (Unit 6)
    go.mod  main.go  pay/pay.go
expected_output/       Output captured from the tested runs
README.md
```

## Tested environment

| Item | Version used for the expected output |
|---|---|
| COBOL compiler | GnuCOBOL (cobc) 3.1.2.0 |
| Go | go1.22.2 linux/amd64 |
| OS | Ubuntu 24 (x86-64) |

If you run on a different machine (for example macOS), record **your own** versions with the
commands below and put them in the paper's Appendix A. Output should be identical; any difference
is worth explaining in the defense.

```bash
cobc --version | head -1
go version
```

## 1. Install the tools

**macOS (Homebrew)**

```bash
brew install gnucobol go
```

**Ubuntu / Debian / WSL**

```bash
sudo apt update
sudo apt install gnucobol golang-go
```

**Windows:** use WSL (Ubuntu) and follow the Ubuntu steps.

## 2. Run the COBOL programs

COBOL source here is **fixed format**: statements begin in column 8, comments use `*>` at column 7.
Compile with `-x` to produce an executable.

```bash
cd cobol
cobc -x -o payroll   payroll.cob   && ./payroll
cobc -x -o employees employees.cob && ./employees
cobc -x -o netpay    netpay.cob    && ./netpay

# Supplement: two source files compiled together
cd modular
cobc -x -o modmain modmain.cob grosspay.cob && ./modmain
```

GnuCOBOL may print `_FORTIFY_SOURCE redefined` warnings on some systems. They are harmless.

## 3. Run the Go programs

The `go/` folder holds several independent `main` programs, so run each **by file name**
(do not use `go build ./...` in that folder).

```bash
cd go
go run payroll.go
go run employees.go
go run netpay.go
go run payroll_cents.go

# Supplement: module with a package
cd modular
go run .
```

## 4. Expected output

| Program | COBOL | Go |
|---|---|---|
| Problem 1 | `Gross pay:    736.25` / `Ten additions of 0.10: 1.00` / `Equals 1.00: TRUE` | `Gross pay: 736.25` / `Ten additions of 0.10: 0.9999999999999999` / `Equals 1.00: false` |
| Problem 2 | three records, `Total payroll:    1910.75`, `Salaries above 600.00: 2` | same values, `Total payroll: 1910.75` |
| Problem 3 | `Hours 045: net pay    613.80`, `Hours 200: rejected (over 168)`, `Hours 038: net pay    518.32` | `Hours 45: net pay 613.80`, `Hours 200: rejected (over 168)`, `Hours 38: net pay 518.32` |
| Supplement (cents) | not applicable | `Gross pay: 736.25` |
| Supplement (modular) | `Gross pay:    589.00` | `Ana Reyes gross pay: 589.00` |

Full captured text is in `expected_output/`. COBOL pads numbers to the width of the picture clause,
so spacing differs from Go; the values must match.

## 5. Problem statements (identical for both languages)

**Problem 1. Gross pay with overtime and an exact-decimal test** (Units 2, 3, 4)
An employee worked 45 hours at 15.50 per hour. Hours above 40 are paid at 1.5 times the rate.
Print the gross pay (expected 736.25). Then add 0.10 to a running total ten times and print the
total and whether it equals 1.00.

**Problem 2. Employee records** (Units 3, 4)
Store three employees (ID, first name, last name, salary), nested name fields included.
Print each record, the total payroll, and how many salaries are above 600.00.

| ID | Name | Salary |
|---|---|---|
| 101 | Ana Reyes | 620.00 |
| 102 | Ben Cruz | 580.50 |
| 103 | Cora Dela | 710.25 |

**Problem 3. Net pay with validation and a reusable routine** (Units 3, 4, 5)
For hours 45, 200, and 38 at 15.50 per hour, compute net pay = gross minus 12 percent tax.
Reject any input over 168 hours (hours in a week) instead of computing it.

## 6. What each program demonstrates (for the paper and the defense)

| Program | Language construct to be able to explain |
|---|---|
| payroll.cob | PIC clauses (`9(3)V99`), `COMPUTE`, edited picture `Z(5)9.99`, exact decimal addition |
| payroll.go | `:=` inference, `float64` conversion, `for` as the only loop, floating-point error |
| employees.cob | Level numbers 01/05/10/15, `OCCURS`, `PERFORM VARYING`, subscripts |
| employees.go | Nested structs, slice of structs, `for ... range`, `%9.2f` formatting |
| netpay.cob | `PERFORM` of a paragraph, level-88 condition names, shared WORKING-STORAGE, `ROUNDED` |
| netpay.go | Multiple return values, `error`, `errors.New`, `if err != nil` |
| payroll_cents.go | Integer centavos as the workaround for the missing decimal type |
| modular/ | COBOL `CALL ... USING` and LINKAGE SECTION; Go package, exported vs unexported names |

## 7. Defense drills (practice changing the code live)

Try each in both languages until you can do it in under two minutes.

1. Change the overtime multiplier to 2.0. (COBOL: `1.5` to `2.0` in the COMPUTE. Go: `1.5` to `2.0`. In `payroll_cents.go`, `*3/2` becomes `*2`.) New gross for 45 hours: 775.00.
2. Add a fourth employee and confirm the total changes. (COBOL: change `OCCURS 3` and the `UNTIL IDX > 3`, then add four MOVEs. Go: add one element to the slice.)
3. Change the tax rate to 10 percent in Problem 3. (Check: 45 hours gross 697.50, tax 69.75, net 627.75.)
4. Change the rejection limit from 168 to 100 hours. Which of the three inputs are now rejected? (Only 200.)
5. In Go, make `salary` in `pay.Employee` exported and use it from `main`. What do you have to change? (Rename the field to `Salary` in the struct and in `NewEmployee`.)
6. Trace Problem 1 by hand for 38 hours: no overtime, so regular = 38, overtime = 0, gross = 589.00.

## 8. Screenshot checklist for Appendix A

Capture a terminal screenshot showing the command **and** its output for each of these runs, with the
version commands visible in at least one:

- [ ] `cobc --version` and `go version`
- [ ] payroll (COBOL) and `go run payroll.go`
- [ ] employees (COBOL) and `go run employees.go`
- [ ] netpay (COBOL) and `go run netpay.go`
- [ ] (optional) the supplements

## 9. Push to the assigned GitHub repository

```bash
git clone <assigned-repo-url>
cd <repo>
# copy cobol/, go/, expected_output/ and this README.md into the repo root
git add .
git commit -m "Add COBOL and Go companion programs with README"
git push
```

Do not commit compiled binaries (`payroll`, `employees`, `netpay`, `modmain`). Add them to `.gitignore`.

## 10. Troubleshooting

| Symptom | Cause and fix |
|---|---|
| COBOL error about an unexpected token at the start of a line | Fixed format: statements must start in column 8 or later; paragraph and division names in column 8. Do not let an editor convert leading spaces to tabs. |
| COBOL program prints nothing or stops early | Make sure `STOP RUN.` is the last statement of the main program and paragraphs follow it. |
| `go run` says `main redeclared` | You ran `go run .` or `go build ./...` in the `go/` folder, which has several `main` programs. Run one file by name. |
| `go: cannot find main module` in `go/modular` | Run the command from inside `go/modular`, where `go.mod` lives. |
| Different spacing in COBOL output | Expected; the edited picture pads to its width. Compare the numbers, not the spaces. |
