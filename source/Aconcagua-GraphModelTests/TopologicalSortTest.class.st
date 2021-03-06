Class {
	#name : #TopologicalSortTest,
	#superclass : #TestCase,
	#category : #'Aconcagua-GraphModelTests'
}

{ #category : #test }
TopologicalSortTest >> testCreateWithCyclicGraph [

	| cyclicGraph |

	cyclicGraph :=
		Graph edges: (
			Array
				with: (Edge from: 'a' to: 'b')
				with: (Edge from: 'b' to: 'c')
				with: (Edge from: 'c' to: 'a')).

	self deny: cyclicGraph isAcyclic.

	self
		should: [TopologicalSort for: cyclicGraph]
		raise: CannotApplyTopologicalSortToACyclicGraphException
		withExceptionDo: [ :anException |
			self
				assert: anException description notEmpty;
				assert: anException graph = cyclicGraph]
]

{ #category : #test }
TopologicalSortTest >> testValue [

	"Example from http://en.wikipedia.org/wiki/Topological_sorting"

	| graph result |

	graph :=
		Graph edges: (
			OrderedCollection new
				add: (Edge from: 7 to: 11);
				add: (Edge from: 7 to: 8);
				add: (Edge from: 11 to: 2);
				add: (Edge from: 11 to: 9);
				add: (Edge from: 11 to: 10);
				add: (Edge from: 5 to: 11);
				add: (Edge from: 3 to: 8);
				add: (Edge from: 3 to: 10);
				add: (Edge from: 8 to: 9);
				yourself).

	result := (TopologicalSort for: graph) value asOrderedCollection.

	self assert: 8 equals: result size.
	self assert: (result includesAllOf: #(3 5 7 11 8 2 9 10))
]

{ #category : #test }
TopologicalSortTest >> testValueWithAnotherGraph [

	"Example from: http://www.cs.fsu.edu/~cop4531/slideshow/chapter23/23-4.html"

	| graph result |

	graph :=
		Graph
			edges: (
				OrderedCollection new
					add: (Edge from: 'undershorts' to: 'pants');
					add: (Edge from: 'undershorts' to: 'shoes');
					add: (Edge from: 'pants' to: 'shoes');
					add: (Edge from: 'pants' to: 'shoes');
					add: (Edge from: 'pants' to: 'belt');
					add: (Edge from: 'socks' to: 'shoes');
					add: (Edge from: 'shirt' to: 'belt');
					add: (Edge from: 'shirt' to: 'tie');
					add: (Edge from: 'tie' to: 'jacket');
					yourself)
			nodes: (
				Set new
					add: 'undershorts';
					add: 'pants';
					add: 'shoes';
					add: 'belt';
					add: 'shirt';
					add: 'tie';
					add: 'jacket';
					add: 'watch';
					add: 'socks';
					yourself).

	result := ((TopologicalSort for: graph) value) asArray.

	self
		assert: (result indexOf: 'undershorts') < (result indexOf: 'pants');
		assert: (result indexOf: 'undershorts') < (result indexOf: 'belt');
		assert: (result indexOf: 'undershorts') < (result indexOf: 'jacket');
		assert: (result indexOf: 'undershorts') < (result indexOf: 'shoes');
		assert: (result indexOf: 'shirt') < (result indexOf: 'belt');
		assert: (result indexOf: 'shirt') < (result indexOf: 'tie');
		assert: (result indexOf: 'shirt') < (result indexOf: 'jacket');
		assert: (result indexOf: 'pants') < (result indexOf: 'shoes')
]

{ #category : #test }
TopologicalSortTest >> testWithGraphWithoutEdges [

	| graph result |

	graph := Graph edges: #() nodes: (Array with: 'a' with: 'b').

	result := (TopologicalSort for: graph) value.

	self
		assert: (result includes: 'a');
		assert: (result includes: 'b')
]
