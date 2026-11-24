// Program 2: Employee records, loop, total, condition (Go 1.22)
package main

import "fmt"

type Name struct { // a struct groups named, typed fields
	First, Last string
}

type Employee struct {
	ID     int
	Name   Name // nested struct, like a COBOL group item
	Salary float64
}

func main() {
	staff := []Employee{ // slice of structs
		{101, Name{"Ana", "Reyes"}, 620.00},
		{102, Name{"Ben", "Cruz"}, 580.50},
		{103, Name{"Cora", "Dela"}, 710.25},
	}
	total, high := 0.0, 0
	for _, e := range staff { // range iterates over the collection
		fmt.Printf("%d %s %s %9.2f\n", e.ID, e.Name.First, e.Name.Last, e.Salary)
		total += e.Salary
		if e.Salary > 600.00 {
			high++
		}
	}
	fmt.Printf("Total payroll: %.2f\n", total)
	fmt.Printf("Salaries above 600.00: %d\n", high)
}
