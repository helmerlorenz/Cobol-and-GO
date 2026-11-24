// Program 3: Function with validation and error return (Go 1.22)
package main

import (
	"errors"
	"fmt"
)

var ErrTooManyHours = errors.New("over 168")

// netPay takes parameters and returns TWO values: result and error.
func netPay(hours int, rate float64) (float64, error) {
	if hours > 168 {
		return 0, ErrTooManyHours
	}
	gross := float64(hours) * rate
	tax := gross * 0.12
	return gross - tax, nil
}

func main() {
	for _, h := range []int{45, 200, 38} {
		net, err := netPay(h, 15.50)
		if err != nil { // explicit error check replaces the status flag
			fmt.Printf("Hours %d: rejected (%v)\n", h, err)
			continue
		}
		fmt.Printf("Hours %d: net pay %.2f\n", h, net)
	}
}
