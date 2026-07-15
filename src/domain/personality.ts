import type {Trait} from './types';
export type IdleBehavior='look'|'nap'|'wander'|'spark'|'hide'|'guard';
const preferences:Record<Trait,IdleBehavior[]>= {curious:['look','wander'],sleepy:['nap','look'],energetic:['wander','spark'],shy:['hide','look'],brave:['guard','wander'],mischievous:['spark','hide'],calm:['look','guard']};
export const behaviorsForTraits=(traits:Trait[])=>[...new Set(traits.flatMap(t=>preferences[t]))];
export const chooseBehavior=(traits:Trait[],value=.5)=>{const choices=behaviorsForTraits(traits);return choices[Math.min(choices.length-1,Math.floor(value*choices.length))]};
