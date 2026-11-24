// Program 1: Gross pay with overtime and floating-point demonstration (Go 1.22).

package main // Declares this file as the executable main package.

import "fmt" // Imports formatting and console output functions.

func main() { // Starts the main function.
	hoursWorked := 45                   // Infers an integer for the worked-hours value.
	hourlyRate := 15.50                 // Infers a float64 for the hourly rate.
	regular, overtime := hoursWorked, 0 // Initializes regular hours and overtime hours together.

	if hoursWorked > 40 { // Checks whether worked hours exceed 40.
		regular, overtime = 40, hoursWorked-40 // Sets 40 regular hours and calculates overtime hours.
	} // Ends the overtime split conditional.

	grossPay := float64(regular)*hourlyRate + float64(overtime)*hourlyRate*1.5 // Calculates regular and overtime gross pay.
	fmt.Printf("Gross pay: %.2f\n", grossPay)                                  // Prints the formatted gross pay.

	// Adding 0.10 ten times demonstrates binary floating-point representation behavior.
	total := 0.0 // Initializes the floating-point running total.

	for i := 1; i <= 10; i++ { // Loops ten times with a start value, condition, and increment.
		total += 0.10 // Adds 0.10 to the running total.
	} // Ends the ten-step loop.

	fmt.Printf("Ten additions of 0.10: %v\n", total) // Prints the accumulated floating-point total.
	fmt.Printf("Equals 1.00: %t\n", total == 1.00)   // Prints whether the total compares equal to 1.00.
} // Ends the main function.
