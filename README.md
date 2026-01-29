# 🔐 Monitoring Security Evolution - Nível 1: Base Funcional
## Stack de Monitoramento com Zabbix, Grafana e Prometheus

<div align="center">
  <img src="Diagrama camadas Monitoring Security 1.png" alt="Arquitetura Monitoring Security Level 1" width="800">
</div>

![Security Level](https://img.shields.io/badge/Security%20Level-1%20Basic-red)
![Docker](https://img.shields.io/badge/Docker-Compose-blue)
![Status](https://img.shields.io/badge/Status-Production%20Ready-green)

---

## 📋 Sobre o Projeto

Este projeto apresenta uma stack completa de monitoramento com Docker Compose, servindo como baseline (Nível 1) de uma série evolutiva de 5 níveis focada em secrets management e segurança em ambientes containerizados.

Para demonstrar a base funcional, implementei manualmente todos os componentes de monitoramento:

🐳 Docker Compose orquestrando stack completa de monitoramento
📊 Zabbix Server 7.0.5 para monitoramento de infraestrutura
📈 Grafana 12.0.2 com dashboards automatizados e visualização avançada
⏱️ Prometheus coletando métricas time-series de toda stack
🗄️ MySQL 8.3 como banco de dados principal
📡 Node Exporter + MySQL Exporter capturando 115+ métricas
🔧 Scripts automatizados de setup e configuração completa

🎯 Objetivo: Estabelecer baseline funcional com configuração básica (credenciais hardcoded) para servir como ponto de partida da evolução de segurança através dos 5 níveis da série.

✅ Resultado: Stack de monitoramento 100% operacional com dashboards profissionais, alertas configurados e integração completa entre ferramentas, documentando a configuração inicial antes da implementação progressiva de secrets management (variáveis de ambiente, Vault, AWS Secrets Manager e Kubernetes Secrets).

---

## 🚀 **Evolução da Série (5 Níveis COMPLETOS)**

<table>
<thead>
<tr>
<th style="min-width: 100px;">Nível</th>
<th>Foco</th>
<th>Secrets Storage</th>
<th>Onde Containers Leem</th>
<th>Orquestração</th>
<th>Status</th>
</tr>
</thead>
<tbody>
<tr>
<td><strong><a href="https://github.com/jlui70/monitoring-security-level1">Level&nbsp;1</a></strong></td>
<td>Baseline</td>
<td>Hardcoded</td>
<td>Código fonte</td>
<td>Docker Compose</td>
<td><strong>✅ VOCÊ ESTÁ AQUI</strong></td>
</tr>
<tr>
<td><strong><a href="https://github.com/jlui70/monitoring-security-level2">Level&nbsp;2</a></strong></td>
<td>Env Vars</td>
<td><code>.env</code> files</td>
<td><code>.env</code></td>
<td>Docker Compose</td>
<td>✅</td>
</tr>
<tr>
<td><strong><a href="https://github.com/jlui70/monitoring-security-level3">Level&nbsp;3</a></strong></td>
<td>Vault Foundation</td>
<td>Vault + <code>.env</code></td>
<td><code>.env</code></td>
<td>Docker Compose</td>
<td>✅</td>
</tr>
<tr>
<td><strong><a href="https://github.com/jlui70/monitoring-security-level4-aws-v2">Level&nbsp;4</a></strong></td>
<td>AWS Cloud</td>
<td>AWS Secrets Manager</td>
<td>AWS API</td>
<td>Terraform + EC2</td>
<td>✅</td>
</tr>
<tr>
<td><strong><a href="https://github.com/jlui70/monitoring-security-level5">Level&nbsp;5</a></strong></td>
<td><strong>K8s + Vault</strong></td>
<td><strong>Vault (KV v2)</strong></td>
<td><strong>Kubernetes Secrets</strong></td>
<td><strong>Kubernetes</strong></td>
<td>✅</td>
</tr>
</tbody>
</table>

---

## 🏗️ **Nível 1: Base Funcional - O que você vai encontrar**

### **Stack Implementada:**
- ✅ **MySQL 8.3** - Banco de dados principal
- ✅ **Zabbix Server 7.0.5** - Monitoramento de infraestrutura
- ✅ **Zabbix Web Interface** - Dashboard de monitoramento
- ✅ **Grafana 12.0.2** - Visualização avançada de métricas
- ✅ **Prometheus** - Coleta de métricas time-series
- ✅ **Node Exporter** - Métricas do sistema operacional
- ✅ **MySQL Exporter** - Métricas específicas do MySQL
- ✅ **Zabbix Agent2** - Agente de monitoramento local

### **📊 Monitoramento Funcional:**
- **115+ métricas** coletadas pelo Zabbix
- **Dashboards automatizados** no Grafana
- **Alertas configurados** para problemas críticos
- **Integração completa** entre todas as ferramentas

---

## 🔓 **Características de Segurança - Nível 1**

### **⚠️ Configuração Atual (Desenvolvimento):**
```bash
# .env - Credenciais em texto claro
MYSQL_PASSWORD=zabbixpass
MYSQL_ROOT_PASSWORD=rootpass
GRAFANA_ADMIN_PASSWORD=admin

# ❌ Problemas de Segurança Identificados:
# - Senhas em texto claro
# - Credenciais versionadas no Git
# - Senhas fracas e previsíveis
# - Sem rotação de passwords
# - Sem auditoria de acessos
```

### **✅ Justificativa para Desenvolvimento:**
- **Simplicidade** para desenvolvimento local
- **Facilidade de debug** e troubleshooting
- **Setup rápido** para novos desenvolvedores
- **Base sólida** para evolução posterior

---

## 🚀 **Como Usar Este Projeto**

### **Pré-requisitos:**
- Docker e Docker Compose instalados
- Portas disponíveis: 3000, 8080, 9090, 9100, 9104, 3306
- 4GB RAM disponível (recomendado)

### **Deploy Automático (Recomendado):**
```bash
# 1. Clone o repositório
git clone https://github.com/jlui70/monitoring-security-level1.git
cd monitoring-security-level1

# 2. Execute o setup automático
./setup.sh

# 3. Acesse as interfaces:
# Zabbix: http://localhost:8080 (Admin/zabbix)
# Grafana: http://localhost:3000 (admin/admin)
# Prometheus: http://localhost:9090
```

**🎯 O `setup.sh` faz TUDO automaticamente:**
- ✅ Valida pré-requisitos (Docker, portas, recursos)
- ✅ Sobe todos os containers
- ✅ Aguarda serviços ficarem prontos
- ✅ Configura Zabbix (templates, DNS, hosts)
- ✅ Importa dashboards editáveis no Grafana
- ✅ Valida funcionamento de todos os serviços

### **Deploy Manual (Alternativo):**
```bash
# Apenas se quiser controle manual de cada etapa
docker-compose up -d
sleep 120  # Aguardar inicialização
./configure-zabbix.sh    # Configurar Zabbix
./import-dashboards.sh   # Importar dashboards
```

### **⚠️ Tempos de Inicialização Importantes:**
- **MySQL:** 2-3 minutos ✅
- **Prometheus & Grafana:** 3-5 minutos ✅
- **Zabbix:** 10-15 minutos ⏰ (criação de tabelas do banco)

### **🔧 Script de Setup Inteligente:**

O `./setup.sh` é um script completo que:

**📋 Pré-Verificações:**
- ✅ Verifica Docker e Docker Compose instalados
- ✅ Valida portas disponíveis (3000, 8080, 9090, etc.)
- ✅ Confirma recursos suficientes

**🚀 Deploy Automatizado:**
- ✅ Cria networks necessárias
- ✅ Sobe containers em ordem otimizada
- ✅ Aguarda inicialização completa
- ✅ Valida saúde de todos os serviços

**⚙️ Configuração Automática:**
- ✅ **configure-zabbix.sh** - Templates, DNS e hosts
- ✅ **import-dashboards.sh** - Dashboards editáveis
- ✅ Datasources no Grafana
- ✅ Validação final de funcionamento

```
# Testar conectividade individual
curl http://localhost:3000/api/health     # Grafana
curl http://localhost:9090/api/v1/status  # Prometheus
curl http://localhost:8080               # Zabbix
```

### **🎯 Dashboards Profissionais Incluídos:**
1. **Node Exporter Prometheus** - Dashboard completo da biblioteca Grafana com métricas avançadas do sistema
2. **Zabbix Server** - **Dashboard personalizado** com monitoramento específico:
   - ⚡ Uptime e disponibilidade do sistema
   - 🌐 Conectividade de rede (ping, latência, perda de pacotes)
   - 💾 Métricas de memória e CPU
   - 🖥️ Utilização de recursos do servidor
   - 📊 Painéis em tempo real com alertas visuais

---

## 📈 **Dashboards e Métricas**

### **Zabbix Monitoring:**
- **Sistema:** CPU, Memória, Disco, Rede
- **Aplicação:** Status dos containers Docker
- **Conectividade:** ICMP ping, packet loss
- **MySQL:** Connections, queries per second, performance

### **Grafana Dashboards:**
- **Node Exporter Full** - Métricas completas do sistema
- **MySQL Overview** - Monitoramento específico do banco
- **Docker Container Metrics** - Saúde dos containers
- **Prometheus Self-Monitoring** - Métricas do próprio Prometheus

### **Prometheus Targets:**
- **node-exporter:9100** - Métricas do sistema
- **mysql-exporter:9104** - Métricas do MySQL
- **prometheus:9090** - Auto-monitoramento

---

## 🔄 **Evolução do Projeto**

### **📍 Você está aqui: Nível 1**
Este repositório representa o **ponto de partida** da jornada de segurança.

Caso queira dar continuidade no projeto para o próximo nível (2), execute a limpeza do nível 1 para evitar conflitos na configuração

🧹 Limpeza completa do projeto segurança nível 1

# Limpeza completa (remove diretporio projeto monitoring-security-level1 e limpa Docker)
cd ~/ && rm -rf monitoring-security-level1
docker system prune -f

### **🎯 Roadmap de Melhorias:**
```
Nível 1 → Nível 2: Variáveis isoladas por ambiente
Nível 2 → Nível 3: Centralização com Vault
Nível 3 → Nível 4: Migração para AWS Cloud
Nível 4 → Nível 5: Orquestração com Kubernetes
```

---

## 🔍 **Análise de Segurança**

### **✅ Pontos Positivos:**
- Stack funcional e monitorada
- Configuração reproduzível
- Documentação completa
- Base sólida para evolução

### **⚠️ Pontos de Atenção (a serem evoluídos):**
- Credenciais em texto claro
- Senhas fracas
- Sem rotação automática
- Sem auditoria de acessos
- Configuração única para todos os ambientes

### **🎯 Lições Aprendidas:**
- Importância de estabelecer baseline funcional
- Trade-off entre simplicidade e segurança
- Necessidade de evolução gradual
- Valor do monitoramento desde o início

---

## � Licença

Este projeto está sob licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

## 📞 Contato e Suporte

### 🌐 Conecte-se Comigo

- 📹 **YouTube**: [DevOps Project](https://devopsproject.com.br/)
- 💼 **Portfólio**: [devopsproject.com.br](https://devopsproject.com.br/)
- 💻 **GitHub**: [@jlui70](https://github.com/jlui70)

### 🌟 Gostou do Projeto?

Se este projeto foi útil para você:

- ⭐ Dê uma estrela nos repositórios
- 🔄 Compartilhe com a comunidade
- 📹 Inscreva-se no canal do YouTube
- 🤝 Contribua com melhorias

---

**🎯 Este é o primeiro passo de uma jornada completa de segurança. A evolução continua nos próximos níveis!**

*"A segurança é uma jornada, não um destino. Comece simples, evolua constantemente."*
