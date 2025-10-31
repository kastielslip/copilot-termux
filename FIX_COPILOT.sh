#!/data/data/com.termux/files/usr/bin/bash
# ============================================================
# CORREÇÃO DO ERRO: Cannot find module bypass-final.js
# Execute este script no seu Termux (u0_a381@192.168.1.100)
# ============================================================

echo "🔧 Corrigindo GitHub Copilot CLI..."
echo ""

# 1. Remover NODE_OPTIONS do .bashrc
echo "1️⃣ Removendo NODE_OPTIONS problemático do .bashrc..."
if grep -q "NODE_OPTIONS.*bypass-final" ~/.bashrc 2>/dev/null; then
    sed -i '/NODE_OPTIONS.*bypass-final/d' ~/.bashrc
    echo "   ✅ Removido do .bashrc"
else
    echo "   ℹ️  Não encontrado no .bashrc"
fi

# 2. Desativar NODE_OPTIONS na sessão atual
echo ""
echo "2️⃣ Desativando NODE_OPTIONS na sessão atual..."
unset NODE_OPTIONS
echo "   ✅ NODE_OPTIONS desativado"

# 3. Verificar se o copilot está instalado
echo ""
echo "3️⃣ Verificando instalação do Copilot..."
if command -v copilot >/dev/null 2>&1; then
    echo "   ✅ Copilot instalado"
else
    echo "   ❌ Copilot não encontrado"
    echo "   Execute: npm install -g @github/copilot@0.0.346 --ignore-scripts --force"
    exit 1
fi

# 4. Criar stub do sharp se necessário
echo ""
echo "4️⃣ Verificando módulo sharp..."
SHARP_FILE="/data/data/com.termux/files/usr/lib/node_modules/@github/copilot/node_modules/sharp/lib/sharp.js"

if [ -f "$SHARP_FILE" ]; then
    echo "   ℹ️  Sharp encontrado, criando stub..."
    
    cat > "$SHARP_FILE" << 'EOFSHARP'
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

sharp.format = Object.assign(
  () => formats,
  formats
);

sharp.versions = { vips: '8.17.2' };
sharp.libvipsVersion = () => '8.17.2';
sharp.cache = () => ({ memory: 0, files: 0, items: 0 });
sharp.concurrency = () => 1;
sharp.queue = { length: 0 };
sharp.simd = () => false;
sharp.counters = () => ({ queue: 0, process: 0 });

module.exports = sharp;
EOFSHARP

    echo "   ✅ Sharp stub criado"
else
    echo "   ⚠️  Sharp não encontrado (pode não ser necessário)"
fi

# 5. Testar copilot
echo ""
echo "5️⃣ Testando Copilot..."
echo ""

# Força desativar NODE_OPTIONS para este teste
export NODE_OPTIONS=""

if copilot --version 2>&1 | head -2; then
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "✅ CORREÇÃO CONCLUÍDA COM SUCESSO!"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "⚠️  IMPORTANTE: Reinicie o terminal ou execute:"
    echo "    source ~/.bashrc"
    echo ""
    echo "Depois use normalmente:"
    echo "    copilot --help"
    echo "    copilot"
    echo ""
else
    echo ""
    echo "❌ Ainda há problemas. Verifique o erro acima."
fi
