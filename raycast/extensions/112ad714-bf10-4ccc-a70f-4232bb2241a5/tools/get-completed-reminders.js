"use strict";var p=Object.defineProperty;var h=Object.getOwnPropertyDescriptor;var S=Object.getOwnPropertyNames;var R=Object.prototype.hasOwnProperty;var C=(t,e)=>{for(var i in e)p(t,i,{get:e[i],enumerable:!0})},D=(t,e,i,a)=>{if(e&&typeof e=="object"||typeof e=="function")for(let r of S(e))!R.call(t,r)&&r!==i&&p(t,r,{get:()=>e[r],enumerable:!(a=h(e,r))||a.enumerable});return t};var N=t=>D(p({},"__esModule",{value:!0}),t);var A={};C(A,{default:()=>P});module.exports=N(A);var f=require("@raycast/api"),w=require("path"),y=require("fs/promises"),g=require("child_process");async function j(t,...e){let i=(0,w.join)(f.environment.assetsPath,"compiled_raycast_swift/AppleReminders");return await(0,y.chmod)(i,"755"),new Promise((a,r)=>{let l=[t];for(let o of e)try{l.push(JSON.stringify(o,(n,s)=>s===void 0?null:s))}catch(n){r(new c("Failed to serialize input to JSON: "+n.message));return}let d=(0,g.spawn)(i,l),u=[],m=[];d.stdout?.on("data",o=>{u.push(o.toString())}),d.stderr?.on("data",o=>{m.push(o.toString())}),d.on("exit",o=>{if(o===0)try{let n=u.join("").trim();n.length!=0?a(JSON.parse(n)):a(null)}catch(n){let s=new c("Failed to deserialize result from JSON: "+n.message);s.stdout=u.join("").trim(),s.stderr=m.join("").trim(),r(s)}else{let n=new c(m.join("").trim()||u.join("").trim()||"Could not get any data");n.stdout=u.join("").trim(),n.stderr=m.join("").trim(),r(n)}}),d.on("error",o=>{r(o)})})}async function x(t){return await j("getCompletedReminders",t)}var c=class extends Error{constructor(e){super(e),this.name="SwiftError"}};async function P(t){return await x(t.listId)}
