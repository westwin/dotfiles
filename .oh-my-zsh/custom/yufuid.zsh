wk=$HOME/work/yufuid/code
vds=~wk/yufu-vds/vds
oidc=~wk/yufu-vds/oidc
idaas=~wk/idaas-core
gw=~wk/yufu-app-gw

#dev
portal="https://xifeng.i.yufuid.com/api/v1/tn-0a5a283e76074b23a532c99f6c3a81b9"
admin="http://xifeng-admin.i.yufuid.com/api/v1/tn-0a5a283e76074b23a532c99f6c3a81b9"
idp="https://xifeng-idp.i.yufuid.com/api/v1/tn-0a5a283e76074b23a532c99f6c3a81b9"

#admin api
#curl -b access_token="${TOKEN}" -XPOST "${admin}/objects"" -H 'Content-Type: application/json; charset=UTF-8' --data-binary '{"objectType":"USER","values":{"password":"Yufu@2018","displayName":"dev11","username":"demo1@example.com","primaryMail":"westwin@gmail.com","secondaryMail":"","phoneNum":"","deptId":"","leaderId":""}}'
#
#

#fq
#alias fq='export HTTP_PROXY=http://10.34.101.53:8118;export HTTPS_PROXY=http://10.34.101.53:8118'
#alias nfq='unset HTTP_PROXY; unset HTTPS_PROXY'

#qunhui poc
alias qh='ssh ec2-user@10.16.1.182 -p 22'
