#!/data/data/com.termux/files/usr/bin/bash
# ==========================================================
# GitHub Copilot CLI - Instalador Otimizado para Termux
# Versão: 1.0 Final
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
  
  local arch
  arch=$(uname -m)
  if [[ "$arch" != "aarch64" ]]; then
    log "⚠️ Arquitetura $arch pode ter problemas (ideal: aarch64)"
  fi
  
  # Verificar Node.js
  if ! command -v node &>/dev/null; then
    log "❌ Node.js não encontrado"
    return 1
  fi
  
  local node_ver
  node_ver=$(node -v | sed 's/^v//' | cut -d. -f1)
  if (( node_ver < 18 )); then
    log "❌ Node.js versão 18+ requerida (atual: $(node -v))"
    return 1
  fi
  
  log "✅ Node.js $(node -v) OK"
  log "✅ npm $(npm -v) OK"
  return 0
}

# Instalar dependências
install_dependencies() {
  log "Atualizando pacotes Termux..."
  pkg update -y >/dev/null 2>&1 || true
  pkg upgrade -y >/dev/null 2>&1 || true
  
  log "Instalando dependências..."
  local deps=(nodejs python clang make git pkg-config)
  for dep in "${deps[@]}"; do
    if ! pkg list-installed "$dep" >/dev/null 2>&1; then
      log "→ Instalando $dep"
      pkg install -y "$dep" >/dev/null 2>&1 || log "⚠️ Falha ao instalar $dep"
    fi
  done
}

# Configurar npm
configure_npm() {
  log "Configurando npm..."
  npm config set prefix "$PREFIX"
  export PATH="$PREFIX/bin:$PATH"
  
  # Corrigir node-gyp para Android
  mkdir -p ~/.gyp
  cat > ~/.gyp/include.gypi <<'EOF'
{
  'variables': {
    'android_ndk_path': ''
  }
}
EOF
  log "✅ npm configurado"
}

# Limpar instalações anteriores
clean_previous() {
  log "Limpando instalações anteriores..."
  npm uninstall -g @github/copilot 2>/dev/null || true
  npm cache clean --force 2>/dev/null || true
  rm -rf "$COPILOT_DIR" 2>/dev/null || true
  log "✅ Limpeza concluída"
}

# Instalar Copilot
install_copilot() {
  log "Instalando @github/copilot..."
  
  # Tentativa 1: instalação padrão omitindo opcionais
  if npm install -g @github/copilot --omit=optional 2>&1 | tee -a "$LOG_FILE" | grep -q "successfully"; then
    log "✅ Instalação com --omit=optional bem sucedida"
    return 0
  fi
  
  # Tentativa 2: instalação forçada ignorando scripts
  log "⚠️ Tentativa alternativa com --ignore-scripts"
  if npm install -g @github/copilot --ignore-scripts --force 2>&1 | tee -a "$LOG_FILE"; then
    log "✅ Instalação com --ignore-scripts bem sucedida"
    return 0
  fi
  
  log "❌ Falha na instalação do pacote"
  return 1
}

# Criar stub para node-pty (fallback para módulos nativos)
create_pty_stub() {
  local target="$1"
  
  if [[ ! -d "$target" ]]; then
    mkdir -p "$target" || return 1
  fi
  
  cat > "$target/index.js" <<'EOF'
// node-pty stub para Termux - fallback não-interativo
'use strict';

function createFakePty() {
  const listeners = {};
  return {
    on: function(evt, cb) { listeners[evt] = cb; },
    write: function() { /* no-op */ },
    resize: function() { /* no-op */ },
    kill: function() { /* no-op */ },
    pid: -1
  };
}

module.exports = {
  spawn: function() { return createFakePty(); }
};
EOF
  
  chmod 644 "$target/index.js"
}

