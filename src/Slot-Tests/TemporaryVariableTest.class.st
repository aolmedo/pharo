"
Tests for TemporaryVariable 
"
Class {
	#name : #TemporaryVariableTest,
	#superclass : #TestCase,
	#category : #'Slot-Tests-VariablesAndSlots'
}

{ #category : #tests }
TemporaryVariableTest >> testHasTemporaryVariablesBlock [
	| block |
	block := [ | b | b := 2. b +2  ].
	self assert: (block hasTemporaryVariableNamed: #b)
]

{ #category : #tests }
TemporaryVariableTest >> testHasTemporaryVariablesMethod [
	| method |
	method := self class >> #testTemporaryVariablesMethod.
	self assert: (method hasTemporaryVariableNamed: #method)
]

{ #category : #tests }
TemporaryVariableTest >> testIsReferenced [
	| method notReferenced |
	"The temp notReferenced is not used as we test exactly that here"
	method := self class >> #testIsReferenced.
	self assert: method temporaryVariables first isReferenced.
	self deny: method temporaryVariables second isReferenced.
]

{ #category : #properties }
TemporaryVariableTest >> testPropertyAtPut [

	| testValue temp |
	
	testValue := Date today.
	temp := thisContext temporaryVariableNamed:  #testValue.
	
	temp propertyAt: #testKeySelector put: testValue.
	self
		assert: (temp propertyAt: #testKeySelector)
		equals: testValue.
		
	temp removeProperty: #testKeySelector.
	self assert: temp properties isNil
]

{ #category : #tests }
TemporaryVariableTest >> testReadTemporaryVariablesMethod [
	| tempVar |
	tempVar := thisContext temporaryVariableNamed: #tempVar.

	self assert: (tempVar readInContext: thisContext) class equals: TemporaryVariable
]

{ #category : #tests }
TemporaryVariableTest >> testTemporaryVariablesBlock [
	| block |
	block := [ | b | b +2  ].
	self assert: block temporaryVariables first name equals: #b
]

{ #category : #tests }
TemporaryVariableTest >> testTemporaryVariablesMethod [
	| method |
	method := self class >> #testTemporaryVariablesMethod.
	self assert: method temporaryVariables first name equals: #method
]

{ #category : #tests }
TemporaryVariableTest >> testWriteTemporaryVariablesMethod [
	| tempVar |
	tempVar := thisContext temporaryVariableNamed: #tempVar.

	tempVar write: 5 InContext: thisContext.
	self assert: tempVar equals: 5
]
