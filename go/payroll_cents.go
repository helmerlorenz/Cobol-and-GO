// Supplement: exact money in Go using integer centavos (Go 1.22)
package main

import "fmt"

func main() {
	const rateCents int64 = 1550 // 15.50 stored as 1550 centavos
	var hours int64 = 45
	regular, overtime := hours, int64(0)
	if hours > 40 {
		regular, overtime = 40, hours-40
	}
	gross := regular*rateCents + overtime*rateCents*3/2 // 1.5x overtime, integer math
	fmt.Printf("Gross pay: %d.%02d\n", gross/100, gross%100)
}
