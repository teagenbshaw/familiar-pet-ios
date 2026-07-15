import dialogue from '../data/dialogue.json';
export interface DialogueContext {category:string;traits?:string[];mood?:string;period?:string}
export const filterDialogue=(context:DialogueContext)=>dialogue.filter(line=>line.category===context.category&&(!line.moods||!context.mood||line.moods.includes(context.mood))&&(!line.traits||!context.traits||line.traits.some(t=>context.traits!.includes(t))));
