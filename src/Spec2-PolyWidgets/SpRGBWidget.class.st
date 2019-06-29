"
I am a Spec widget  allowing a user to choose a Color by its RGB values and providing a preview.

self example

I am composed of a RGBSliders and an ImagePresenter that display simply a form of the current color.

I provide the following methods
- color a shortcut color to access the current color of the RGBSliders.
- makeNewForm return a fresh copy of the current displayed form.

I provide extentForPreview, a point used to define the size of the preview.
"
Class {
	#name : #SpRGBWidget,
	#superclass : #SpPresenter,
	#instVars : [
		'preview',
		'sliders',
		'extentForPreview'
	],
	#category : #'Spec2-PolyWidgets-RGB'
}

{ #category : #specs }
SpRGBWidget class >> defaultSpec [
	<spec: #default>
	^ SpLayout composed
		newColumn: [ :column | 
			column
				add: #preview;
				add: #sliders ];
		yourself
]

{ #category : #api }
SpRGBWidget >> color [
 ^ sliders color
]

{ #category : #initialization }
SpRGBWidget >> initializePresenter [
	sliders whenChangedDo: [ preview image: self makeNewForm ].
]

{ #category : #initialization }
SpRGBWidget >> initializeWidgets [
	preview := self instantiate: SpImagePresenter.
	sliders := self instantiate: SpRGBSliders.
	preview image: (Form extent: 30 @ 30 depth: 32).
	preview image: self makeNewForm.
	self focusOrder add: sliders
]

{ #category : #api }
SpRGBWidget >> makeNewForm [
	^ (Form extent: 30 @ 30 depth: 32) fillColor: self color
]

{ #category : #accessing }
SpRGBWidget >> preview [
	^ preview
]

{ #category : #accessing }
SpRGBWidget >> sliders [
	^ sliders
]

{ #category : #'api-events' }
SpRGBWidget >> whenExtentForPreviewChanged: aBlock [
 extentForPreview whenChangedDo: aBlock 
]