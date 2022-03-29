package utils

var (
	version string
	platform string
	arch string
)

type versionInfo struct {
	Version string
	Platform string
	Arch string
}

func GetVersion() versionInfo {
	return versionInfo{
		Version: version,
		Platform: platform,
		Arch: arch,
	}
}