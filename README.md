<div align="center">

![Mr Robot](https://media.giphy.com/media/dLolp8dtrYCJi/giphy.gif)

# 🤖 COPILOT NO TERMUX
### *"Hello, friend. Bem-vindo ao futuro da programação mobile."*

[![Termux](https://img.shields.io/badge/Termux-000000?style=for-the-badge&logo=android&logoColor=white)](https://termux.com)
[![GitHub Copilot](https://img.shields.io/badge/GitHub_Copilot-000000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/features/copilot)
[![Node.js](https://img.shields.io/badge/Node.js-43853D?style=for-the-badge&logo=node.js&logoColor=white)](https://nodejs.org)
[![ARM64](https://img.shields.io/badge/ARM64-0091BD?style=for-the-badge&logo=arm&logoColor=white)](https://www.arm.com/)

---

</div>

## 💀 O QUE É ISSO?

Cara, cansa não poder usar o Copilot no celular? Pois é, eu também cansei. Então resolvi o problema.

Este projeto traz o **GitHub Copilot CLI** funcionando 100% no **Termux** (Android ARM64). Sim, aquela IA da Microsoft rodando no seu celular. Sem gambiarra, sem desktop, sem cloud. Tudo local, tudo seu.

## 📦 O que tem aqui

- **Scripts de instalação testados e funcionando**
- **Patches para node-pty e sharp**
- **Duas versões disponíveis: v0.0.346 (estável) e v0.0.353 (em testes)**
- **Documentação completa de como instalar**
- **Backup dos tarballs originais**

## ⚡ INSTALAÇÃO RÁPIDA

### Opção 1: v0.0.353 (Última versão - experimental)
```bash
curl -o install-v353.sh https://raw.githubusercontent.com/kastielslip/copilot-termux/master/install-v353.sh
bash install-v353.sh
```

### Opção 2: v0.0.346 (Estável - recomendado)
```bash
curl -o install-v346.sh https://raw.githubusercontent.com/kastielslip/copilot-termux/master/install-v346.sh
bash install-v346.sh
```

## 📚 DOCUMENTAÇÃO

Tá, mas como isso funciona? Aqui tem tudo explicado de forma clara (sem manual chato de 500 páginas):

<div align="center">

### [📖 COMO FUNCIONA](https://raw.githack.com/kastielslip/copilot-termux/master/docs/COMO_FUNCIONA.html)
*Entenda a arquitetura e os patches aplicados*

### [🔧 GUIA DE INSTALAÇÃO](https://raw.githack.com/kastielslip/copilot-termux/master/docs/INSTALACAO.html)
*Passo a passo detalhado com troubleshooting*

### [🛠️ SOLUÇÃO DE PROBLEMAS](https://raw.githack.com/kastielslip/copilot-termux/master/docs/TROUBLESHOOTING.html)
*Bugs comuns e como resolver*

</div>

## 🎯 RECURSOS

- ✅ **100% funcional** no Termux ARM64
- ✅ **Patches automáticos** para node-pty e sharp
- ✅ **Instalação com 1 comando**
- ✅ **Suporte a múltiplas versões** (346 e 353)
- ✅ **Backup automático** da instalação antiga
- ✅ **Verificação de dependências**
- ✅ **Logs detalhados** para debug

## 🧠 REQUISITOS

```bash
# Termux já instalado
pkg install -y nodejs git

# Espaço mínimo: ~200MB
# RAM recomendada: 2GB+
# Android: 7.0+
```

## 🚀 COMO USAR

Depois de instalado:

```bash
# Autenticar (primeira vez)
github-copilot-cli auth

# Usar o Copilot
github-copilot-cli what the shell "comando que quero fazer"

# Alias útil
alias '??'='github-copilot-cli what the shell'
alias 'git?'='github-copilot-cli git-assist'
alias 'gh?'='github-copilot-cli gh-assist'
```

## 🎨 SCREENSHOTS

*(Em breve - contribuições bem-vindas!)*

## 💬 COMUNIDADE

Achou um bug? Tem uma ideia? Vamos conversar:

- 🐛 [Reportar Bug](https://github.com/kastielslip/copilot-termux/issues)
- 💡 [Sugerir Feature](https://github.com/kastielslip/copilot-termux/issues)
- ⭐ [Dar uma Estrela](https://github.com/kastielslip/copilot-termux)

## 📜 LICENÇA

MIT License - Faça o que quiser, só não me culpe se explodir seu celular 😎

## 🙏 AGRADECIMENTOS

- **GitHub** - Pela API do Copilot
- **Termux** - Por tornar Linux no Android possível  
- **Comunidade Open Source** - Por tudo

---

<div align="center">

### *"Control is an illusion. But we still need it to code."*

![Hack The Planet](https://i.imgur.com/JELwtGU.gif)

**Feito com ☕ e 💀 por [kastielslip](https://github.com/kastielslip)**

</div>

# Espaço mínimo: ~200MB
# RAM recomendada: 2GB+
# Android: 7.0+
```

## 🚀 COMO USAR

Depois de instalar, é só usar normalmente:

```bash
copilot what the shell # pergunta sobre comandos
copilot suggest # sugere comandos baseado no contexto
copilot explain # explica o último comando
```

---

## 🤝 Contribuindo

Esse projeto nasceu da necessidade e persistência. Se você tem melhorias, sugestões ou encontrou bugs, fique à vontade para abrir issues ou pull requests!

---

## 📝 Licença

MIT License - Veja [LICENSE](LICENSE) para mais detalhes

---

## 🙏 Agradecimentos

Um agradecimento especial para todos que acreditaram que era possível rodar o Copilot no Termux. Depois de dias testando, pesquisando e debugando, conseguimos! 🎉

---

<p align="center">
  Feito com ☕ e muita persistência
</p>
