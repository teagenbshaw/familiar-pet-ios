# Pet behavior state machine

The pet has one authoritative state: `idle`, `wandering`, `sleeping`, `focused`, `celebrating`, `eating`, `interacting`, `hidden`, or `disturbed`.

The transition table lives in `src/domain/stateMachine.ts`. Callers request a transition; invalid combinations retain the current state. In particular, sleeping cannot jump directly to celebration, and focus completion is the only normal path from focused to celebrating. Visual animation names live in pet configuration so a sprite sheet, animated WebP, Lottie file, or frame sequence can replace the current lightweight transform animation without changing behavior rules.

Time-of-day and personality choose candidate behavior; they never mutate the animation directly. Reduced motion is a presentation policy layered on top of the selected state.
