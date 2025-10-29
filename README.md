<a href="https://git.io/typing-svg">
  <img src="https://readme-typing-svg.demolab.com?font=Fira+Code&size=30&pause=1000&color=0DF700&width=500&lines=Copilot+CLI+no+Termux+ARM64+%F0%9F%9A%80" alt="Typing SVG" />
</a>

<p align="center">
  <img src="https://media.giphy.com/media/dLolp8dtrYCJi/giphy.gif" alt="Mr Robot" width="100%">
</p>

# 🤖 Copilot CLI no Termux (ARM64)

Esse projeto é fruto de muita persistência, testes e pesquisas para rodar o **GitHub Copilot CLI** no Termux (Android ARM64). Depois de dias tentando, conseguimos fazer funcionar perfeitamente!

## 📦 O que tem aqui

- **Scripts de instalação testados e funcionando**
- **Patches para node-pty e sharp**
- **Duas versões disponíveis: v0.0.346 (estável) e v0.0.353 (em testes)**
- **Documentação completa de como instalar**
- **Backup dos tarballs originais**

---

## 🎯 Instalação Rápida

### Opção 1: v0.0.353 (Mais Recente)

```bash
wget https://raw.githubusercontent.com/ErnaneJ/copilot-termux/main/install-v353.sh
chmod +x install-v353.sh
./install-v353.sh
```

### Opção 2: v0.0.346 (Estável e Testada)

```bash
wget https://raw.githubusercontent.com/ErnaneJ/copilot-termux/main/install-v346.sh
chmod +x install-v346.sh
./install-v346.sh
```

---

## 📚 Documentação

- **[Como Funciona](docs/COMO_FUNCIONA.md)** - Entenda a mágica por trás dos patches
- **[Guia de Instalação Completo](docs/INSTALACAO.md)** - Passo a passo detalhado
- **[Solução de Problemas](docs/TROUBLESHOOTING.md)** - Problemas comuns e soluções

---

## 🛠️ Requisitos

- Termux atualizado (Android ARM64)
- Node.js 18+ instalado (`pkg install nodejs`)
- Git instalado (`pkg install git`)
- Pelo menos 200MB de espaço livre

---

## ✨ Recursos

- ✅ Copilot CLI completamente funcional
- ✅ Patches automáticos para node-pty e sharp
- ✅ Verificação de versão e atualizações
- ✅ Backup automático antes de instalar
- ✅ Sistema de restauração em caso de erro

---

## 🎬 Como Usar

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
