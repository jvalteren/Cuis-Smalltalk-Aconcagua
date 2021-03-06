Class {
	#name : #InvalidIntervalException,
	#superclass : #Error,
	#instVars : [
		'from',
		'to',
		'by'
	],
	#category : #'Aconcagua-ArithmeticModel'
}

{ #category : #'instance creation' }
InvalidIntervalException class >> from: aFrom to: aTo by: aBy [

	^self new initializeFrom: aFrom to: aTo by: aBy
]

{ #category : #signaling }
InvalidIntervalException class >> signalFrom: aFrom to: aTo by: aBy [

	(self from: aFrom to: aTo by: aBy) signal
]

{ #category : #accessing }
InvalidIntervalException >> by [

	^by
]

{ #category : #accessing }
InvalidIntervalException >> description [

	^'An interval cannot be created from {1} to {2} with an increase of {3}' format: {from .to .by}
]

{ #category : #accessing }
InvalidIntervalException >> from [

	^from
]

{ #category : #initialization }
InvalidIntervalException >> initializeFrom: aFrom to: aTo by: aBy [

	from := aFrom.
	to := aTo.
	by := aBy.
]

{ #category : #accessing }
InvalidIntervalException >> to [

	^to
]
