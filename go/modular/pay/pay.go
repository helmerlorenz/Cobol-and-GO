// Package pay groups payroll rules. Exported names start with a capital letter.

package pay                                                                    // Declares the payroll package.

// Employee has one exported field and one unexported private field.
type Employee struct {                                                         // Begins the Employee struct definition.
	Name   string                                                                 // Defines the exported employee name field.
	salary float64                                                                // Defines the unexported employee salary field.
}                                                                              // Ends the Employee struct definition.

func NewEmployee(name string, salary float64) Employee {                       // Starts the exported employee constructor.
	return Employee{Name: name, salary: salary}                                   // Builds and returns an Employee value.
}                                                                              // Ends the NewEmployee function.

// Gross is exported; it is a method attached to Employee.
func (e Employee) Gross(hours int, rate float64) float64 {                     // Starts the exported gross-pay method.
	return float64(hours) * rate                                                  // Calculates gross pay from hours and the hourly rate.
}                                                                              // Ends the Gross method.
