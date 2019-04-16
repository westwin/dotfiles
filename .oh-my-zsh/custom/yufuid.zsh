wk=$HOME/work/yufuid/code

#dev env
export DB_HOST=nx-dev-idaas-pg.czzoopdyw428.rds.cn-northwest-1.amazonaws.com.cn
export DB_PORT=5432
alias db="pgcli -h $DB_HOST -p $DB_PORT -u idaas -W idaas"
