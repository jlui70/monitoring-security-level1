# Diagramas Mermaid - Monitoring Security Level 1

## 📊 Diagrama 1: COMPLETO (Para README)

```mermaid
graph TB
    subgraph "🖥️ Docker Host"
        subgraph "📊 Monitoring Stack - Level 1"
            DC[🐳 Docker Compose<br/>Orquestração]
            
            subgraph "💾 Data Layer"
                MySQL[(🗄️ MySQL 8.3<br/>Database)]
            end
            
            subgraph "📈 Monitoring Core"
                ZS[🔷 Zabbix Server 7.0.5<br/>Infrastructure Monitoring]
                ZW[🌐 Zabbix Web<br/>UI Dashboard]
                ZA[📡 Zabbix Agent2<br/>Local Metrics]
                Prom[⏱️ Prometheus<br/>Time Series DB]
                Graf[📊 Grafana 12.0.2<br/>Visualization]
            end
            
            subgraph "📡 Exporters"
                NE[🖥️ Node Exporter<br/>System Metrics]
                ME[💿 MySQL Exporter<br/>DB Metrics]
            end
        end
        
        subgraph "🔓 Security Level 1"
            SEC[⚠️ Hardcoded Credentials<br/>Development Config]
        end
    end
    
    subgraph "👤 User Access"
        U1[🌐 Web Browser<br/>:8080 Zabbix]
        U2[📊 Web Browser<br/>:3000 Grafana]
        U3[⚙️ Web Browser<br/>:9090 Prometheus]
    end
    
    DC --> MySQL
    DC --> ZS
    DC --> ZW
    DC --> ZA
    DC --> Prom
    DC --> Graf
    DC --> NE
    DC --> ME
    
    MySQL --> ZS
    ZS --> ZW
    ZA --> ZS
    NE --> Prom
    ME --> Prom
    MySQL --> ME
    
    Prom --> Graf
    ZS --> Graf
    
    SEC -.->|🔑 Passwords| MySQL
    SEC -.->|🔑 Passwords| ZS
    SEC -.->|🔑 Passwords| Graf
    
    U1 --> ZW
    U2 --> Graf
    U3 --> Prom
    
    style DC fill:#2496ed,stroke:#1d72b8,color:#fff
    style MySQL fill:#00758f,stroke:#005f73,color:#fff
    style ZS fill:#d40000,stroke:#a00000,color:#fff
    style ZW fill:#d40000,stroke:#a00000,color:#fff
    style ZA fill:#d40000,stroke:#a00000,color:#fff
    style Prom fill:#e6522c,stroke:#c43e1f,color:#fff
    style Graf fill:#f46800,stroke:#d85000,color:#fff
    style NE fill:#44b78b,stroke:#2d8c6a,color:#fff
    style ME fill:#00758f,stroke:#005f73,color:#fff
    style SEC fill:#ff4444,stroke:#cc0000,color:#fff
    style U1 fill:#9b59b6,stroke:#7d3c98,color:#fff
    style U2 fill:#9b59b6,stroke:#7d3c98,color:#fff
    style U3 fill:#9b59b6,stroke:#7d3c98,color:#fff
```

---

## 🎯 Diagrama 2: SIMPLIFICADO (Para Capa do Portfólio)

```mermaid
graph LR
    subgraph "🔐 Monitoring Security - Level 1"
        direction TB
        
        DC[🐳 Docker Compose]
        
        MySQL[(🗄️ MySQL 8.3)]
        Zabbix[🔷 Zabbix 7.0.5]
        Graf[📊 Grafana 12.0.2]
        Prom[⏱️ Prometheus]
        
        DC --> MySQL
        DC --> Zabbix
        DC --> Graf
        DC --> Prom
        
        MySQL --> Zabbix
        Prom --> Graf
        Zabbix --> Graf
    end
    
    style DC fill:#2496ed,stroke:#1d72b8,color:#fff,stroke-width:3px
    style MySQL fill:#00758f,stroke:#005f73,color:#fff,stroke-width:3px
    style Zabbix fill:#d40000,stroke:#a00000,color:#fff,stroke-width:3px
    style Graf fill:#f46800,stroke:#d85000,color:#fff,stroke-width:3px
    style Prom fill:#e6522c,stroke:#c43e1f,color:#fff,stroke-width:3px
```

---

## 🎨 Diagrama 3: ALTERNATIVO - Arquitetura em Camadas (Para README)

