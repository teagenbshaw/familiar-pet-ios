export type TimerStatus='idle'|'running'|'paused'|'complete';
export interface TimerState{durationSeconds:number;remainingSeconds:number;status:TimerStatus}
export const createTimer=(minutes:number):TimerState=>({durationSeconds:minutes*60,remainingSeconds:minutes*60,status:'idle'});
export const startTimer=(s:TimerState):TimerState=>({...s,status:'running'});
export const pauseTimer=(s:TimerState):TimerState=>s.status==='running'?{...s,status:'paused'}:s;
export const resumeTimer=(s:TimerState):TimerState=>s.status==='paused'?{...s,status:'running'}:s;
export const tickTimer=(s:TimerState,seconds=1):TimerState=>{if(s.status!=='running')return s;const remaining=Math.max(0,s.remainingSeconds-seconds);return {...s,remainingSeconds:remaining,status:remaining===0?'complete':'running'}};