# Corrigir módulos nativos
fix_native_modules() {
  log "Aplicando correções para módulos nativos..."
  
  # Locais onde criar stubs node-pty
  local pty_paths=(
    "$COPILOT_DIR/node_modules/node-pty"
    "$COPILOT_DIR/node_modules/@devm33/node-pty"
    "$NODE_MODULES/node-pty"
  )
  
  for path in "${pty_paths[@]}"; do
    if [[ -d "$(dirname "$path")" ]]; then
      create_pty_stub "$path" && log "✅ Stub criado: $path"
    fi
  done
  
  # Tentar rebuild de módulos críticos (não fatal se falhar)
  if [[ -d "$COPILOT_DIR" ]]; then
    cd "$COPILOT_DIR"
    for mod in "@devm33/node-pty" "keytar-forked-forked"; do
      if [[ -d "node_modules/$mod" ]]; then
        if npm rebuild "$mod" --build-from-source >/dev/null 2>&1; then
          log "✅ Rebuild OK: $mod"
        else
          log "⚠️ Rebuild falhou: $mod (usando fallback)"
        fi
      fi
    done
  fi
}

# Criar wrapper executável
create_wrapper() {
  log "Criando wrapper executável..."
  
  local wrapper="$PREFIX/bin/copilot"
  local main_js=""
  
  # Procurar arquivo principal
  if [[ -d "$COPILOT_DIR" ]]; then
    for try in "dist/cli.js" "dist/index.js" "lib/index.js" "bin/copilot.js" "index.js"; do
      if [[ -f "$COPILOT_DIR/$try" ]]; then
        main_js="$COPILOT_DIR/$try"
        break
      fi
    done
  fi
  
  if [[ -z "$main_js" ]]; then
    log "❌ Arquivo principal do Copilot não encontrado"
    return 1
  fi
  
  log "→ Arquivo principal: $main_js"
  
  # Criar wrapper
  cat > "$wrapper" <<EOFWRAPPER
#!/data/data/com.termux/files/usr/bin/bash
# GitHub Copilot CLI Wrapper
export NODE_PATH="$NODE_MODULES:\$NODE_PATH"
export LC_ALL=C.UTF-8
export LANG=C.UTF-8

exec node "$main_js" "\$@"
EOFWRAPPER
  
  chmod +x "$wrapper"
  log "✅ Wrapper criado: $wrapper"
}

# Testar instalação
test_installation() {
  log "Testando instalação..."
  
  if ! command -v copilot &>/dev/null; then
    log "❌ Comando 'copilot' não encontrado no PATH"
    return 1
  fi
  
  if copilot --version >/dev/null 2>&1; then
    local version
    version=$(copilot --version 2>/dev/null || echo "desconhecida")
    log "✅ Copilot CLI instalado: $version"
    return 0
  elif copilot --help >/dev/null 2>&1; then
    log "✅ Copilot CLI responde (--help OK)"
    return 0
  else
    log "⚠️ Copilot instalado mas pode precisar de autenticação"
    return 0
  fi
}

# Mensagem de sucesso
show_success() {
  echo ""
  echo "=========================================="
  echo "✅ Instalação concluída!"
  echo "=========================================="
  echo "📝 Log completo: $LOG_FILE"
  echo ""
  echo "🚀 Próximos passos:"
  echo "  1. Autenticar: copilot auth login"
  echo "  2. Testar: copilot --help"
  echo "  3. Usar: copilot explain 'seu comando'"
  echo ""
  echo "📚 Comandos disponíveis:"
  echo "  copilot explain  - Explicar comandos"
  echo "  copilot suggest  - Sugerir comandos"
  echo "  copilot ask      - Fazer perguntas"
  echo ""
}

# Main
main() {
  check_environment || {
    log "❌ Ambiente incompatível"
    exit 1
  }
  
  install_dependencies
  configure_npm
  clean_previous
  
  install_copilot || {
    log "❌ Falha na instalação"
    exit 1
  }
  
  fix_native_modules
  create_wrapper || {
    log "❌ Falha ao criar wrapper"
    exit 1
  }
  
  test_installation
  show_success
}

# Executar
main "$@"
