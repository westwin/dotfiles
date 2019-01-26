#docker pull and tag
function pt(){
    name="$1"
    docker pull xifeng/"${name}"
    if [[ $? -eq 0  ]]; then
        docker tag xifeng/"${name}" k8s.gcr.io/"${name}"
    fi
}
