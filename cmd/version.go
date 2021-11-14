package cmd

import (
	"fmt"
	"runtime"

	"github.com/spf13/cobra"
)

var (
	Revision = "dev"
	Version  = "dev"
)

func getVersion() string {
		return fmt.Sprintf(`Version: %s
Revision: %s
OS: %s
Arch: %s
`, Version, Revision, runtime.GOOS, runtime.GOARCH)
}

var versionCmd = &cobra.Command{
	Use: "Version",
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println(getVersion())
	},
}

func init() {
	rootCmd.AddCommand(versionCmd)
}
