package parsinglogfiles

import (
	"fmt"
	"regexp"
)

func IsValidLine(text string) bool {
	re := regexp.MustCompile(`^\[(TRC|DBG|INF|WRN|ERR|FTL)\]`)
	match := re.FindStringSubmatch(text)
	return match != nil
}

func SplitLogLine(text string) []string {
	re := regexp.MustCompile(`<[~*=-]*>`)
	return re.Split(text, -1)
}

func CountQuotedPasswords(lines []string) int {
	re := regexp.MustCompile(`".*[pP][aA][sS]{2}[wW][oO][rR][dD].*"`)
	count := 0
	for _, text := range lines {
		if re.MatchString(text) {
			count++
		}
	}
	return count
}

func RemoveEndOfLineText(text string) string {
	re := regexp.MustCompile(`end-of-line\d*`)
	return re.ReplaceAllString(text, "")
}

func TagWithUserName(lines []string) []string {
	re := regexp.MustCompile(`User\s+(\w+)`)
	for i, text := range lines {
		if re.MatchString(text) {
			sl := re.FindStringSubmatch(text)
			lines[i] = fmt.Sprintf("[USR] %s %s", sl[1], text)
		}
	}

	return lines
}
