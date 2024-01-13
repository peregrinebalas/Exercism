package booking

import (
	"fmt"
	"time"
)

// Schedule returns a time.Time from a string containing a date.
func Schedule(date string) time.Time {
	return parse("1/2/2006 15:04:05", date)
}

// HasPassed returns whether a date has passed.
func HasPassed(date string) bool {
	t := parse("January 2, 2006 15:04:05", date)
	return time.Now().After(t)
}

// IsAfternoonAppointment returns whether a time is in the afternoon.
func IsAfternoonAppointment(date string) bool {
	t := parse("Monday, January 2, 2006 15:04:05", date)
	if t.Hour() >= 12 && t.Hour() < 18 {
		return true
	}

	return false
}

// Description returns a formatted string of the appointment time.
func Description(date string) string {
	t := Schedule(date)
	return fmt.Sprintf("You have an appointment on %s, %s %d, %d, at %d:%d.", t.Weekday(), t.Month(), t.Day(), t.Year(), t.Hour(), t.Minute())
}

// AnniversaryDate returns a Time with this year's anniversary.
func AnniversaryDate() time.Time {
	return time.Date(time.Now().Year(), time.September, 15, 0, 0, 0, 0, time.UTC)
}

func parse(layout string, date string) time.Time {
	t, err := time.Parse(layout, date)
	if err != nil {
		fmt.Println(err)
	}
	return t
}
