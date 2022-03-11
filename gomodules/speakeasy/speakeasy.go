// Copied directly from https://github.com/bgentry/speakeasy/blob/675b82c74c0ed12283ee81ba8a534c8982c07b85/speakeasy.go
// and modified line 27 to replace getPassword
package speakeasy


import (
	"fmt"
	"io"
	"os"
	"strings"
)

// Ask the user to enter a password with input hidden. prompt is a string to
// display before the user's input. Returns the provided password, or an error
// if the command failed.
func Ask(prompt string) (password string, err error) {
	return FAsk(os.Stdout, prompt)
}

// FAsk is the same as Ask, except it is possible to specify the file to write
// the prompt to. If 'nil' is passed as the writer, no prompt will be written.
func FAsk(wr io.Writer, prompt string) (password string, err error) {
	if wr != nil && prompt != "" {
		fmt.Fprint(wr, prompt) // Display the prompt.
	}

	fmt.Scanln(&password)
	// password, err = getPassword()

	// Carriage return after the user input.
	if wr != nil {
		fmt.Fprintln(wr, "")
	}
	return
}

func readline() (value string, err error) {
	var valb []byte
	var n int
	b := make([]byte, 1)
	for {
		// read one byte at a time so we don't accidentally read extra bytes
		n, err = os.Stdin.Read(b)
		if err != nil && err != io.EOF {
			return "", err
		}
		if n == 0 || b[0] == '\n' {
			break
		}
		valb = append(valb, b[0])
	}

	return strings.TrimSuffix(string(valb), "\r"), nil
}
