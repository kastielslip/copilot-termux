#!/data/data/com.termux/files/usr/bin/bash
################################################################################
# GitHub Copilot CLI - Instalador Automático Completo para Termux
# Versão: 2.0 - Totalmente Automatizado
# Data: 2025-10-31
# Suporta: v0.0.346 (estável) e v0.0.353 (mais recente)
################################################################################

set -euo pipefail

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configurações
VERSION="${1:-0.0.353}"  # Versão padrão: 0.0.353
LOG_FILE="$HOME/copilot-install-$(date +%Y%m%d_%H%M%S).log"
TEMP_DIR="$HOME/.copilot-temp"
HOOKS_DIR="$HOME/.copilot-hooks"

# URLs
TARBALL_URL="https://registry.npmjs.org/@github/copilot/-/copilot-${VERSION}.tgz"

echo -e "${BLUE}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  🤖 GitHub Copilot CLI - Instalador Automático          ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}📦 Versão selecionada: ${VERSION}${NC}"
echo -e "${YELLOW}📝 Log: ${LOG_FILE}${NC}"
echo ""

# Redirecionar para log
exec > >(tee -a "$LOG_FILE") 2>&1

# Função de log
log() {
    echo -e "${GREEN}[$(date '+%H:%M:%S')]${NC} $*"
}

error() {
    echo -e "${RED}[ERRO]${NC} $*"
    exit 1
}

warning() {
    echo -e "${YELLOW}[AVISO]${NC} $*"
}

# 1. Detectar sistema
log "🔍 Detectando sistema..."
ARCH=$(uname -m)
OS=$(uname -o)
NODE_VERSION=$(node -v 2>/dev/null || echo "não instalado")

echo "   • Arquitetura: $ARCH"
echo "   • OS: $OS"
echo "   • Node.js: $NODE_VERSION"
echo ""

# 2. Verificar requisitos
log "✅ Verificando requisitos..."

if [ "$OS" != "Android" ]; then
    error "Este instalador é exclusivo para Termux/Android"
fi

if [ "$ARCH" != "aarch64" ]; then
    warning "Arquitetura $ARCH pode ter problemas (ideal: aarch64)"
fi

if ! command -v node &>/dev/null; then
    log "📥 Instalando Node.js..."
    pkg install -y nodejs || error "Falha ao instalar Node.js"
fi

if ! command -v wget &>/dev/null; then
    log "📥 Instalando wget..."
    pkg install -y wget || error "Falha ao instalar wget"
fi

if ! command -v git &>/dev/null; then
    log "📥 Instalando git..."
    pkg install -y git || error "Falha ao instalar git"
fi

# 3. Limpar instalações anteriores
log "🧹 Limpando instalações anteriores..."
npm uninstall -g @github/copilot 2>/dev/null || true
rm -rf "$TEMP_DIR" "$HOOKS_DIR"
mkdir -p "$TEMP_DIR" "$HOOKS_DIR"

# 4. Download do tarball
log "📥 Baixando Copilot v${VERSION}..."
cd "$TEMP_DIR"
if ! wget -q --show-progress "$TARBALL_URL" -O "copilot-${VERSION}.tgz"; then
    error "Falha ao baixar o tarball de ${TARBALL_URL}"
fi

# 5. Instalar o pacote
log "�� Instalando @github/copilot@${VERSION}..."
npm install -g "./copilot-${VERSION}.tgz" --ignore-scripts --force 2>&1 | grep -v "npm WARN" || true

# 6. Criar bypass-final.js
log "🔧 Criando bypass para módulos nativos..."
cat > "$HOOKS_DIR/bypass-final.js" << 'ENDBYPASS'
const Module = require('module');
const originalLoad = Module._load;

console.log('[BYPASS] Copilot Termux v2.0 - Módulos nativos');

