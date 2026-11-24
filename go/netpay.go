// Program 3: Function with validation and error return (Go 1.22).

package main // Declares this file as the executable main package.

import ( // Begins the grouped import declaration.
	"errors" // Imports errors for creating a named validation error.
	"fmt"    // Imports formatting and console output functions.
) // Ends the grouped import declaration.

var ErrTooManyHours = errors.New("over 168") // Creates an error returned when hours exceed 168.

// netPay accepts hours and an hourly rate and returns net pay with an optional error.
func netPay(hours int, rate float64) (float64, error) { // Starts the net-pay function and declares two return values.
	if hours > 168 { // Checks whether the input exceeds the maximum allowed hours.
		return 0, ErrTooManyHours // Returns zero pay and the excessive-hours error.
	} // Ends the hours validation conditional.

	gross := float64(hours) * rate // Calculates gross pay from hours and the hourly rate.
	tax := gross * 0.12            // Calculates tax as 12 percent of gross pay.
	return gross - tax, nil        // Returns net pay and a nil error.
} // Ends the netPay function.

func main() { // Starts the main function.
	for _, h := range []int{45, 200, 38} { // Iterates over the three sample hour values.
		net, err := netPay(h, 15.50) // Calculates net pay and receives a possible error.

		if err != nil { // Checks explicitly whether validation or calculation returned an error.
			fmt.Printf("Hours %d: rejected (%v)\n", h, err) // Prints the rejected hours and error.
			continue                                        // Skips the remaining statements for this iteration.
		} // Ends the error-handling conditional.

		fmt.Printf("Hours %d: net pay %.2f\n", h, net) // Prints the valid hours and formatted net pay.
	} // Ends the sample-hours loop.
} // Ends the main function.
