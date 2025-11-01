<div align="center">

# 🤖 GitHub Copilot CLI para Termux

[![Termux](https://img.shields.io/badge/Termux-000000?style=for-the-badge&logo=android&logoColor=white)](https://termux.com)
[![Node.js](https://img.shields.io/badge/Node.js-43853D?style=for-the-badge&logo=node.js&logoColor=white)](https://nodejs.org)
[![Stars](https://img.shields.io/github/stars/kastielslip/copilot-termux?style=for-the-badge)](https://github.com/kastielslip/copilot-termux)

### *IA da Microsoft rodando 100% no seu Android*

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

## 📚 DOCUMENTAÇÃO

Tá, mas como isso funciona? Aqui tem tudo explicado de forma clara (sem manual chato de 500 páginas):

<div align="center">

### [📖 COMO FUNCIONA](https://raw.githack.com/kastielslip/copilot-termux/master/docs/COMO_FUNCIONA.html)

Arquitetura detalhada do sistema de bypass e como o Copilot funciona no Termux.

**Tópicos:**
- Sistema de bypass de módulos nativos
- Arquitetura do node-pty e sharp
- Fluxo de instalação
- Estrutura de arquivos
- Variáveis de ambiente


### [🔧 GUIA DE INSTALAÇÃO](https://raw.githack.com/kastielslip/copilot-termux/master/docs/INSTALACAO.html)

Guia completo passo a passo da instalação.

**Tópicos:**
- Instalação automática
- Instalação manual
- Configuração do ambiente
- Verificação da instalação
- Primeiros comandos


### [🛠️ SOLUÇÃO DE PROBLEMAS](https://raw.githack.com/kastielslip/copilot-termux/master/docs/TROUBLESHOOTING.html)


Solução de problemas comuns e erros.

**Tópicos:**
- Erros de módulos nativos
- Problemas com NODE_OPTIONS
- Erros de autenticação
- Performance e otimização
- Logs e diagnóstico

---

</div>


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
