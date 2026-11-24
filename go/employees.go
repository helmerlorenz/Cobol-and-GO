// Program 2: Employee records, loop, total, and condition (Go 1.22).

package main // Declares this file as the executable main package.

import "fmt" // Imports formatting and console output functions.

// Name groups first and last name fields under a named type.
type Name struct { // Begins the Name struct definition.
	First, Last string // Defines the first and last name fields as strings.
} // Ends the Name struct definition.

// Employee combines an employee ID, name, and salary.
type Employee struct { // Begins the Employee struct definition.
	ID     int     // Defines the employee ID as an integer.
	Name   Name    // Stores the employee name in a nested Name struct.
	Salary float64 // Stores the employee salary as a floating-point value.
} // Ends the Employee struct definition.

func main() { // Starts the main function of the program.
	staff := []Employee{ // Creates a slice populated with employee records.
		{101, Name{"Ana", "Reyes"}, 620.00}, // Defines employee 101, Ana Reyes, with salary 620.00.
		{102, Name{"Ben", "Cruz"}, 580.50},  // Defines employee 102, Ben Cruz, with salary 580.50.
		{103, Name{"Cora", "Dela"}, 710.25}, // Defines employee 103, Cora Dela, with salary 710.25.
	} // Ends the employee slice literal.

	total, high := 0.0, 0 // Initializes the payroll total and high-salary count.

	for _, e := range staff { // Iterates once for each employee in the slice.
		fmt.Printf("%d %s %s %9.2f\n", e.ID, e.Name.First, e.Name.Last, e.Salary) // Prints the employee ID, name, and salary.
		total += e.Salary                                                         // Adds the current employee salary to the payroll total.

		if e.Salary > 600.00 { // Checks whether the employee salary exceeds 600.00.
			high++ // Increments the count of qualifying salaries.
		} // Ends the salary threshold conditional.
	} // Ends the employee iteration loop.

	fmt.Printf("Total payroll: %.2f\n", total)      // Prints the formatted payroll total.
	fmt.Printf("Salaries above 600.00: %d\n", high) // Prints the number of salaries above 600.00.
} // Ends the main function.
