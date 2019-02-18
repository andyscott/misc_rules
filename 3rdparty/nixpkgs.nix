import (fetchTarball {
  url = "https://github.com/NixOS/nixpkgs/archive/18.09.tar.gz";
  # to calculate sha:
  # nix-prefetch-url --unpack <url>
  sha256 = "1ib96has10v5nr6bzf7v8kw7yzww8zanxgw2qi1ll1sbv6kj6zpd";
})
