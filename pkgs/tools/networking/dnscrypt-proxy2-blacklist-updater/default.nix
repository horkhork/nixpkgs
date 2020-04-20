{ stdenv, python3Packages, fetchFromGitHub }:

python3Packages.buildPythonApplication rec {
  pname = "dnscrypt-proxy2";
  version = "2.0.42";

  src = /home/steve/git/dnscrypt-proxy/utils/generate-domains-blacklists;

  #src = fetchFromGitHub {
  #  owner = "jedisct1";
  #  repo = "dnscrypt-proxy";
  #  rev = version;
  #  sha256 = "1v4n0pkwcilxm4mnj4fsd4gf8pficjj40jnmfkiwl7ngznjxwkyw";
  #};

  # Build Dependencies:
  buildInputs = with python3Packages; [ ];

  # Build AND Runtime Dependencies
  propagatedBuildInputs = with python3Packages; [ ];

  meta = with stdenv.lib; {
    description = "A tool that can be added to crontab for automatically updating dnscrypt-proxy2 blacklists";

    license = licenses.isc;
    homepage = "";
    maintainers = with maintainers; [ ssosik ];
    platforms = with platforms; unix;
  };
}
