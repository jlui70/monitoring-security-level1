#!/bin/bash

# 📊 Script de importação de dashboards para Grafana
# Importa dashboards iniciais mas deixa eles editáveis (não provisionados)

echo "📊 Importando dashboards iniciais para o Grafana..."

# Aguardar Grafana estar disponível
echo "⏳ Aguardando Grafana estar disponível..."
until curl -s http://localhost:3000/api/health >/dev/null 2>&1; do
    echo "   Aguardando Grafana..."
    sleep 5
done

echo "✅ Grafana disponível!"

# Configurar datasources se necessário
echo "🔗 Configurando datasources..."

# Verificar se Prometheus já existe
PROMETHEUS_EXISTS=$(curl -s -u admin:admin http://localhost:3000/api/datasources/name/Prometheus 2>/dev/null | grep -o '"name":"Prometheus"' || echo "")

if [ -z "$PROMETHEUS_EXISTS" ]; then
    echo "📈 Adicionando datasource Prometheus..."
    curl -s -X POST \
        -H "Content-Type: application/json" \
        -u admin:admin \
        http://localhost:3000/api/datasources \
        -d '{
            "name": "Prometheus",
            "type": "prometheus",
            "url": "http://prometheus:9090",
            "access": "proxy",
            "isDefault": false
        }' >/dev/null
    echo "✅ Prometheus adicionado!"
else
    echo "✅ Prometheus já configurado!"
fi

# Verificar se Zabbix já existe
ZABBIX_EXISTS=$(curl -s -u admin:admin http://localhost:3000/api/datasources/name/Zabbix 2>/dev/null | grep -o '"name":"Zabbix"' || echo "")

if [ -z "$ZABBIX_EXISTS" ]; then
    echo "🎯 Adicionando datasource Zabbix..."
    curl -s -X POST \
        -H "Content-Type: application/json" \
        -u admin:admin \
        http://localhost:3000/api/datasources \
        -d '{
            "name": "Zabbix",
            "type": "alexanderzobnin-zabbix-datasource",
            "url": "http://zabbix-web:8080/api_jsonrpc.php",
            "access": "proxy",
            "isDefault": true,
            "jsonData": {
                "username": "Admin",
                "trends": true,
                "trendsFrom": "7d",
                "cacheTTL": "1h",
                "timeout": 60
            },
            "secureJsonData": {
                "password": "zabbix"
            }
        }' >/dev/null
    echo "✅ Zabbix adicionado!"
else
    echo "✅ Zabbix já configurado!"
fi

# Importar dashboards
echo "📋 Importando dashboards..."

DASHBOARD_DIR="./grafana/dashboards"

for dashboard_file in "$DASHBOARD_DIR"/*.json; do
    if [ -f "$dashboard_file" ]; then
        dashboard_name=$(basename "$dashboard_file" .json)
        echo "📊 Importando dashboard: $dashboard_name"
        
        # Importar dashboard
        curl -s -X POST \
            -H "Content-Type: application/json" \
            -u admin:admin \
            http://localhost:3000/api/dashboards/db \
            -d "{
                \"dashboard\": $(cat "$dashboard_file"),
                \"overwrite\": true
            }" >/dev/null
        
        echo "✅ Dashboard $dashboard_name importado!"
    fi
done

echo ""
echo "🎉 Configuração completa!"
echo "📊 Dashboards importados e totalmente editáveis!"
echo "🔗 Acesse: http://localhost:3000 (admin/admin)"
echo ""
echo "💡 Agora você pode:"
echo "   • Editar dashboards livremente"
echo "   • Salvar modificações permanentemente"
echo "   • Criar novos dashboards"
echo "   • Duplicar e personalizar existentes"