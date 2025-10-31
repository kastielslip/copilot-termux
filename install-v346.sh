#!/data/data/com.termux/files/usr/bin/bash
# ==========================================================
# GitHub Copilot CLI - Instalador Corrigido para Termux
# Versão: 1.1 - Com Sharp Stub para Android ARM64
# Ambiente: Android ARM64 (Termux)
# ==========================================================

set -euo pipefail

# Configurações
LOG_FILE="$HOME/copilot_install_$(date +%Y%m%d_%H%M%S).log"
PREFIX="${PREFIX:-/data/data/com.termux/files/usr}"
NODE_MODULES="$PREFIX/lib/node_modules"
COPILOT_DIR="$NODE_MODULES/@github/copilot"

# Redirecionar output para log e console
exec > >(tee -a "$LOG_FILE") 2>&1

echo "=========================================="
echo "🤖 GitHub Copilot CLI - Instalador Termux"
echo "=========================================="
echo "Log: $LOG_FILE"
echo "Ambiente: $(uname -o) $(uname -m)"
echo "------------------------------------------"

# Função de log
log() {
  echo "[$(date '+%H:%M:%S')] $*"
}

# Verificar ambiente
check_environment() {
  log "Verificando ambiente..."
  
  if ! command -v node &>/dev/null; then
    log "❌ Node.js não encontrado"
    echo "Execute: pkg install nodejs"
    exit 1
  fi
  
  local node_ver
  node_ver=$(node -v | sed 's/^v//' | cut -d. -f1)
  if (( node_ver < 18 )); then
    log "❌ Node.js versão 18+ requerida (atual: $(node -v))"
    exit 1
  fi
  
  log "✅ Node.js $(node -v) OK"
  log "✅ npm $(npm -v) OK"
}

# Instalar dependências
install_dependencies() {
  log "Instalando dependências..."
  
  pkg install -y libvips git wget >/dev/null 2>&1 || log "⚠️ Algumas dependências falharam"
  log "✅ Dependências instaladas"
}

# Limpar instalações anteriores
clean_previous() {
  log "Limpando instalações anteriores..."
  npm uninstall -g @github/copilot 2>/dev/null || true
  npm cache clean --force 2>/dev/null || true
  log "✅ Limpeza concluída"
}

# Instalar Copilot
install_copilot() {
  log "Instalando @github/copilot@0.0.346..."
  
  if npm install -g @github/copilot@0.0.346 --ignore-scripts --force 2>&1 | tee -a "$LOG_FILE"; then
    log "✅ Instalação concluída"
    return 0
  fi
  
  log "❌ Falha na instalação"
  return 1
}

# Criar stub para Sharp (módulo de imagens)
create_sharp_stub() {
  log "Criando stub para módulo sharp..."
  
  local sharp_file="$COPILOT_DIR/node_modules/sharp/lib/sharp.js"
  
  if [[ ! -f "$sharp_file" ]]; then
    log "⚠️ Sharp não encontrado, pulando"
    return 0
  fi
  
  cat > "$sharp_file" << 'EOFSHARP'
// Sharp stub completo para Termux Android ARM64
'use strict';

const formats = {
  jpeg: { id: 'jpeg', output: { alias: ['jpg', 'jpeg'] } },
  png: { id: 'png', output: { alias: ['png'] } },
  webp: { id: 'webp', output: { alias: ['webp'] } },
  avif: { id: 'avif', output: { alias: ['avif'] } },
  heif: { id: 'heif', output: { alias: ['heif', 'heic'] } },
  jxl: { id: 'jxl', output: { alias: ['jxl'] } },
  tiff: { id: 'tiff', output: { alias: ['tiff', 'tif'] } },
  gif: { id: 'gif', output: { alias: ['gif'] } },
  svg: { id: 'svg', output: { alias: ['svg'] } },
  jp2k: { id: 'jp2k', output: { alias: ['jp2', 'j2k'] } },
  raw: { id: 'raw', output: { alias: ['raw'] } }
};

const sharp = () => ({
  metadata: () => Promise.resolve({ format: 'png', width: 100, height: 100 }),
  toBuffer: () => Promise.resolve(Buffer.alloc(0)),
  toFile: () => Promise.resolve({ size: 0 }),
  resize: function() { return this; },
  extract: function() { return this; },
  trim: function() { return this; },
  extend: function() { return this; },
  flatten: function() { return this; },
  unflatten: function() { return this; },
  negate: function() { return this; },
  normalise: function() { return this; },
  normalize: function() { return this; },
  clahe: function() { return this; },
  convolve: function() { return this; },
  threshold: function() { return this; },
  boolean: function() { return this; },
  linear: function() { return this; },
  recomb: function() { return this; },
  modulate: function() { return this; },
  tint: function() { return this; },
  greyscale: function() { return this; },
  grayscale: function() { return this; },
  pipelineColourspace: function() { return this; },
  pipelineColorspace: function() { return this; },
  toColourspace: function() { return this; },
  toColorspace: function() { return this; }
});

// sharp.format como função e propriedade
sharp.format = Object.assign(
  () => formats,
  formats
);

sharp.versions = {
  vips: '8.17.2'
};

sharp.libvipsVersion = () => '8.17.2';
sharp.cache = () => ({ memory: 0, files: 0, items: 0 });
sharp.concurrency = () => 1;
sharp.queue = { length: 0 };
sharp.simd = () => false;
sharp.counters = () => ({ queue: 0, process: 0 });

module.exports = sharp;
EOFSHARP

  log "✅ Sharp stub criado"
}

# Testar instalação
test_installation() {
  log "Testando instalação..."
  
  if ! command -v copilot &>/dev/null; then
    log "❌ Comando copilot não encontrado"
    return 1
  fi
  
  local version
  version=$(copilot --version 2>&1 | head -1)
  
  if [[ -z "$version" ]]; then
    log "❌ Erro ao executar copilot"
    return 1
  fi
  
  log "✅ Copilot instalado: $version"
  return 0
}

# Executar instalação
main() {
  check_environment
  install_dependencies
  clean_previous
  install_copilot
  create_sharp_stub
  
  echo ""
  echo "=========================================="
  
  if test_installation; then
    echo "✅ Instalação concluída com sucesso!"
    echo "=========================================="
    echo ""
    echo "Próximos passos:"
    echo "  1. copilot --help    - Ver ajuda"
    echo "  2. copilot           - Iniciar Copilot"
    echo "  3. copilot -p '...'  - Prompt direto"
    echo ""
  else
    echo "❌ Instalação com problemas"
    echo "=========================================="
    echo "Veja o log: $LOG_FILE"
    exit 1
  fi
}

main "$@"
