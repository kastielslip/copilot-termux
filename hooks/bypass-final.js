const Module = require('module');
const originalLoad = Module._load;

console.log('[FINAL] Bypass definitivo v0.0.353');

Module._load = function(request, parent) {
  if (request.includes('pty.node') || request.includes('node-pty')) {
    console.log('[FINAL] node-pty bypass');
    return {
      spawn: () => ({ pid: 9999, on: () => ({}), write: () => true, resize: () => {}, kill: () => {} }),
      Terminal: class { constructor() { this.pid = 9999; } on() { return this; } write() { return true; } }
    };
  }
  
  if (request.includes('sharp') && !request.endsWith('sharp.js')){
    console.log('[FINAL] sharp bypass completo');
    
    // STUB COMPLETO do sharp (baseado na v0.0.346 que funciona!)
    class Sharp {
      constructor(input,options){this.options=options||{};this.input=input;}
      resize(){return this;}
      extract(){return this;}
      trim(){return this;}
      toBuffer(callback){
        const buffer=Buffer.from('');
        const info={format:'raw',width:0,height:0,channels:0,size:0};
        if(callback)callback(null,buffer,info);
        return Promise.resolve(buffer);
      }
      toFile(path,callback){
        const info={format:'raw',width:0,height:0,channels:0,size:0};
        if(callback)callback(null,info);
        return Promise.resolve(info);
      }
      metadata(callback){
        const meta={format:'raw',width:0,height:0,channels:0};
        if(callback)callback(null,meta);
        return Promise.resolve(meta);
      }
      stats(callback){
        const stats={channels:[]};
        if(callback)callback(null,stats);
        return Promise.resolve(stats);
      }
      clone(){return new Sharp(this.input,this.options);}
    }
    
    const sharp=(input,options)=>new Sharp(input,options);
    const formatDef={input:{file:true,buffer:true,stream:true},output:{file:true,buffer:true,stream:true,alias:[]}};
    
    sharp.cache=()=>{};
    sharp.concurrency=()=>{};
    sharp.counters=()=>({});
    sharp.simd=()=>false;
    sharp.format=()=>({
      jpeg:formatDef,
      png:formatDef,
      webp:formatDef,
      tiff:formatDef,
      gif:formatDef,
      svg:formatDef,
      pdf:formatDef,
      heif:{...formatDef,output:{...formatDef.output,alias:['avif','heic']}},
      jp2k:{...formatDef,output:{...formatDef.output,alias:['j2c','j2k','jp2','jpx']}},
      jxl:formatDef,
      raw:formatDef
    });
    sharp.versions={vips:'8.17.0',sharp:'0.33.0'};
    sharp.libvipsVersion=()=>'8.17.0';
    sharp.vendor={platform:'linux',arch:'arm64'};
    
    return sharp;
  }
  
  return originalLoad.apply(this, arguments);
};
