// Modular employee-pay demonstration (Go 1.22).

package main // Declares this file as the executable main package.

import ( // Begins the grouped import declaration.
	"fmt" // Imports formatting and console output functions.

	"example.com/payroll/pay" // Imports the local payroll package.
) // Ends the grouped import declaration.

func main() { // Starts the main function.
	e := pay.NewEmployee("Ana Reyes", 620.00)                      // Creates an employee through the exported constructor.
	fmt.Printf("%s gross pay: %.2f\n", e.Name, e.Gross(38, 15.50)) // Prints the employee name and calculated gross pay.
	// fmt.Println(e.salary) would NOT compile: salary is unexported. // Documents that private package fields cannot be accessed here.
} // Ends the main function.
