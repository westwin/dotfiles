function npns::login(){
    local host=$1
    local port="${2:-80}"
    local scheme="http"

    if [[ "${port}" == "443" ]]; then
        scheme="https"
    fi
    curl -v -k -L -X POST --header 'Content-Type: application/json;charset=UTF-8' --header 'Accept: application/json' -d '{ "username":"9c1c86e159ac4277","password":"2ndcy8s1p"  }' "${scheme}://${host}:${port}/cps/api/login"
}

function npns::push() {
    local host=$1
    local port="${2:-80}"
    local scheme="http"

    if [[ "${port}" == "443" ]]; then
        scheme="https"
    fi

    token=$(npns::login ${host} ${port} | cut -d ':' -f2 | cut -d '"' -f2)
    NOW="$(date)"

    curl -k -L -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' --header "Authorization: Bearer ${token}" -d "{\"notificationType\": \"BY_TOKEN\", \"pnsTokens\": [ {\"type\":\"NCM\",\"token\":\"2E6199509B60985026663F33\"} ], \"features\":[{\"type\":\"NCM\", \"uuid\":\"555dec82-338f-4268-aeeb-1afdb5599901\"}], \"payload\": \"{'aps':{'alert':'138','domaintype':'0','infoType':'1'},'cmd':['0'],'flownum':'57b5b35a-bde1-46d2-94f6-ce4d5ecdebe0'}\", \"message\": \"hello ${NOW}\", \"silentAlert\": true } }'" "${scheme}://${host}:${port}/cps/api/notifications/1343096095"
}

function npns::test() {
    local host=$1
    local port="${2:-80}"

    COUNTER=0
    index=1
    while [  $COUNTER -eq 0  ]; do
        echo "pushing ${index}"
        npns::push ${host} ${port}
        echo
        sleep 0.5s
        index=$((index+1))
    done
}

