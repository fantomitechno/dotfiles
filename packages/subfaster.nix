{ pkgs }:

pkgs.buildGo127Module rec {
  pname = "subfaster";
  version = "2.20.0";
  src = pkgs.fetchFromGitHub {
    owner = "melvinsh";
    repo = "subfaster";
    rev = "v${version}";
    sha256 = "sha256-zijvaKdnXXgGYmBgZ9v4TIGs7Np/khoTI5RbTxgqdR8=";
  };
  vendorHash = "sha256-/nVcu12++1oRLDixTsMn7KKirOUWKHuTedRC7nqZDew=";
}
# Issues looking up api.sub.md
# probably just issue of the FW im behind
