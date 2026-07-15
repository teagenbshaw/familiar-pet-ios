import type {PetState} from './types';
export const transitions:Record<PetState,PetState[]>={idle:['wandering','sleeping','focused','eating','interacting','hidden','disturbed'],wandering:['idle','sleeping','focused','interacting','hidden'],sleeping:['idle','focused','hidden'],focused:['idle','celebrating','disturbed','hidden'],celebrating:['idle','interacting','hidden'],eating:['idle','interacting','hidden'],interacting:['idle','eating','focused','hidden'],hidden:['idle'],disturbed:['idle','focused','hidden']};
export const canTransition=(from:PetState,to:PetState)=>transitions[from].includes(to);
export const transition=(from:PetState,to:PetState)=>canTransition(from,to)?to:from;
