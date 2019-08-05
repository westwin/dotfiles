wk=$HOME/work/yufuid/code
vds=~wk/yufu-vds/vds
oidc=~wk/yufu-vds/oidc

#dev
portal="http://xifeng.i.yufuid.com:6040/api/v1/tn-0a5a283e76074b23a532c99f6c3a81b9"
admin="http://xifeng.admin.i.yufuid.com:6020/api/v1/tn-0a5a283e76074b23a532c99f6c3a81b9"
idp="http://xifeng.idp.i.yufuid.com:6010/api/v1/tn-0a5a283e76074b23a532c99f6c3a81b9"

#admin api
#curl -b access_token="${TOKEN}" -XPOST "${admin}/objects"" -H 'Content-Type: application/json; charset=UTF-8' --data-binary '{"objectType":"USER","values":{"password":"Yufu@2018","displayName":"dev11","username":"demo1@example.com","primaryMail":"westwin@gmail.com","secondaryMail":"","phoneNum":"","deptId":"","leaderId":""}}'
#
#

#fq
#alias fq='export HTTP_PROXY=http://10.34.101.53:8118;export HTTPS_PROXY=http://10.34.101.53:8118'
#alias nfq='unset HTTP_PROXY; unset HTTPS_PROXY'
