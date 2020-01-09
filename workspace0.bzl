load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def workspace0():
    http_archive(
	name = "io_tweag_rules_nixpkgs",
    	strip_prefix = "rules_nixpkgs-adfe991ad7fd41fcdbeaeabf33ea061d9b435c97",
    	urls = ["https://github.com/tweag/rules_nixpkgs/archive/adfe991ad7fd41fcdbeaeabf33ea061d9b435c97.tar.gz"],
    )