Module._load = function(request, parent) {
  // Bypass para node-pty
  if (request.includes('pty.node') || request.includes('node-pty')) {
    return {
      spawn: () => ({ 
        pid: 9999, 
        on: () => ({}), 
        write: () => true, 
        resize: () => {}, 
        kill: () => {} 
      }),
      Terminal: class { 
        constructor() { this.pid = 9999; } 
        on() { return this; } 
        write() { return true; } 
        resize() {} 
        kill() {} 
      }
    };
  }
  
  // Bypass para sharp
  if (request.includes('sharp') && !request.endsWith('sharp.js')) {
    class Sharp {
      constructor(input, options) {
        this.options = options || {};
        this.input = input;
      }
      resize() { return this; }
      extract() { return this; }
      trim() { return this; }
      extend() { return this; }
      flatten() { return this; }
      negate() { return this; }
      normalize() { return this; }
      toBuffer(callback) {
        const buffer = Buffer.from('');
        const info = { format: 'raw', width: 0, height: 0, channels: 0, size: 0 };
        if (callback) callback(null, buffer, info);
        return Promise.resolve(buffer);
      }
      toFile(path, callback) {
        const info = { format: 'raw', width: 0, height: 0, size: 0 };
        if (callback) callback(null, info);
        return Promise.resolve(info);
      }
      metadata(callback) {
        const meta = { format: 'raw', width: 0, height: 0, channels: 0 };
        if (callback) callback(null, meta);
        return Promise.resolve(meta);
      }
      clone() { return new Sharp(this.input, this.options); }
    }
    
    const sharp = (input, options) => new Sharp(input, options);
    const formatDef = {
      input: { file: true, buffer: true, stream: true },
      output: { file: true, buffer: true, stream: true, alias: [] }
    };
    
    sharp.cache = () => ({});
    sharp.concurrency = () => 1;
    sharp.counters = () => ({});
    sharp.simd = () => false;
    sharp.format = () => ({
      jpeg: formatDef,
      png: formatDef,
      webp: formatDef,
      tiff: formatDef,
      gif: formatDef,
      svg: formatDef,
      avif: formatDef,
      heif: { ...formatDef, output: { ...formatDef.output, alias: ['heic'] } },
      jp2k: { ...formatDef, output: { ...formatDef.output, alias: ['jp2', 'j2k'] } },
      jxl: formatDef,
      raw: formatDef
    });
    sharp.versions = { vips: '8.17.0', sharp: '0.33.0' };
    sharp.libvipsVersion = () => '8.17.0';
    sharp.vendor = { platform: 'linux', arch: 'arm64' };
    
    return sharp;
  }
  
  return originalLoad.apply(this, arguments);
};
ENDBYPASS

# 7. Configurar .bashrc
log "⚙️  Configurando variáveis de ambiente..."

# Remover configurações antigas
sed -i '/NODE_OPTIONS.*bypass-final/d' ~/.bashrc
sed -i '/NODE_OPTIONS.*copilot/d' ~/.bashrc
sed -i '/LD_PRELOAD.*libandroid/d' ~/.bashrc

# Adicionar nova configuração
cat >> ~/.bashrc << 'ENDBASHRC'

# GitHub Copilot CLI - Bypass para módulos nativos
export NODE_OPTIONS="--require $HOME/.copilot-hooks/bypass-final.js"
ENDBASHRC

# Ativar na sessão atual
export NODE_OPTIONS="--require $HOME/.copilot-hooks/bypass-final.js"

# 8. Limpar temp
log "🧹 Limpando arquivos temporários..."
rm -rf "$TEMP_DIR"

# 9. Testar instalação
log "🧪 Testando instalação..."
echo ""

if ! command -v copilot &>/dev/null; then
    error "Comando 'copilot' não encontrado após instalação"
fi

INSTALLED_VERSION=$(copilot --version 2>&1 | head -1 || echo "erro")

echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  ✅ INSTALAÇÃO CONCLUÍDA COM SUCESSO!                    ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}📦 Versão instalada:${NC} ${INSTALLED_VERSION}"
echo -e "${BLUE}📁 Hooks:${NC} ~/.copilot-hooks/bypass-final.js"
echo -e "${BLUE}📝 Log completo:${NC} ${LOG_FILE}"
echo ""
echo -e "${YELLOW}⚠️  IMPORTANTE:${NC}"
echo -e "   ${YELLOW}Reinicie o terminal ou execute:${NC}"
echo -e "   ${GREEN}source ~/.bashrc${NC}"
echo ""
echo -e "${BLUE}🚀 Próximos passos:${NC}"
echo -e "   1. ${GREEN}copilot --help${NC}     - Ver ajuda"
echo -e "   2. ${GREEN}copilot${NC}            - Iniciar Copilot"
echo -e "   3. ${GREEN}copilot -p 'texto'${NC} - Executar prompt"
echo ""
