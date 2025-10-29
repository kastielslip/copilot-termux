#!/bin/bash
###############################################################################
# GitHub Copilot CLI v0.0.346 - Termux Installer
# 
# Instalador automatico do GitHub Copilot CLI v0.0.346 para Termux ARM64
# Esta versao usa stubs diretos (mais simples e estavel)
#
# Autor: kastielslip
# Repositorio: https://github.com/kastielslip/copilot-termux
###############################################################################

set -e

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Funcoes de log
log_info() {
    echo -e "${CYAN}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[AVISO]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERRO]${NC} $1"
}

# Banner
clear
echo -e "${CYAN}"
cat << 'EOF'
  ____            _ _       _     
 / ___|___  _ __ (_) | ___ | |_   
| |   / _ \| '_ \| | |/ _ \| __|  
| |__| (_) | |_) | | | (_) | |_   
 \____\___/| .__/|_|_|\___/ \__|  
           |_|                     
   _____ _____ ____  _  _    __   
  / ____|___ /| __ )| || |  / /_  
 | |      |_ \|  _ \| || |_| '_ \ 
 | |___  ___) | |_) |__   _| (_) |
  \____|____/|____/    |_|  \___/ 
                                   
EOF
echo -e "${NC}"
echo -e "${BLUE}GitHub Copilot CLI v0.0.346 - Termux Installer${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""

# Verificar dependencias
log_info "Verificando dependencias..."
if ! command -v node &> /dev/null; then
    log_error "Node.js nao encontrado!"
    log_info "Instalando Node.js..."
    pkg install nodejs -y
fi

if ! command -v npm &> /dev/null; then
    log_error "npm nao encontrado!"
    exit 1
fi

log_success "Node.js $(node --version) e npm $(npm --version) disponiveis"
echo ""

# Verificar tarball
TARBALL="github-copilot-0.0.346.tgz"
log_info "Procurando tarball..."

if [ ! -f "$TARBALL" ]; then
    log_warning "Tarball nao encontrado no diretorio atual"
    log_info "Procurando em locais comuns..."
    
    # Procurar em locais comuns
    LOCATIONS=(
        "$HOME/$TARBALL"
        "$HOME/backups/$TARBALL"
        "/sdcard/$TARBALL"
        "/sdcard/Download/$TARBALL"
    )
    
    FOUND=false
    for loc in "${LOCATIONS[@]}"; do
        if [ -f "$loc" ]; then
            log_success "Encontrado em: $loc"
            cp "$loc" .
            FOUND=true
            break
        fi
    done
    
    if [ "$FOUND" = false ]; then
        log_error "Tarball nao encontrado!"
        log_info "Baixe o tarball:"
        echo "  curl -O https://registry.npmjs.org/@github/copilot/-/copilot-0.0.346.tgz"
        exit 1
    fi
fi

log_success "Tarball encontrado: $TARBALL"
echo ""

# Verificar integridade
log_info "Verificando integridade do tarball..."
if file "$TARBALL" | grep -q "gzip compressed"; then
    log_success "Tarball valido"
else
    log_error "Tarball corrompido!"
    exit 1
fi
echo ""

# Desinstalar versao anterior
log_info "Removendo instalacao anterior (se existir)..."
npm uninstall -g @github/copilot 2>/dev/null || true
rm -rf ~/.copilot-hooks 2>/dev/null || true
log_success "Limpeza concluida"
echo ""

# Instalar Copilot
log_info "Instalando GitHub Copilot CLI v0.0.346..."
npm install -g "$TARBALL"
log_success "Instalacao concluida"
echo ""

# Obter caminho de instalacao
COPILOT_PATH=$(npm root -g)/@github/copilot
log_info "Copilot instalado em: $COPILOT_PATH"
echo ""

# Criar stubs para node-pty
log_info "Criando stubs para node-pty..."
mkdir -p "$COPILOT_PATH/lib/node-pty-prebuilt-multiarch/lib"

cat > "$COPILOT_PATH/lib/node-pty-prebuilt-multiarch/lib/index.js" << 'ENDPTY'
// Stub para node-pty no Termux ARM64
// Este modulo emula a API do node-pty sem usar binarios nativos

class Terminal {
    constructor(shell, args, options) {
        this.shell = shell || process.env.SHELL || '/bin/sh';
        this.args = args || [];
        this.options = options || {};
        this.pid = process.pid;
        this._handlers = {};
    }
    
    on(event, callback) {
        this._handlers[event] = callback;
        return this;
    }
    
    write(data) {
        // Simular escrita
        return;
    }
    
    resize(cols, rows) {
        // Simular redimensionamento
        return;
    }
    
    kill(signal) {
        if (this._handlers['exit']) {
            this._handlers['exit'](0, null);
        }
    }
}

function spawn(shell, args, options) {
    return new Terminal(shell, args, options);
}

module.exports = {
    spawn: spawn,
    Terminal: Terminal
};
ENDPTY

log_success "Stub node-pty criado"
echo ""

# Criar stub para sharp
log_info "Criando stub para sharp..."
mkdir -p "$COPILOT_PATH/lib/sharp/lib"

cat > "$COPILOT_PATH/lib/sharp/lib/index.js" << 'ENDSHARP'
// Stub para sharp no Termux ARM64
// Este modulo emula a API basica do sharp sem processamento de imagens

function sharp(input, options) {
    return {
        resize: function() { return this; },
        jpeg: function() { return this; },
        png: function() { return this; },
        webp: function() { return this; },
        toBuffer: function(callback) {
            if (callback) callback(null, Buffer.alloc(0));
            return Promise.resolve(Buffer.alloc(0));
        },
        toFile: function(path, callback) {
            if (callback) callback(null, { size: 0 });
            return Promise.resolve({ size: 0 });
        }
    };
}

sharp.concurrency = function() {};
sharp.cache = function() {};

module.exports = sharp;
ENDSHARP

log_success "Stub sharp criado"
echo ""

# Criar package.json para stubs
log_info "Criando package.json para stubs..."

cat > "$COPILOT_PATH/lib/node-pty-prebuilt-multiarch/package.json" << 'ENDPKG1'
{
  "name": "node-pty-prebuilt-multiarch",
  "version": "0.11.14",
  "main": "lib/index.js"
}
ENDPKG1

cat > "$COPILOT_PATH/lib/sharp/package.json" << 'ENDPKG2'
{
  "name": "sharp",
  "version": "0.33.5",
  "main": "lib/index.js"
}
ENDPKG2

log_success "package.json criados"
echo ""

# Verificar instalacao
log_info "Verificando instalacao..."
if command -v copilot &> /dev/null; then
    VERSION=$(copilot --version 2>&1 | head -1 || echo "0.0.346")
    log_success "Copilot instalado com sucesso!"
    echo ""
    echo -e "${GREEN}Versao:${NC} $VERSION"
else
    log_error "Instalacao falhou!"
    exit 1
fi
echo ""

# Instrucoes finais
echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}✅ Instalacao concluida com sucesso!${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${YELLOW}📋 Proximos passos:${NC}"
echo ""
echo "1. Autentique-se no GitHub Copilot:"
echo -e "   ${BLUE}copilot auth login${NC}"
echo ""
echo "2. Teste o Copilot:"
echo -e "   ${BLUE}copilot explain \"ls -la\"${NC}"
echo ""
echo "3. Modo interativo:"
echo -e "   ${BLUE}copilot${NC}"
echo ""
echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
echo ""
