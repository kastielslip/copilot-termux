<div align="center">

![GitHub Copilot](https://img.shields.io/badge/GitHub_Copilot-000000?style=for-the-badge&logo=github&logoColor=white)

# 🤖 GitHub Copilot CLI para Termux

### *IA da Microsoft rodando 100% no seu Android*

[![Termux](https://img.shields.io/badge/Termux-000000?style=flat-square&logo=android&logoColor=white)](https://termux.com)
[![Node.js](https://img.shields.io/badge/Node.js-43853D?style=flat-square&logo=node.js&logoColor=white)](https://nodejs.org)
[![ARM64](https://img.shields.io/badge/ARM64-0091BD?style=flat-square&logo=arm&logoColor=white)](https://www.arm.com)

---

## 🚀 Instalação Rápida (1 Comando)

```bash
curl -fsSL https://raw.githubusercontent.com/kastielslip/copilot-termux/master/install.sh | bash
```

**Ou com versão específica:**
```bash
# Versão 0.0.353 (mais recente)
bash <(curl -fsSL https://raw.githubusercontent.com/kastielslip/copilot-termux/master/install.sh)

# Versão 0.0.346 (estável)
bash <(curl -fsSL https://raw.githubusercontent.com/kastielslip/copilot-termux/master/install.sh) 0.0.346
```

---

## ✨ Características

- ✅ **100% Automático** - Download, instalação e configuração completa
- ✅ **Bypass Inteligente** - Contorna limitações de módulos nativos (pty, sharp)
- ✅ **Multi-versão** - Suporta v0.0.346, v0.0.353 e futuras versões
- ✅ **Zero Configuração Manual** - Tudo configurado automaticamente
- ✅ **Detecção de Sistema** - Verifica arquitetura e dependências
- ✅ **Logs Detalhados** - Acompanhe cada etapa da instalação

---

## 🎯 Como Usar

```bash
# Após instalação, reinicie o terminal
exit

# Ver ajuda
copilot --help

# Modo interativo
copilot

# Executar prompt direto
copilot -p "como listar arquivos no linux?"
```

---

## 🔧 Como Funciona

1. **Detecção Automática** - Verifica Android/Termux e arquitetura
2. **Download Inteligente** - Baixa tarball direto do npm registry
3. **Bypass de Módulos** - Cria stubs para node-pty e sharp
4. **Configuração Automática** - Configura NODE_OPTIONS no .bashrc

---

## 📁 Arquivos Criados

```
~/.copilot-hooks/bypass-final.js  # Bypass para módulos nativos
~/.bashrc                          # NODE_OPTIONS configurado
~/copilot-install-*.log            # Logs de instalação
```

---

## 🐛 Troubleshooting

```bash
# Verificar NODE_OPTIONS
echo $NODE_OPTIONS

# Recarregar configuração
source ~/.bashrc

# Ver logs
ls ~/copilot-install-*.log
```

---

## 📊 Status

| Versão | Status | Testado |
|--------|--------|---------|
| 0.0.346 | ✅ Estável | Android 11+ ARM64 |
| 0.0.353 | ✅ Funcional | Android 11+ ARM64 |

---

## 📜 Licença

MIT License - [LICENSE](LICENSE)

---

<div align="center">

**Feito com ☕ por [kastielslip](https://github.com/kastielslip)**

</div>
