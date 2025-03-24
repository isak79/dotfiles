"use strict";var ae=Object.create;var C=Object.defineProperty;var de=Object.getOwnPropertyDescriptor;var ce=Object.getOwnPropertyNames;var le=Object.getPrototypeOf,pe=Object.prototype.hasOwnProperty;var y=(s,e)=>()=>(e||s((e={exports:{}}).exports,e),e.exports),he=(s,e)=>{for(var o in e)C(s,o,{get:e[o],enumerable:!0})},b=(s,e,o,r)=>{if(e&&typeof e=="object"||typeof e=="function")for(let t of ce(e))!pe.call(s,t)&&t!==o&&C(s,t,{get:()=>e[t],enumerable:!(r=de(e,t))||r.enumerable});return s};var ue=(s,e,o)=>(o=s!=null?ae(le(s)):{},b(e||!s||!s.__esModule?C(o,"default",{value:s,enumerable:!0}):o,s)),me=s=>b(C({},"__esModule",{value:!0}),s);var R=y((Te,B)=>{"use strict";B.exports=function(e){var o=0,r;function t(){return o||(o=1,r=e.apply(this,arguments),e=null),r}return t.displayName=e.displayName||e.name||t.displayName||t.name,t}});var v=y((Pe,_)=>{var I=require("child_process"),A=R(),D=class{constructor(){this.child=null,this.baseSpeed=0}speak(e,o,r,t){if(typeof t!="function"&&(t=()=>{}),t=A(t),!e)return setImmediate(()=>{t(new TypeError("say.speak(): must provide text parameter"))});let{command:n,args:d,pipedData:a,options:i}=this.buildSpeakCommand({text:e,voice:o,speed:r});this.child=I.spawn(n,d,i),this.child.stdin.setEncoding("ascii"),this.child.stderr.setEncoding("ascii"),a&&this.child.stdin.end(a),this.child.stderr.once("data",c=>{t(new Error(c))}),this.child.addListener("exit",(c,h)=>{if(c===null||h!==null)return t(new Error(`say.speak(): could not talk, had an error [code: ${c}] [signal: ${h}]`));this.child=null,t(null)})}export(e,o,r,t,n){if(typeof n!="function"&&(n=()=>{}),n=A(n),!e)return setImmediate(()=>{n(new TypeError("say.export(): must provide text parameter"))});if(!t)return setImmediate(()=>{n(new TypeError("say.export(): must provide filename parameter"))});try{var{command:d,args:a,pipedData:i,options:c}=this.buildExportCommand({text:e,voice:o,speed:r,filename:t})}catch(h){return setImmediate(()=>{n(h)})}this.child=I.spawn(d,a,c),this.child.stdin.setEncoding("ascii"),this.child.stderr.setEncoding("ascii"),i&&this.child.stdin.end(i),this.child.stderr.once("data",h=>{n(new Error(h))}),this.child.addListener("exit",(h,g)=>{if(h===null||g!==null)return n(new Error(`say.export(): could not talk, had an error [code: ${h}] [signal: ${g}]`));this.child=null,n(null)})}stop(e){if(typeof e!="function"&&(e=()=>{}),e=A(e),!this.child)return setImmediate(()=>{e(new Error("say.stop(): no speech to kill"))});this.runStopCommand(),this.child=null,e(null)}convertSpeed(e){return Math.ceil(this.baseSpeed*e)}getInstalledVoices(e){typeof e!="function"&&(e=()=>{}),e=A(e);let{command:o,args:r}=this.getVoices();var t=[];this.child=I.spawn(o,r),this.child.stdin.setEncoding("ascii"),this.child.stderr.setEncoding("ascii"),this.child.stderr.once("data",n=>{e(new Error(n))}),this.child.stdout.on("data",function(n){t+=n}),this.child.addListener("exit",(n,d)=>{if(n===null||d!==null)return e(new Error(`say.getInstalledVoices(): could not get installed voices, had an error [code: ${n}] [signal: ${d}]`));t.length>0&&(t=t.split(`\r
`),t=t[t.length-1]===""?t.slice(0,t.length-1):t),this.child=null,e(null,t)}),this.child.stdin.end()}};_.exports=D});var F=y((Le,U)=>{var Se=v(),fe=100,ye="festival",T=class extends Se{constructor(){super(),this.baseSpeed=fe}buildSpeakCommand({text:e,voice:o,speed:r}){let t=[],n="",d={};return t.push("--pipe"),r&&(n+=`(Parameter.set 'Audio_Command "aplay -q -c 1 -t raw -f s16 -r $(($SR*${this.convertSpeed(r)}/100)) $FILE") `),o&&(n+=`(${o}) `),n+=`(SayText "${e}")`,{command:ye,args:t,pipedData:n,options:d}}buildExportCommand({text:e,voice:o,speed:r,filename:t}){throw new Error(`say.export(): does not support platform ${this.platform}`)}runStopCommand(){process.kill(this.child.pid+2)}getVoices(){throw new Error(`say.export(): does not support platform ${this.platform}`)}};U.exports=T});var W=y((Ne,z)=>{var we=v(),ge=175,K="say",P=class extends we{constructor(){super(),this.baseSpeed=ge}buildSpeakCommand({text:e,voice:o,speed:r}){let t=[],n="",d={};return o?t.push("-v",o,e):t.push(e),r&&t.push("-r",this.convertSpeed(r)),{command:K,args:t,pipedData:n,options:d}}buildExportCommand({text:e,voice:o,speed:r,filename:t}){let n=[],d="",a={};return o?n.push("-v",o,e):n.push(e),r&&n.push("-r",this.convertSpeed(r)),t&&n.push("-o",t,"--data-format=LEF32@32000"),{command:K,args:n,pipedData:d,options:a}}runStopCommand(){this.child.stdin.pause(),this.child.kill()}getVoices(){throw new Error(`say.export(): does not support platform ${this.platform}`)}};z.exports=P});var H=y((Me,G)=>{var Ce=require("child_process"),Ae=v(),ve=0,L="powershell",N=class extends Ae{constructor(){super(),this.baseSpeed=ve}buildSpeakCommand({text:e,voice:o,speed:r}){let t=[],n="",d={},a="Add-Type -AssemblyName System.speech;$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer;";if(o&&(a+=`$speak.SelectVoice('${o}');`),r){let i=this.convertSpeed(r||1);a+=`$speak.Rate = ${i};`}return a+="$speak.Speak([Console]::In.ReadToEnd())",n+=e,t.push(a),d.shell=!0,{command:L,args:t,pipedData:n,options:d}}buildExportCommand({text:e,voice:o,speed:r,filename:t}){let n=[],d="",a={},i="Add-Type -AssemblyName System.speech;$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer;";if(o&&(i+=`$speak.SelectVoice('${o}');`),r){let c=this.convertSpeed(r||1);i+=`$speak.Rate = ${c};`}if(t)i+=`$speak.SetOutputToWaveFile('${t}');`;else throw new Error("Filename must be provided in export();");return i+="$speak.Speak([Console]::In.ReadToEnd());$speak.Dispose()",d+=e,n.push(i),a.shell=!0,{command:L,args:n,pipedData:d,options:a}}runStopCommand(){this.child.stdin.pause(),Ce.exec(`taskkill /pid ${this.child.pid} /T /F`)}convertSpeed(e){return Math.max(-10,Math.min(Math.round(9.0686*Math.log(e)-.1806),10))}getVoices(){let e=[];return e.push("Add-Type -AssemblyName System.speech;$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer;$speak.GetInstalledVoices() | % {$_.VoiceInfo.Name}"),{command:L,args:e}}};G.exports=N});var Q=y((qe,E)=>{var xe=F(),Ee=W(),$e=H(),J="darwin",X="linux",j="win32",x=class{constructor(e){if(e||(e=process.platform),e===J)return new Ee;if(e===X)return new xe;if(e===j)return new $e;throw new Error(`new Say(): unsupported platorm! ${e}`)}};E.exports=new x;E.exports.Say=x;E.exports.platforms={WIN32:j,MACOS:J,LINUX:X}});var Ie={};he(Ie,{default:()=>re});module.exports=me(Ie);var S=require("@raycast/api"),V=require("react");var u=require("@raycast/api"),M=ue(Q()),$=require("react/jsx-runtime");var q=s=>(0,$.jsx)(u.Action.CopyToClipboard,{icon:u.Icon.CopyClipboard,...s}),Y=({content:s})=>(0,$.jsx)(u.Action,{icon:u.Icon.SpeechBubble,title:"Speak",onAction:()=>{M.default.stop(),M.default.speak(s)},shortcut:{modifiers:["cmd","shift"],key:"p"}});var k=({icon:s=u.Icon.Trash,title:e,dialog:o,onAction:r,shortcut:t={modifiers:["ctrl"],key:"x"}})=>(0,$.jsx)(u.Action,{style:u.Action.Style.Destructive,icon:s,title:e,onAction:async()=>{await(0,u.confirmAlert)({title:o.title??e,message:o.message??"This action cannot be undone",icon:s,primaryAction:{title:o.primaryButton??e,style:u.Alert.ActionStyle.Destructive,onAction:r}})},shortcut:t});var Z=require("@raycast/api");var w=require("react/jsx-runtime"),ee=({question:s,answer:e})=>(0,w.jsxs)(Z.ActionPanel.Section,{title:"Copy",children:[(0,w.jsx)(q,{title:"Copy Answer",content:e}),(0,w.jsx)(q,{title:"Copy Question",content:s})]});var f=require("@raycast/api"),O=require("react/jsx-runtime"),te=()=>(0,O.jsx)(f.ActionPanel.Section,{title:"Preferences",children:(0,O.jsx)(f.Action,{icon:f.Icon.Gear,title:"Open Extension Preferences",onAction:f.openExtensionPreferences})});var p=require("@raycast/api"),m=require("react");function se(){let[s,e]=(0,m.useState)([]),[o,r]=(0,m.useState)(!0);(0,m.useEffect)(()=>{(async()=>{let a=await p.LocalStorage.getItem("savedChats");a&&e(i=>[...i,...JSON.parse(a)]),r(!1)})()},[]),(0,m.useEffect)(()=>{p.LocalStorage.setItem("savedChats",JSON.stringify(s))},[s]);let t=(0,m.useCallback)(async a=>{let i=await(0,p.showToast)({title:"Saving your answer...",style:p.Toast.Style.Animated}),c={...a,saved_at:new Date().toISOString()};e([...s,c]),i.title="Answer saved!",i.style=p.Toast.Style.Success},[e,s]),n=(0,m.useCallback)(async a=>{let i=await(0,p.showToast)({title:"Unsaving your answer...",style:p.Toast.Style.Animated}),c=s.filter(h=>h.id!==a.id);e(c),i.title="Answer unsaved!",i.style=p.Toast.Style.Success},[e,s]),d=(0,m.useCallback)(async()=>{let a=await(0,p.showToast)({title:"Clearing your saved answers...",style:p.Toast.Style.Animated});e([]),a.title="Saved answers cleared!",a.style=p.Toast.Style.Success},[e]);return(0,m.useMemo)(()=>({data:s,isLoading:o,add:t,remove:n,clear:d}),[s,o,t,n,d])}var oe=require("@raycast/api"),ie=require("react/jsx-runtime"),ne=s=>{let{chat:e,streamData:o}=s,r=o&&o.id===e.id,t=Math.floor(430/Math.min(Math.max(e.files?.length??0,1),2)),n=e.files?.map(a=>`![](${encodeURI(`file://${a}?raycast-width=${t}`)})`).join(`
`)||"",d=`${r?o?.answer:e.answer}
\`\`\`
${e.question.trimEnd()}
\`\`\`
${n}

`;return(0,ie.jsx)(oe.List.Item.Detail,{markdown:d})};var l=require("react/jsx-runtime");function re(){let s=se(),[e,o]=(0,V.useState)(""),[r,t]=(0,V.useState)(null),n=i=>(0,l.jsxs)(S.ActionPanel,{children:[(0,l.jsx)(ee,{answer:i.answer,question:i.question}),(0,l.jsx)(S.ActionPanel.Section,{title:"Output",children:(0,l.jsx)(Y,{content:i.answer})}),(0,l.jsxs)(S.ActionPanel.Section,{title:"Delete",children:[(0,l.jsx)(k,{title:"Unsave",dialog:{title:"Are you sure you want to unsave this answer from your collection?"},onAction:()=>s.remove(i)}),(0,l.jsx)(k,{title:"Clear All",dialog:{title:"Are you sure you want to clear all your saved answer from your collection?"},onAction:()=>s.clear(),shortcut:{modifiers:["cmd","shift"],key:"delete"}})]}),(0,l.jsx)(te,{})]}),a=s.data.sort((i,c)=>new Date(c.saved_at??0).getTime()-new Date(i.saved_at??0).getTime()).filter((i,c,h)=>c===h.findIndex(g=>g.id===i.id)).filter(i=>e===""?!0:i.question.toLowerCase().includes(e.toLowerCase())||i.answer.toLowerCase().includes(e.toLowerCase()));return(0,l.jsx)(S.List,{isShowingDetail:a.length!==0,isLoading:s.isLoading,filtering:!1,throttle:!1,selectedItemId:r||void 0,onSelectionChange:i=>{i!==r&&t(i)},searchBarPlaceholder:"Search saved answer/question...",searchText:e,onSearchTextChange:o,children:s.data.length===0?(0,l.jsx)(S.List.EmptyView,{title:"No saved answers",description:"Save generated question with \u2318 + S shortcut",icon:S.Icon.Stars}):(0,l.jsx)(S.List.Section,{title:"Saved",subtitle:a.length.toLocaleString(),children:a.map(i=>(0,l.jsx)(S.List.Item,{id:i.id,title:i.question,accessories:[{text:new Date(i.created_at??0).toLocaleDateString()}],detail:(0,l.jsx)(ne,{chat:i}),actions:i&&r===i.id?n(i):void 0},i.id))})})}
