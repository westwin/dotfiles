export OPENSSL_DIR="/usr/local/opt/openssl"
export OPENSSLINC_DIR="$OPENSSL_DIR/include"
export PATH="$OPENSSL_DIR/bin:$PATH"

export LDFLAGS="-L${OPENSSL_DIR}/lib"
export CPPFLAGS="-I${OPENSSLINC_DIR}"
