#!/bin/bash

if [[ $# != 0 ]]; then
    eval "$@"
else
    exec /opt/keycloak/bin/kc.sh build --db=postgres --features=authorization,token-exchange,docker,impersonation,scripts,web-authn,client-policies,dynamic-scopes
fi

#--log=console,file --log-console-output=json --log-file=/var/log/keycloak/keycloak.log
#authorization, account2, account-api, admin-fine-grained-authz, admin2, docker, impersonation, openshift-integration, scripts, token-exchange, web-authn, client-policies, ciba, map-storage, par, declarative-user-profile, dynamic-scopes, client-secret-rotation, step-up-authentication, recovery-codes, preview