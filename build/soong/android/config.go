package android

// Global config used by KCUF soong additions
var KCUFConfig = struct {
	// List of packages that are permitted
	// for java source overlays.
	JavaSourceOverlayModuleWhitelist []string
}{
	// JavaSourceOverlayModuleWhitelist
	[]string{
		"org.kcufos.hardware",
	},
}
