# 🔐 Monitoring Security Evolution - Nível 1: Base Funcional
## Stack de Monitoramento com Zabbix, Grafana e Prometheus

![Security Level](https://img.shields.io/badge/Security%20Level-1%20Basic-red)
![Docker](https://img.shields.io/badge/Docker-Compose-blue)
![Status](https://img.shields.io/badge/Status-Production%20Ready-green)

---

## 📋 **Sobre Este Projeto**

Este é o **Nível 1** de uma série de 5 repositórios que demonstram a **evolução completa de segurança** em ambientes containerizados, desde configurações básicas até implementações enterprise-grade com AWS e Kubernetes.

### 🎯 **Objetivo da Série:**
Demonstrar na prática como **evoluir a segurança de secrets management** em projetos reais, seguindo as melhores práticas da indústria.

### 📊 **Visão Geral dos 5 Níveis:**

| Nível | Solução | Complexidade | Segurança | Custo | Caso de Uso |
|-------|---------|--------------|-----------|-------|-------------|
| **1** | **.env files** | ⭐ | ⭐ | ⭐⭐⭐ | **Desenvolvimento local** |
| **2** | **Environment Variables** | ⭐⭐ | ⭐⭐ | ⭐⭐⭐ | **Staging/Homologação** |
| **3** | **HashiCorp Vault** | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐ | **Enterprise On-Premise** |
| **4** | **AWS Secrets Manager** | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐ | **Cloud-First Production** |
| **5** | **Kubernetes + External Secrets** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐ | **Multi-Cloud Enterprise** |

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

### **Deploy Rápido:**
```bash
# 1. Clone o repositório
git clone https://github.com/jlui70/monitoring-security-level1.git
cd monitoring-security-level1

# 2. Suba a stack completa
docker-compose up -d

# 3. Aguarde a inicialização (10-15 minutos para Zabbix)
docker-compose ps

# 4. Configure o Zabbix Agent (depois que Zabbix estiver acessível)
./configure-zabbix.sh

# 5. Acesse as interfaces:
# Zabbix: http://localhost:8080 (Admin/zabbix)
# Grafana: http://localhost:3000 (admin/admin)
# Prometheus: http://localhost:9090
```

### **⚠️ Tempos de Inicialização Importantes:**
- **MySQL:** 2-3 minutos ✅
- **Prometheus & Grafana:** 3-5 minutos ✅
- **Zabbix:** 10-15 minutos ⏰ (criação de tabelas do banco)

### **🔧 Configuração Automática (Incluída no Setup):**

O script `./setup.sh` executa automaticamente:

✅ **configure-zabbix.sh** - Configura templates e DNS do Zabbix
✅ **import-dashboards.sh** - Importa dashboards editáveis para o Grafana

**🎯 Resultado:** Dashboards **totalmente editáveis** após setup!

**O que você pode fazer:**
- ✅ Editar dashboards livremente  
- ✅ Salvar modificações permanentemente
- ✅ Criar novos dashboards personalizados
- ✅ Duplicar e customizar existentes
- ✅ Adicionar seus próprios monitoramentos

**Execução manual (se necessário):**
```bash
./configure-zabbix.sh    # Apenas configuração Zabbix
./import-dashboards.sh   # Apenas importação dashboards
```

### **Verificação de Saúde:**
```bash
# Status dos containers
docker-compose ps

# Logs do Zabbix (para acompanhar inicialização)
docker-compose logs -f zabbix-server

# Logs em caso de problemas
docker-compose logs -f [serviço]

# Teste de conectividade
curl http://localhost:3000/api/health
curl http://localhost:9090/api/v1/status/config

# Configurar Zabbix Agent
./configure-zabbix.sh
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

## 🛠️ **Estrutura do Projeto**

```
monitoring-security-level1/
├── docker-compose.yml          # Orquestração principal
├── .env                        # Variáveis de ambiente (Nível 1)
├── README.md                   # Esta documentação
├── grafana/
│   └── provisioning/
│       ├── datasources/        # Auto-configuração de datasources
│       └── dashboards/         # Dashboards pré-configurados
├── prometheus/
│   └── prometheus.yml          # Configuração de coleta
└── mysql-exporter/
    └── my.cnf                  # Configuração do exporter
```

---

## 🔄 **Evolução do Projeto**

### **📍 Você está aqui: Nível 1**
Este repositório representa o **ponto de partida** da jornada de segurança.

### **🚀 Próximos Níveis:**
1. **[Nível 2: Environment Variables](link-futuro)** - Isolamento por ambiente
2. **[Nível 3: HashiCorp Vault](link-futuro)** - Secrets management enterprise
3. **[Nível 4: AWS Secrets Manager](link-futuro)** - Cloud-native security
4. **[Nível 5: Kubernetes + External Secrets](link-futuro)** - Multi-cloud enterprise

### **🎯 Roadmap de Melhorias:**
```
Nível 1 → Nível 2: Variáveis isoladas por ambiente
Nível 2 → Nível 3: Centralização com Vault
Nível 3 → Nível 4: Migração para AWS Cloud
Nível 4 → Nível 5: Orquestração com Kubernetes
```

---

## 📊 **Métricas e Resultados**

### **Performance Baseline:**
- **Startup time:** ~2-3 minutos
- **Memory usage:** ~3.5GB total
- **CPU usage:** <5% em idle
- **Storage:** ~2GB (dados + logs)

### **Monitoramento Ativo:**
- **115+ itens** coletados pelo Zabbix
- **2 dashboards** pré-configurados no Grafana
- **3 exporters** Prometheus funcionais
- **Alertas** configurados para problemas críticos

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

## 🤝 **Contribuições**

Este projeto faz parte de uma série educacional sobre evolução de segurança. 

### **Como contribuir:**
1. Fork o projeto
2. Crie uma branch para sua feature
3. Faça commit das mudanças
4. Abra um Pull Request

### **Tipos de contribuição bem-vindas:**
- Melhorias na documentação
- Otimizações de performance
- Dashboards adicionais
- Correções de bugs
- Sugestões de segurança (para níveis superiores)

---

## 📧 **Contato e Suporte**

- **Autor:** [Seu Nome]
- **GitHub:** [@jlui70](https://github.com/jlui70)
- **Série Completa:** [Monitoring Security Evolution](link-para-organização)

### **Suporte:**
- Issues neste repositório para problemas específicos do Nível 1
- Discussões gerais na [organização principal](link-futuro)

---

## 📜 **Licença**

Este projeto está sob licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

## 🏷️ **Tags**

`docker` `monitoring` `zabbix` `grafana` `prometheus` `security` `devops` `mysql` `level1` `baseline`

---

**🎯 Este é o primeiro passo de uma jornada completa de segurança. A evolução continua nos próximos níveis!**

*"A segurança é uma jornada, não um destino. Comece simples, evolua constantemente."*