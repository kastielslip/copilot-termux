<div align="center">

# 🤖 GitHub Copilot CLI para Termux

[![Termux](https://img.shields.io/badge/Termux-000000?style=for-the-badge&logo=android&logoColor=white)](https://termux.com)
[![Node.js](https://img.shields.io/badge/Node.js-43853D?style=for-the-badge&logo=node.js&logoColor=white)](https://nodejs.org)
[![Stars](https://img.shields.io/github/stars/kastielslip/copilot-termux?style=for-the-badge)](https://github.com/kastielslip/copilot-termux)

### *IA da Microsoft rodando 100% no seu Android*

[📥 Instalação](#-instalação-rápida) • [✨ Características](#-características) • [🎯 Uso](#-como-usar) • [🐛 Troubleshooting](#-troubleshooting)

</div>

---

## 🚀 Instalação Rápida

> **Instalação com 1 comando - Totalmente automática**

```bash
curl -fsSL https://raw.githubusercontent.com/kastielslip/copilot-termux/master/install.sh | bash
```

<details>
<summary><b>📦 Ou escolha uma versão específica</b></summary>

### Versão 0.0.353 (mais recente)
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/kastielslip/copilot-termux/master/install.sh) 0.0.353
```

### Versão 0.0.346 (estável)
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/kastielslip/copilot-termux/master/install.sh) 0.0.346
```

</details>

---

## ✨ Características

<table>
<tr>
<td>

### 🎯 Automação Completa
- ✅ Download automático
- ✅ Instalação zero-config
- ✅ Bypass de módulos nativos
- ✅ Configuração automática

</td>
<td>

### 🔧 Recursos Técnicos
- ✅ Detecção de sistema
- ✅ Multi-versão
- ✅ Logs detalhados
- ✅ Fallback inteligente

</td>
</tr>
</table>

---

## 🎯 Como Usar

### Após instalação:

> ⚠️ **Reinicie o terminal antes de usar**

```bash
exit
```

### Comandos:

**Ver versão:**
```bash
copilot --version
```

**Ver ajuda:**
```bash
copilot --help
```

**Modo interativo:**
```bash
copilot
```

**Prompt direto:**
```bash
copilot -p "como listar arquivos no linux?"
```

---

## 🔧 Arquitetura

### Bypass de Módulos Nativos

**Arquivo:** `~/.copilot-hooks/bypass-final.js`

```javascript
const Module = require('module');
const originalLoad = Module._load;

Module._load = function(request, parent) {
  if (request.includes('pty.node')) {
    return { spawn: () => ({ pid: 9999, on: () => {}, write: () => true }) };
  }
  if (request.includes('sharp')) {
    return sharpStub;
  }
  return originalLoad.apply(this, arguments);
};
```

### Estrutura:

```
~/.copilot-hooks/bypass-final.js    # Bypass
~/.bashrc                            # NODE_OPTIONS
~/copilot-install-*.log              # Logs
```

---

## 🐛 Troubleshooting

### Erro: "Cannot find module"

```bash
source ~/.bashrc
echo $NODE_OPTIONS
```

### Erro: "Failed to load native module"

```bash
curl -fsSL https://raw.githubusercontent.com/kastielslip/copilot-termux/master/install.sh | bash
```

### Ver logs:

```bash
cat ~/copilot-install-*.log | less
```

---

## 🔄 Atualização

```bash
npm uninstall -g @github/copilot
bash <(curl -fsSL https://raw.githubusercontent.com/kastielslip/copilot-termux/master/install.sh) 0.0.353
```

---

## 📊 Compatibilidade

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

[![GitHub](https://img.shields.io/badge/GitHub-kastielslip-181717?style=for-the-badge&logo=github)](https://github.com/kastielslip)

</div>
