Extension { #name : #WorldState }

{ #category : #'*Morphic-Base' }
WorldState >> addAlarm: aSelector withArguments: argArray for: aTarget at: scheduledTime [
	"Add a new alarm with the given set of parameters"
	self alarms add: 
		(MorphicAlarm 
			scheduledAt: scheduledTime
			receiver: aTarget
			selector: aSelector
			arguments: argArray).
]

{ #category : #'*Morphic-Base' }
WorldState class >> debugWorldMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Debugging)
		order: 3.5;
		with: [ (aBuilder item: #'Enable all break/inspect once')
				order: 0;
				help: 'Reset the break/inspect once. Once restarted, the first break once encountered will stop the execution.';
				action: [ Halt resetOnce ]]
]

{ #category : #'*Morphic-Base' }
WorldState >> menuBuilder [
	^ menuBuilder ifNil: [
		menuBuilder := (PragmaMenuBuilder pragmaKeyword: self discoveredMenuPragmaKeyword model: self)
				menuSpec;
				yourself
	]
]

{ #category : #'*Morphic-Base' }
WorldState class >> startMessageTally [

	(self confirm: 'MessageTally will start now,
and stop when the cursor goes
to the top of the screen' translated) 
		ifFalse: [ ^ self ].

	TimeProfiler spyAllOn: [
		MorphicRenderLoop new doOneCycleWhile: [ 
			self currentWorld activeHand position y > 0 ] ]
]

{ #category : #'*Morphic-Base' }
WorldState >> startMessageTally [

	self class startMessageTally
]

{ #category : #'*Morphic-Base' }
WorldState >> startStepping: aMorph at: scheduledTime selector: aSelector arguments: args stepTime: stepTime [
	"Add the given morph to the step list. Do nothing if it is already being stepped."

	self stopStepping: aMorph selector: aSelector.
	self adjustWakeupTimesIfNecessary.
	stepList add:(
		StepMessage 
			scheduledAt: scheduledTime
			stepTime: stepTime
			receiver: aMorph
			selector: aSelector
			arguments: args)
]

{ #category : #'*Morphic-Base' }
WorldState class >> startThenBrowseMessageTally [
	"Tally only the UI process"
	
	(self confirm: 'MessageTally the UI process until the
mouse pointer goes to the top of the screen')
		ifFalse: [ ^ self ].

	TimeProfiler onBlock: [
		MorphicRenderLoop new doOneCycleWhile: [ 
			self currentWorld activeHand position y > 10 ] ]
]

{ #category : #'*Morphic-Base' }
WorldState >> startThenBrowseMessageTally [

	self class startThenBrowseMessageTally
]

{ #category : #'*Morphic-Base' }
WorldState class >> systemOn: aBuilder [
	<worldMenu>
	(aBuilder item: #System)
		order: 3.0;
		with: [
			(aBuilder item: #'Space left')
				help: 'Do a garbage collection, and report results about the to the user.';
				action: [ Smalltalk informSpaceLeftAfterGarbageCollection ].
			(aBuilder item: #'Do Image Cleanup')
				help: 'Clean out any caches and other state that should be flushed when trying to get an image into a pristine state.';
				action: [ Smalltalk cleanUp: true ];
				withSeparatorAfter.
			(aBuilder item: #'Start drawing again')
				help: 'Resume the drawing after a draw error of the world.';
				action: [ self currentWorld resumeAfterDrawError ].
			(aBuilder item: #'Start stepping again')
				help: 'Resume stepping of Morph after an error has occured.';
				action: [ self currentWorld resumeAfterStepError ];
				withSeparatorAfter.
			(aBuilder item: #'Restore display')
				help: 'Restore Morphic display.';
				action: [ self currentWorld restoreMorphicDisplay ] ]
]

{ #category : #'*Morphic-Base' }
WorldState class >> windowsOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Windows)
		order: 4.0;
		with: [ (aBuilder item: #'Collapse all windows')
				action: [ self currentWorld collapseAll ];
				help: 'Reduce all open windows to collapsed forms that only show titles' translated.
			(aBuilder item: #'Expand all windows')
				iconName: #expandBoxIcon;
				action: [ self currentWorld expandAll ];
				help: 'Expand all collapsed windows back to their expanded forms' translated.
			(aBuilder item: #'Fit all windows')
				action: [ self currentWorld fitAllVisibleWindows ];
				help: 'Fit all open windows as visible in World' translated.
			(aBuilder item: #'Close all debuggers')
				help: 'Close all opened debugger in the image.';
				action: [ Smalltalk tools debugger closeAllDebuggers ].
			(aBuilder item: #'Send top window to back (\)')
				action: [ SystemWindow sendTopWindowToBack ];
				help: 'Make the topmost window become the backmost one, and activate the window just beneath it.' translated.
			(aBuilder item: #'Move windows onscreen')
				action: [ self currentWorld bringWindowsFullOnscreen ];
				help: 'Make all windows fully visible on the screen' translated.
			(aBuilder item: #'Delete unchanged windows')
				action: [ self currentWorld closeUnchangedWindows ];
				help: 'Deletes all windows that do not have unsaved text edits.' translated.
			(aBuilder item: #'Delete all windows discarding edits')
				action: [ self currentWorld closeAllWindowsDiscardingChanges ];
				help: 'Deletes all windows even if they have unsaved text edits.' translated.
			(aBuilder item: #'Toggle full screen mode')
				action: [ Display toggleFullscreen ];
				help: 'Turn full screen mode on when it is off, off when it is on.' translated ]
]
