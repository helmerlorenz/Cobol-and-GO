// Supplement: Exact money in Go using integer centavos (Go 1.22).

package main // Declares this file as the executable main package.

import "fmt" // Imports formatting and console output functions.

func main() { // Starts the main function.
	const rateCents int64 = 1550 // Stores the 15.50 hourly rate as 1550 cents.

	var hours int64 = 45                 // Stores the worked hours as an explicit 64-bit integer.
	regular, overtime := hours, int64(0) // Initializes regular hours and starts overtime at zero.

	if hours > 40 { // Checks whether the worked hours exceed the regular limit.
		regular, overtime = 40, hours-40 // Sets 40 regular hours and calculates the overtime remainder.
	} // Ends the overtime split conditional.

	gross := regular*rateCents + overtime*rateCents*3/2      // Calculates gross pay entirely with integer cents and 1.5x overtime.
	fmt.Printf("Gross pay: %d.%02d\n", gross/100, gross%100) // Prints gross pay as whole dollars and two-digit cents.
} // Ends the main function.
