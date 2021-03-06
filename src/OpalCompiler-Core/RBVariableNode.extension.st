Extension { #name : #RBVariableNode }

{ #category : #'*opalcompiler-core' }
RBVariableNode >> binding [
	^self propertyAt: #binding ifAbsent: [nil].
]

{ #category : #'*opalcompiler-core' }
RBVariableNode >> binding: aSemVar [
	aSemVar ifNil: [^self removeProperty: #binding ifAbsent: []].
	self propertyAt: #binding put: aSemVar.
]

{ #category : #'*opalcompiler-core' }
RBVariableNode >> isArg [

	^self binding isArg
]

{ #category : #'*opalcompiler-core' }
RBVariableNode >> isArgOrTemp [
	^self binding isTemp
]

{ #category : #'*opalcompiler-core' }
RBVariableNode >> isClean [
	^ (self isInstance | self isReservedVariable) not
]

{ #category : #'*opalcompiler-core' }
RBVariableNode >> isGlobal [
	^self binding isGlobal
]

{ #category : #'*opalcompiler-core' }
RBVariableNode >> isInstance [
	^self binding isInstance
]

{ #category : #'*opalcompiler-core' }
RBVariableNode >> isReservedVariable [
	^ self binding isReservedVariable
]

{ #category : #'*opalcompiler-core' }
RBVariableNode >> isUndeclared [

	^self binding isUndeclared
]
