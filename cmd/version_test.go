package cmd

import (
	"fmt"
	"runtime"
	"testing"
)

func TestGetVersion(t *testing.T) {
	got := getVersion()
	want := fmt.Sprintf(`Version: %s
Revision: %s
OS: %s
Arch: %s
`, Version, Revision, runtime.GOOS, runtime.GOARCH)

	if want != got {
		t.Fatalf("unexpected version info. want: %s, got: %s", want, got)
	}
}
