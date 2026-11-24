// Program 1: Gross pay with overtime + floating-point demo (Go 1.22)
package main

import "fmt"

func main() {
	hoursWorked := 45        // int: inferred by :=
	hourlyRate := 15.50      // float64: inferred, binary floating point
	regular, overtime := hoursWorked, 0
	if hoursWorked > 40 {
		regular, overtime = 40, hoursWorked-40
	}
	grossPay := float64(regular)*hourlyRate + float64(overtime)*hourlyRate*1.5
	fmt.Printf("Gross pay: %.2f\n", grossPay)

	// Add 0.10 ten times: binary floating point accumulates representation error.
	total := 0.0
	for i := 1; i <= 10; i++ { // 'for' is Go's only loop keyword
		total += 0.10
	}
	fmt.Printf("Ten additions of 0.10: %v\n", total)
	fmt.Printf("Equals 1.00: %t\n", total == 1.00)
}
