export const experienceForLevel=(level:number)=>Math.round(100*Math.pow(Math.max(0,level-1),1.55));
export const levelFromExperience=(xp:number)=>{let level=1;while(experienceForLevel(level+1)<=xp)level++;return level};
export const focusExperience=(minutes:number)=>Math.max(5,Math.round(minutes*.8));
export const applyDailyCheckIn=(checked:boolean)=>checked?0:8;
