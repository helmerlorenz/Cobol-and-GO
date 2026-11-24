package main

import (
	"fmt"

	"example.com/payroll/pay"
)

func main() {
	e := pay.NewEmployee("Ana Reyes", 620.00)
	fmt.Printf("%s gross pay: %.2f\n", e.Name, e.Gross(38, 15.50))
	// fmt.Println(e.salary) would NOT compile: salary is unexported.
}
