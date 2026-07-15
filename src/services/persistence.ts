import type {SaveData} from '../domain/types';
import {createDefaultSave} from '../domain/defaults';
export const CURRENT_SCHEMA=2;
export const migrateSave=(raw:any):SaveData=>{const base=createDefaultSave();if(!raw||typeof raw!=='object')return base;if(!raw.schemaVersion||raw.schemaVersion===1)raw={...raw,schemaVersion:2,settings:{...base.settings,...raw.settings,disableFlashing:true}};return {...base,...raw,pet:{...base.pet,...raw.pet},settings:{...base.settings,...raw.settings},daily:{...base.daily,...raw.daily},windowPosition:{...base.windowPosition,...raw.windowPosition},schemaVersion:CURRENT_SCHEMA}};
export const loadSave=():SaveData=>{try{const raw=localStorage.getItem('familiar-save');return raw?migrateSave(JSON.parse(raw)):createDefaultSave()}catch{return createDefaultSave()}};
export const saveData=(data:SaveData)=>{localStorage.setItem('familiar-save-backup',localStorage.getItem('familiar-save')??'');localStorage.setItem('familiar-save',JSON.stringify(data))};
export const exportSave=(data:SaveData)=>JSON.stringify(data,null,2);
export const importSave=(json:string)=>migrateSave(JSON.parse(json));
