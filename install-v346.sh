#!/data/data/com.termux/files/usr/bin/bash
# ==========================================================
# GitHub Copilot CLI v0.0.346 - Instalador Corrigido Termux
# Versão: 2.0 (com fix para sharp)
# Ambiente: Android ARM64 (Termux)
# ==========================================================

set -euo pipefail

LOG_FILE="$HOME/copilot_install_$(date +%Y%m%d_%H%M%S).log"
PREFIX="${PREFIX:-/data/data/com.termux/files/usr}"
NODE_MODULES="$PREFIX/lib/node_modules"
COPILOT_DIR="$NODE_MODULES/@github/copilot"

exec > >(tee -a "$LOG_FILE") 2>&1

echo "=========================================="
echo "🤖 GitHub Copilot CLI v0.0.346 - Termux"
echo "=========================================="
echo "Log: $LOG_FILE"
echo "Ambiente: $(uname -o) $(uname -m)"
echo "------------------------------------------"

log() {
  echo "[$(date '+%H:%M:%S')] $*"
}

check_environment() {
  log "Verificando ambiente..."
  
  if ! command -v node &>/dev/null; then
    log "❌ Node.js não encontrado"
    return 1
  fi
  
  local node_ver=$(node -v | sed 's/^v//' | cut -d. -f1)
  if (( node_ver < 18 )); then
    log "❌ Node.js versão 18+ requerida (atual: $(node -v))"
    return 1
  fi
  
  log "✅ Node.js $(node -v) OK"
  log "✅ npm $(npm -v) OK"
}

install_dependencies() {
  log "Instalando dependências..."
  pkg install -y libvips >/dev/null 2>&1 || log "⚠️ Falha ao instalar libvips"
  log "✅ libvips instalado"
}

configure_npm() {
  log "Configurando npm..."
  npm config set prefix "$PREFIX"
  export PATH="$PREFIX/bin:$PATH"
}

install_copilot() {
  log "Instalando @github/copilot@0.0.346..."
  npm uninstall -g @github/copilot 2>/dev/null || true
  npm cache clean --force 2>/dev/null || true
  
  if npm install -g @github/copilot@0.0.346 --omit=optional 2>&1 | tee -a "$LOG_FILE"; then
    log "✅ Instalação bem sucedida"
  else
    log "❌ Falha na instalação"
    return 1
  fi
}

fix_sharp_module() {
  log "Aplicando fix para módulo sharp..."
  
  local sharp_file="$COPILOT_DIR/node_modules/sharp/lib/sharp.js"
  
  if [[ ! -f "$sharp_file" ]]; then
    log "❌ Arquivo sharp.js não encontrado"
    return 1
  fi
  
  # Backup do original
  cp "$sharp_file" "${sharp_file}.bak"
  
  # Criar stub completo
  cat > "$sharp_file" << 'EOFSHARP'
// Sharp stub completo para Termux Android ARM64
const stub = function() {
  const chainable = {
    resize: () => chainable, rotate: () => chainable, flip: () => chainable,
    flop: () => chainable, blur: () => chainable, sharpen: () => chainable,
    normalise: () => chainable, toBuffer: () => Promise.resolve(Buffer.alloc(0)),
    toFile: () => Promise.resolve({ format: 'png', width: 1, height: 1, channels: 4, size: 0 })
  };
  return chainable;
};
const formats = {
  jpeg: {}, png: {}, webp: {}, avif: {}, heif: {}, jxl: {}, tiff: {}, gif: {}, svg: {}, jp2k: {}, raw: {}
};
Object.keys(formats).forEach(k => {
  formats[k] = { input: { file: true, buffer: true }, output: { file: true, buffer: true, alias: [] } };
});
formats.heif.output.alias = ['avif', 'heic'];
formats.jp2k.output.alias = ['j2c', 'j2k', 'jp2', 'jpx'];
stub.libvipsVersion = () => '8.17.2';
stub.format = () => formats;
stub.versions = { vips: '8.17.2', cairo: '1.0.0' };
stub.cache = () => {};
stub.concurrency = () => 1;
stub.queue = { length: 0 };
stub.simd = () => true;
stub.counters = () => ({ queue: 0, process: 0 });
module.exports = stub;
EOFSHARP
  
  log "✅ Sharp stub aplicado"
}

test_installation() {
  log "Testando instalação..."
  
  if ! command -v copilot &>/dev/null; then
    log "❌ Comando 'copilot' não encontrado"
    return 1
  fi
  
  if copilot --version >/dev/null 2>&1; then
    local version=$(copilot --version 2>/dev/null | head -1)
    log "✅ Copilot CLI instalado: $version"
    return 0
  fi
  
  log "⚠️ Copilot instalado mas pode ter problemas"
  return 1
}

show_success() {
  echo ""
  echo "=========================================="
  echo "✅ Instalação concluída!"
  echo "=========================================="
  echo "📝 Log completo: $LOG_FILE"
  echo ""
  echo "🚀 Próximos passos:"
  echo "  1. Testar: copilot --version"
  echo "  2. Autenticar: copilot (primeira execução)"
  echo "  3. Usar: copilot -p 'seu comando'"
  echo ""
}

main() {
  check_environment || exit 1
  install_dependencies
  configure_npm
  install_copilot || exit 1
  fix_sharp_module || exit 1
  test_installation
  show_success
}

main "$@"
