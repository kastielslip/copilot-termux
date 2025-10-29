#!/data/data/com.termux/files/usr/bin/bash
# GitHub Copilot CLI v0.0.353 - Instalador Automático
# Autor: kastielslip
# Data: 29/10/2025

echo "🚀 GitHub Copilot CLI v0.0.353 - Instalador para Termux"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Verificar Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js não encontrado!"
    echo "Execute: pkg install nodejs"
    exit 1
fi

echo "✅ Node.js $(node --version)"
echo ""

# Baixar tarball (se não existir)
if [ ! -f "github-copilot-0.0.353.tgz" ]; then
    echo "📥 Baixe o tarball v0.0.353 de:"
    echo "   https://registry.npmjs.org/@github/copilot/-/copilot-0.0.353.tgz"
    echo ""
    echo "❌ Tarball não encontrado no diretório atual"
    exit 1
fi

echo "✅ Tarball encontrado"
echo ""

# Instalar
echo "📦 Instalando Copilot v0.0.353..."
npm install -g ./github-copilot-0.0.353.tgz --ignore-scripts --force

if [ $? -ne 0 ]; then
    echo "❌ Erro na instalação!"
    exit 1
fi

echo "✅ Instalação concluída"
echo ""

# Criar hook
echo "🔧 Criando hook Module._load..."
mkdir -p ~/.copilot-hooks
cp hooks/bypass-final.js ~/.copilot-hooks/

echo "✅ Hook criado"
echo ""

# Configurar NODE_OPTIONS
echo "⚙️  Configurando NODE_OPTIONS..."
if ! grep -q "NODE_OPTIONS.*bypass-final" ~/.bashrc; then
    echo 'export NODE_OPTIONS="--require $HOME/.copilot-hooks/bypass-final.js"' >> ~/.bashrc
    echo "✅ Adicionado ao ~/.bashrc"
else
    echo "✅ Já configurado no ~/.bashrc"
fi

# Ativar na sessão atual
export NODE_OPTIONS="--require $HOME/.copilot-hooks/bypass-final.js"

echo ""
echo "🧪 Testando instalação..."
copilot --version

if [ $? -eq 0 ]; then
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "🎉 INSTALAÇÃO CONCLUÍDA COM SUCESSO!"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "📝 Próximos passos:"
    echo "   1. Reinicie o Termux ou execute: source ~/.bashrc"
    echo "   2. Autentique: copilot auth login"
    echo "   3. Use: copilot explain 'seu comando aqui'"
    echo ""
else
    echo ""
    echo "❌ Erro ao testar. Verifique os logs."
fi
