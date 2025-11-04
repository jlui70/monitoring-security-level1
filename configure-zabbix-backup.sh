#!/bin/bash

# 🔧 Script de configuração automática do Zabbix
# Configura o host Zabbix server para usar DNS em vez de IP

echo "🔧 Configurando Zabbix Host automaticamente..."

# Aguardar Zabbix estar disponível
echo "⏳ Aguardando Zabbix estar disponível..."
until curl -s http://localhost:8080/api_jsonrpc.php >/dev/null 2>&1; do
    echo "   Aguardando Zabbix..."
    sleep 5
done

echo "✅ Zabbix disponível!"

# Fazer login e obter auth token
echo "🔑 Fazendo login no Zabbix API..."

AUTH_RESPONSE=$(curl -s -X POST http://localhost:8080/api_jsonrpc.php \
    -H "Content-Type: application/json-rpc" \
    -d '{
        "jsonrpc": "2.0",
        "method": "user.login",
        "params": {
            "username": "Admin",
            "password": "zabbix"
        },
        "id": 1
    }')

# Extrair token de forma mais robusta
AUTH_TOKEN=$(echo "$AUTH_RESPONSE" | grep -o '"result":"[^"]*"' | cut -d'"' -f4)

if [ -z "$AUTH_TOKEN" ]; then
    echo "❌ Erro ao fazer login no Zabbix API"
    echo "Resposta: $AUTH_RESPONSE"
    exit 1
fi

echo "✅ Login realizado com sucesso!"

# Buscar o host "Zabbix server"
echo "🔍 Buscando host 'Zabbix server'..."

HOST_RESPONSE=$(curl -s -X POST http://localhost:8080/api_jsonrpc.php \
    -H "Content-Type: application/json-rpc" \
    -d '{
        "jsonrpc": "2.0",
        "method": "host.get",
        "params": {
            "filter": {
                "host": ["Zabbix server"]
            },
            "selectInterfaces": "extend"
        },
        "auth": "'$AUTH_TOKEN'",
        "id": 2
    }')

# Extrair hostid
HOST_ID=$(echo "$HOST_RESPONSE" | grep -o '"hostid":"[^"]*"' | head -1 | cut -d'"' -f4)

if [ -z "$HOST_ID" ]; then
    echo "❌ Host 'Zabbix server' não encontrado"
    echo "Resposta: $HOST_RESPONSE"
    exit 1
fi

echo "✅ Host encontrado! ID: $HOST_ID"

# Extrair interface ID
INTERFACE_ID=$(echo "$HOST_RESPONSE" | grep -o '"interfaceid":"[^"]*"' | head -1 | cut -d'"' -f4)

if [ -z "$INTERFACE_ID" ]; then
    echo "❌ Interface não encontrada"
    exit 1
fi

echo "🔧 Atualizando interface para usar DNS..."

# Atualizar interface para usar DNS
UPDATE_RESPONSE=$(curl -s -X POST http://localhost:8080/api_jsonrpc.php \
    -H "Content-Type: application/json-rpc" \
    -d '{
        "jsonrpc": "2.0",
        "method": "hostinterface.update",
        "params": {
            "interfaceid": "'$INTERFACE_ID'",
            "useip": 0,
            "dns": "zabbix-agent2"
        },
        "auth": "'$AUTH_TOKEN'",
        "id": 3
    }')

# Verificar resultado
if echo "$UPDATE_RESPONSE" | grep -q '"result"'; then
    echo "✅ Interface atualizada com sucesso!"
    echo "🎯 Host 'Zabbix server' agora usa DNS: zabbix-agent2"
    echo ""
    echo "📋 Verificar em: Configuration → Hosts → Zabbix server"
    echo "   Interface deve mostrar: Agent zabbix-agent2 Connect to DNS"
else
    echo "❌ Erro ao atualizar interface"
    echo "Resposta: $UPDATE_RESPONSE"
    exit 1
fi