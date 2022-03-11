// Copied from https://github.com/chzyer/readline/blob/f6d7a1f6fbf35bbf9beb80dc63c56a29dcfb759f/readline.go
// disables interactive cli mode

package readline

import (
	"errors"
	"io"
)

type Instance struct {
	Config *Config
}

type Config struct {
	// prompt supports ANSI escape sequence, so we can color some characters even in windows
	Prompt string

	// enable case-insensitive history searching
	HistorySearchFold bool

	InterruptPrompt string
	EOFPrompt       string

	Stdin  io.ReadCloser
	Stdout io.Writer
	Stderr io.Writer
}

func NewEx(cfg *Config) (*Instance, error) {
	return &Instance{
		Config: cfg,
	}, nil
}

// we must make sure that call Close() before process exit.
func (i *Instance) Close() error {
	return nil
}

// err is one of (nil, io.EOF, readline.ErrInterrupt)
func (i *Instance) Readline() (string, error) {
	return "", nil
}

var (
	ErrInterrupt = errors.New("Interrupt")
)
