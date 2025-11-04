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

AUTH_TOKEN=$(curl -s -X POST http://localhost:8080/api_jsonrpc.php \
    -H "Content-Type: application/json" \
    -d '{
        "jsonrpc": "2.0",
        "method": "user.login",
        "params": {
            "user": "Admin",
            "password": "zabbix"
        },
        "id": 1
    }' | grep -o '"result":"[^"]*"' | cut -d'"' -f4)

if [ -z "$AUTH_TOKEN" ]; then
    echo "❌ Erro ao fazer login no Zabbix API"
    exit 1
fi

echo "✅ Login realizado com sucesso!"

# Buscar o host Zabbix server
echo "🔍 Buscando host Zabbix server..."

HOST_ID=$(curl -s -X POST http://localhost:8080/api_jsonrpc.php \
    -H "Content-Type: application/json" \
    -d "{
        \"jsonrpc\": \"2.0\",
        \"method\": \"host.get\",
        \"params\": {
            \"filter\": {
                \"host\": [\"Zabbix server\"]
            },
            \"selectInterfaces\": \"extend\"
        },
        \"auth\": \"$AUTH_TOKEN\",
        \"id\": 2
    }" | grep -o '"hostid":"[^"]*"' | head -1 | cut -d'"' -f4)

if [ -z "$HOST_ID" ]; then
    echo "❌ Host Zabbix server não encontrado"
    exit 1
fi

echo "✅ Host encontrado: ID $HOST_ID"

# Obter interface ID
INTERFACE_ID=$(curl -s -X POST http://localhost:8080/api_jsonrpc.php \
    -H "Content-Type: application/json" \
    -d "{
        \"jsonrpc\": \"2.0\",
        \"method\": \"host.get\",
        \"params\": {
            \"hostids\": [\"$HOST_ID\"],
            \"selectInterfaces\": \"extend\"
        },
        \"auth\": \"$AUTH_TOKEN\",
        \"id\": 3
    }" | grep -o '"interfaceid":"[^"]*"' | head -1 | cut -d'"' -f4)

echo "🔧 Atualizando interface para usar DNS..."

# Atualizar interface para usar DNS
curl -s -X POST http://localhost:8080/api_jsonrpc.php \
    -H "Content-Type: application/json" \
    -d "{
        \"jsonrpc\": \"2.0\",
        \"method\": \"hostinterface.update\",
        \"params\": {
            \"interfaceid\": \"$INTERFACE_ID\",
            \"dns\": \"zabbix-agent2\",
            \"useip\": 0
        },
        \"auth\": \"$AUTH_TOKEN\",
        \"id\": 4
    }"

echo ""
echo "✅ Configuração do Zabbix concluída!"
echo "🎯 Host Zabbix server configurado para usar DNS (zabbix-agent2)"
echo "🟢 O status ZBX deve ficar verde em alguns minutos"