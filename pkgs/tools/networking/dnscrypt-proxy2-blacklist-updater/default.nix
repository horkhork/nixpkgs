{ stdenv, python3Packages, fetchFromGitHub }:

# TODOs
#  - Fetch from github and write setup.py as part of preinstallPhase
#  - get dnscrypt-proxy2-blacklist-updater into git somewhere and pull it in
#  - Add crontab entry here with options
#  - Based on options generate domains-blacklist.conf, domains-whitelist, time-restricted, custom
#  - actually hook up to dnscrypt-proxy2

python3Packages.buildPythonApplication rec {
  pname = "dnscrypt-proxy2-blacklist-updater";
  version = "2.0.42";

  #src = /home/steve/git/dnscrypt-proxy/utils/generate-domains-blacklists;

  src = fetchFromGitHub {
    owner = "jedisct1";
    repo = "dnscrypt-proxy";
    rev = version;
    sha256 = "1v4n0pkwcilxm4mnj4fsd4gf8pficjj40jnmfkiwl7ngznjxwkyw";
  };

#  preBuild = ''
#    echo STEVE PRE BUILD
#    pwd
#    ls
#    cat <<EOF > utils/generate-domains-blacklists/setup.py
## setup.py
#from distutils.core import setup
#
#setup(
#    name='dnscrypt-proxy2-blacklist-updater',
#    version='0.0.1',
#    scripts=['generate-domains-blacklist.py',],
#)
#EOF
#    ls utils/generate-domains-blacklists/setup.py
#    cat utils/generate-domains-blacklists/setup.py
#  '';

  buildPhase = ''
    echo STEVE BUILD
  '';

  checkPhase = ''
    echo STEVE CHECK
  '';

  # Build Dependencies:
  buildInputs = with python3Packages; [ ];

  # Build AND Runtime Dependencies
  propagatedBuildInputs = with python3Packages; [ ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src/utils/generate-domains-blacklists/generate-domains-blacklist.py $out/bin/generate-domains-blacklist.py
    cp $src/utils/generate-domains-blacklists/domains-blacklist.conf $out/domains-blacklist.conf
    cp $src/utils/generate-domains-blacklists/domains-time-restricted.txt $out/domains-time-restricted.txt
    cp $src/utils/generate-domains-blacklists/domains-whitelist.txt $out/domains-whitelist.txt
  '';

  meta = with stdenv.lib; {
    description = "A tool that can be added to crontab for automatically updating dnscrypt-proxy2 blacklists";

    license = licenses.isc;
    homepage = "";
    maintainers = with maintainers; [ ssosik ];
    platforms = with platforms; unix;
  };
}
