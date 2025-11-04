#!/bin/bash

# 🚀 Setup script para Monitoring Security Level 1
# Script de inicialização e validação da stack

set -e

echo "🔐 Monitoring Security Evolution - Level 1 Setup"
echo "================================================"

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para logs coloridos
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Verificar pré-requisitos
check_prerequisites() {
    log_info "Verificando pré-requisitos..."
    
    # Docker
    if ! command -v docker &> /dev/null; then
        log_error "Docker não encontrado. Instale o Docker primeiro."
        exit 1
    fi
    log_success "Docker encontrado: $(docker --version)"
    
    # Docker Compose
    if ! command -v docker-compose &> /dev/null; then
        log_error "Docker Compose não encontrado. Instale o Docker Compose primeiro."
        exit 1
    fi
    log_success "Docker Compose encontrado: $(docker-compose --version)"
    
    # Verificar se Docker está rodando
    if ! docker info &> /dev/null; then
        log_error "Docker não está rodando. Inicie o Docker primeiro."
        exit 1
    fi
    log_success "Docker está rodando"
}

# Verificar portas disponíveis
check_ports() {
    log_info "Verificando portas necessárias..."
    
    ports=(3000 8080 9090 9100 9104 3306)
    for port in "${ports[@]}"; do
        if lsof -Pi :$port -sTCP:LISTEN -t >/dev/null 2>&1; then
            log_warning "Porta $port está em uso. Pode haver conflitos."
        else
            log_success "Porta $port disponível"
        fi
    done
}

# Setup da stack
setup_stack() {
    log_info "Iniciando setup da stack de monitoramento..."
    
    # Criar networks necessárias
    log_info "Criando networks Docker..."
    docker network create monitoring-network 2>/dev/null || log_warning "Network monitoring-network já existe"
    
    # Parar containers existentes se houver
    log_info "Parando containers existentes..."
    docker-compose down 2>/dev/null || true
    
    # Subir a stack
    log_info "Subindo a stack completa..."
    docker-compose up -d
    
    if [ $? -eq 0 ]; then
        log_success "Stack iniciada com sucesso!"
    else
        log_error "Erro ao iniciar a stack"
        exit 1
    fi
}

# Aguardar serviços ficarem prontos
wait_for_services() {
    log_info "Aguardando serviços ficarem prontos..."
    
    # Aguardar MySQL
    log_info "Aguardando MySQL..."
    sleep 30
    
    # Aguardar Zabbix (precisa mais tempo para criar tabelas)
    log_info "Aguardando Zabbix criar tabelas no banco (pode demorar até 10 minutos)..."
    sleep 60
    
    # Aguardar Grafana
    log_info "Aguardando Grafana..."
    sleep 20
    
    log_success "Primeira fase de inicialização concluída"
    log_info "IMPORTANTE: O Zabbix pode demorar até 10 minutos para estar totalmente operacional"
}

# Validar serviços
validate_services() {
    log_info "Validando serviços..."
    
    # Verificar containers
    log_info "Status dos containers:"
    docker-compose ps
    
    # Testar endpoints
    log_info "Testando endpoints..."
    
    # Grafana
    if curl -s http://localhost:3000/api/health >/dev/null 2>&1; then
        log_success "Grafana está respondendo"
    else
        log_warning "Grafana pode não estar pronto ainda"
    fi
    
    # Prometheus
    if curl -s http://localhost:9090/api/v1/status/config >/dev/null 2>&1; then
        log_success "Prometheus está respondendo"
    else
        log_warning "Prometheus pode não estar pronto ainda"
    fi
    
    # Zabbix (pode demorar mais para estar pronto)
    if curl -s http://localhost:8080 >/dev/null 2>&1; then
        log_success "Zabbix está respondendo"
    else
        log_warning "Zabbix pode não estar pronto ainda (aguarde mais 2-3 minutos)"
    fi
}

# Mostrar informações de acesso
show_access_info() {
    echo ""
    echo "🎉 Setup concluído! Acesse os serviços:"
    echo "========================================"
    echo ""
    echo "🌐 Zabbix Web Interface:"
    echo "   URL: http://localhost:8080"
    echo "   User: Admin"
    echo "   Password: zabbix"
    echo ""
    echo "📊 Grafana:"
    echo "   URL: http://localhost:3000"
    echo "   User: admin"
    echo "   Password: admin"
    echo ""
    echo "⚡ Prometheus:"
    echo "   URL: http://localhost:9090"
    echo ""
    echo "📈 Node Exporter:"
    echo "   URL: http://localhost:9100"
    echo ""
    echo "🗄️ MySQL Exporter:"
    echo "   URL: http://localhost:9104"
    echo ""
    echo "💡 Dicas:"
    echo "   - Aguarde 2-3 minutos para todos os serviços estarem 100% operacionais"
    echo "   - Use 'docker-compose logs -f [serviço]' para debug"
    echo "   - Use 'docker-compose down' para parar tudo"
    echo ""
}

# Menu principal
main() {
    case "${1:-setup}" in
        "setup")
            check_prerequisites
            check_ports
            setup_stack
            wait_for_services
            validate_services
            show_access_info
            ;;
        "start")
            log_info "Iniciando stack existente..."
            docker-compose up -d
            log_success "Stack iniciada!"
            ;;
        "stop")
            log_info "Parando stack..."
            docker-compose down
            log_success "Stack parada!"
            ;;
        "restart")
            log_info "Reiniciando stack..."
            docker-compose restart
            log_success "Stack reiniciada!"
            ;;
        "status")
            log_info "Status da stack:"
            docker-compose ps
            ;;
        "logs")
            docker-compose logs -f
            ;;
        "clean")
            log_warning "Removendo stack e volumes (PERDA DE DADOS!)..."
            read -p "Tem certeza? (y/N): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                docker-compose down -v
                docker network rm monitoring-network 2>/dev/null || true
                log_success "Limpeza concluída!"
            else
                log_info "Operação cancelada"
            fi
            ;;
        "help")
            echo "Uso: $0 [comando]"
            echo ""
            echo "Comandos disponíveis:"
            echo "  setup     - Setup completo da stack (padrão)"
            echo "  start     - Iniciar stack existente"
            echo "  stop      - Parar stack"
            echo "  restart   - Reiniciar stack"
            echo "  status    - Mostrar status dos containers"
            echo "  logs      - Mostrar logs em tempo real"
            echo "  clean     - Remover stack e volumes (CUIDADO!)"
            echo "  help      - Mostrar esta ajuda"
            ;;
        *)
            log_error "Comando inválido: $1"
            echo "Use '$0 help' para ver comandos disponíveis"
            exit 1
            ;;
    esac
}

# Executar função principal
main "$@"