```mermaid
flowchart TD
    subgraph Users["👥 Interfaces de Usuário"]
        ZUI[🌐 Zabbix Web :8080]
        GUI[📊 Grafana :3000]
        PUI[⚙️ Prometheus :9090]
    end
    
    subgraph Monitoring["📊 Camada de Monitoramento"]
        Zabbix[🔷 Zabbix Server 7.0.5<br/>Infrastructure Monitoring<br/>✓ 115+ Métricas<br/>✓ Alertas Configurados]
        Grafana[📊 Grafana 12.0.2<br/>Visualization Layer<br/>✓ Dashboards Automatizados<br/>✓ Node Exporter Dashboard<br/>✓ Zabbix Overview Dashboard]
        Prometheus[⏱️ Prometheus<br/>Time Series Database<br/>✓ Scrape Metrics<br/>✓ PromQL Queries]
    end
    
    subgraph Collectors["📡 Camada de Coleta"]
        ZAgent[📡 Zabbix Agent2<br/>Local Agent]
        NodeExp[🖥️ Node Exporter<br/>System Metrics :9100]
        MySQLExp[💿 MySQL Exporter<br/>DB Metrics :9104]
    end
    
    subgraph Data["💾 Camada de Dados"]
        MySQL[(🗄️ MySQL 8.3<br/>Primary Database<br/>✓ Zabbix Data<br/>✓ Configuration)]
    end
    
    subgraph Orchestration["🐳 Orquestração"]
        Docker[🐳 Docker Compose<br/>Container Orchestration<br/>✓ 8 Services<br/>✓ Network Isolation]
    end
    
    subgraph Security["🔓 Security Level 1"]
        Creds[⚠️ Configuration<br/>• Hardcoded Credentials<br/>• Development Setup<br/>• No Secrets Management]
    end
    
    ZUI --> Zabbix
    GUI --> Grafana
    PUI --> Prometheus
    
    Zabbix --> MySQL
    Zabbix --> ZAgent
    
    Grafana --> Prometheus
    Grafana --> Zabbix
    
    Prometheus --> NodeExp
    Prometheus --> MySQLExp
    
    MySQLExp --> MySQL
    
    Docker -.->|Manages| Zabbix
    Docker -.->|Manages| Grafana
    Docker -.->|Manages| Prometheus
    Docker -.->|Manages| MySQL
    Docker -.->|Manages| ZAgent
    Docker -.->|Manages| NodeExp
    Docker -.->|Manages| MySQLExp
    
    Creds -.->|🔑| MySQL
    Creds -.->|🔑| Zabbix
    Creds -.->|🔑| Grafana
    
    style Users fill:#9b59b6,stroke:#7d3c98,color:#fff
    style Monitoring fill:#3498db,stroke:#2980b9,color:#fff
    style Collectors fill:#44b78b,stroke:#2d8c6a,color:#fff
    style Data fill:#00758f,stroke:#005f73,color:#fff
    style Orchestration fill:#2496ed,stroke:#1d72b8,color:#fff
    style Security fill:#ff4444,stroke:#cc0000,color:#fff
    
    style Zabbix fill:#d40000,stroke:#a00000,color:#fff
    style Grafana fill:#f46800,stroke:#d85000,color:#fff
    style Prometheus fill:#e6522c,stroke:#c43e1f,color:#fff
    style MySQL fill:#00758f,stroke:#005f73,color:#fff
    style Docker fill:#2496ed,stroke:#1d72b8,color:#fff
```

---

## 💡 Como Usar

### Para visualizar no VS Code:
1. Instale a extensão "Markdown Preview Mermaid Support"
2. Abra este arquivo e use `Ctrl+Shift+V` para preview

### Para converter em imagem:
1. **Mermaid Live Editor**: https://mermaid.live/
2. **Mermaid CLI**: 
   ```bash
   npm install -g @mermaid-js/mermaid-cli
   mmdc -i diagramas-mermaid.md -o diagrama.png
   ```
3. **VS Code Extension**: Use "Markdown PDF" ou similar

### Recomendação de uso:
- **Diagrama 1 (Completo)**: Melhor para README - mostra fluxo completo
- **Diagrama 2 (Simplificado)**: Ideal para capa do portfólio - clean e direto
- **Diagrama 3 (Camadas)**: Alternativa para README - visão arquitetural

---

## 🎨 Personalizações Possíveis

Se quiser ajustar:
- **Cores**: Modifique os valores `fill` e `stroke` nos `style`
- **Ícones**: Adicione/remova emojis conforme preferência
- **Informações**: Ajuste os textos e labels
- **Layout**: Mude `graph TB/LR` para alterar direção (TB=top-bottom, LR=left-right)
