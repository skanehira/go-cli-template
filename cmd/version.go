package cmd

import (
	"fmt"
	"runtime"

	"github.com/spf13/cobra"
)

var (
	Revision = "dev"
)

var versionCmd = &cobra.Command{
	Use: "version",
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Printf(`Revision: %s
OS: %s
Arch: %s
`, Revision, runtime.GOOS, runtime.GOARCH)
	},
}

func init() {
	rootCmd.AddCommand(versionCmd)
}
