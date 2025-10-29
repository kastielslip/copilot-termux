# 🚀 GitHub Copilot CLI para Termux

[![Status](https://img.shields.io/badge/Status-100%25%20Funcional-success)]()
[![Versão0.0.346](https://img.shields.io/badge/v0.0.346-Estável-blue)]()
[![Versão0.0.353](https://img.shields.io/badge/v0.0.353-Funcional-green)]()
[![Platform](https://img.shields.io/badge/Platform-Termux%20ARM64-orange)]()

Instalação completa e funcional do GitHub Copilot CLI v0.0.346 e v0.0.353 no Termux (Android ARM64).

## ✨ Destaques

- ✅ **Duas versões disponíveis**: 0.0.346 (estável) e 0.0.353 (avançada)
- ✅ **100% funcional** em Termux Android ARM64
- ✅ **Stubs JavaScript** para módulos nativos (node-pty e sharp)
- ✅ **Module._load hooks** para bypass de binários (v0.0.353)
- ✅ **Scripts automatizados** de instalação e restauração
- ✅ **Documentação completa** em português

## 📦 Versões Disponíveis

### v0.0.346 - Estável (Recomendado)
- **Tamanho**: 10 MB
- **Método**: Stubs diretos em `lib/`
- **Complexidade**: Baixa
- **Ideal para**: Uso diário, primeira instalação

### v0.0.353 - Avançada
- **Tamanho**: 71 MB
- **Método**: Hook `Module._load`
- **Complexidade**: Média
- **Ideal para**: Usuários avançados, última versão

## 🚀 Instalação Rápida

### Opção 1: v0.0.346 (Recomendado)

\`\`\`bash
# 1. Clone o repositório
git clone https://github.com/kastielslip/copilot-termux.git
cd copilot-termux

# 2. Execute o instalador
bash install-v346.sh

# 3. Teste
copilot --version
\`\`\`

### Opção 2: v0.0.353 (Avançada)

\`\`\`bash
# 1. Clone o repositório
git clone https://github.com/kastielslip/copilot-termux.git
cd copilot-termux

# 2. Execute o instalador
bash install-v353.sh

# 3. Configure NODE_OPTIONS
export NODE_OPTIONS="--require $HOME/.copilot-hooks/bypass-final.js"

# 4. Adicione ao .bashrc para tornar permanente
echo 'export NODE_OPTIONS="--require $HOME/.copilot-hooks/bypass-final.js"' >> ~/.bashrc

# 5. Teste
copilot --version
\`\`\`

## 📚 Documentação

- [Instalação Detalhada](docs/INSTALLATION.md)
- [Como Funciona](docs/HOW_IT_WORKS.md)
- [Comparação de Versões](docs/COMPARISON.md)
- [Troubleshooting](docs/TROUBLESHOOTING.md)
- [FAQ](docs/FAQ.md)

## 🎯 Uso

\`\`\`bash
# Autenticar no GitHub
copilot auth login

# Explicar comando
copilot explain "ls -la | grep txt"

# Sugerir comando
copilot suggest "find all PDF files modified today"

# Ajuda
copilot --help
\`\`\`

## 🔧 Requisitos

- Termux (Android)
- Node.js v18+ (\`pkg install nodejs\`)
- NPM (\`pkg install nodejs-lts\`)
- Git (\`pkg install git\`)
- Espaço: ~100MB livres

## 🏗️ Estrutura do Projeto

```
copilot-termux/
├── install-v346.sh          # Instalador v0.0.346
├── install-v353.sh          # Instalador v0.0.353
├── hooks/
│   └── bypass-final.js      # Hook Module._load (v0.0.353)
├── patches/
│   ├── node-pty-stub.js     # Stub node-pty (v0.0.346)
│   └── sharp-stub.js        # Stub sharp (v0.0.346)
├── docs/
│   ├── INSTALLATION.md
│   ├── HOW_IT_WORKS.md
│   ├── COMPARISON.md
│   ├── TROUBLESHOOTING.md
│   └── FAQ.md
└── README.md
```

## 🤝 Contribuindo

Contribuições são bem-vindas! Sinta-se à vontade para:
- Reportar bugs
- Sugerir melhorias
- Enviar pull requests
- Compartilhar experiências

## 📜 Licença

MIT License - Veja [LICENSE](LICENSE) para detalhes

## 🙏 Agradecimentos

- GitHub pelo Copilot CLI
- Comunidade Termux
- Todos que testaram e reportaram bugs

## ⚠️ Avisos

- Copilot CLI requer assinatura GitHub Copilot
- Não inclui tarballs (baixe oficialmente)
- Use por sua própria conta e risco
- Testado em Termux ARM64 Android

---

**Desenvolvido com persistência e muitos testes! 🚀**

**Se este projeto foi útil, considere dar uma ⭐!**
