export type PetState='idle'|'wandering'|'sleeping'|'focused'|'celebrating'|'eating'|'interacting'|'hidden'|'disturbed';
export type Trait='curious'|'sleepy'|'energetic'|'shy'|'brave'|'mischievous'|'calm';
export type Mood='calm'|'happy'|'sleepy'|'curious';
export interface PetProfile {name:string;type:'small-dragon';level:number;experience:number;mood:Mood;bond:number;energy:number;hunger:number;traits:Trait[];totalFocusSessions:number;totalFocusMinutes:number;dateAdopted:string;cosmeticUnlocks:string[];cosmetics:Record<string,string>}
export interface Settings {size:number;animationSpeed:number;speechBubbles:boolean;interactionFrequency:'low'|'normal';timeBasedBehavior:boolean;alwaysOnTop:boolean;launchAtStartup:boolean;lockPosition:boolean;hideFullscreen:boolean;clickThrough:boolean;preferredMonitor:string;defaultFocusMinutes:number;sounds:boolean;notifications:boolean;breakSuggestions:boolean;reducedMotion:boolean;disableFlashing:boolean;textScale:number;highContrast:boolean}
export interface DailyStats {date:string;focusMinutes:number;completedSessions:number;checkedIn:boolean}
export interface SaveData {schemaVersion:number;pet:PetProfile;settings:Settings;daily:DailyStats;windowPosition:{x:number;y:number}}
