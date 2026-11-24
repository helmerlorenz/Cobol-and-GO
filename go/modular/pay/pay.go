// Package pay groups payroll rules. Exported names start with a capital letter.
package pay

// Employee has one exported field and one unexported (private) field.
type Employee struct {
	Name   string
	salary float64 // lowercase: invisible outside package pay
}

func NewEmployee(name string, salary float64) Employee {
	return Employee{Name: name, salary: salary}
}

// Gross is exported (capital G); methods attach behavior to the struct.
func (e Employee) Gross(hours int, rate float64) float64 {
	return float64(hours) * rate
}
