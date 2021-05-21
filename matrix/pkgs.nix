let
  rev = "d42cd445dde587e9a993cd9434cb43da07c4c5de";
  sha256 = "0dzrn97srxyw5a3g7hf8chwccxns5z3aij23hc0fch7ygc8w0gq0";
  tarball = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    inherit sha256;
  };
in
builtins.trace "Using default Nixpkgs revision '${rev}'..." (import tarball)
