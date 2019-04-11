export GOROOT="/usr/local/go/"
export GOPATH=$HOME/work/gopath
export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"

#wtf?
export OS_OUTPUT_GOPATH=1

# note, set GOCACHE=off for unit test
export GOCACHE=$GOPATH/.cache

