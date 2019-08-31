kc(){
    export KUBECONFIG=$(mktemp -t kubeconfig)
    cat ~/.kube/config >> $KUBECONFIG
    kubectl config use-context $1 > /dev/null&& kn default
    export KUBECONFIG_NAME=$1
}
kn(){
    kubectl config set-context --current --namespace=$1 > /dev/null
}
autoload bashcompinit
bashcompinit
_kube_contexts()
{
    local curr_arg;
    curr_arg=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "$(kubectl config get-contexts --output='name')" -- $curr_arg ) );
}
complete -F _kube_contexts kc

_kube_namespaces()
{
    local curr_arg;
    curr_arg=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "$(kubectl get namespaces -o=jsonpath='{range .items[*].metadata.name}{@}{"\n"}{end}')" -- $curr_arg ) );
}
complete -F _kube_namespaces kn
