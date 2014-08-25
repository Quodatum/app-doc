// database info
angular.module('quodatum.doc.files', [ 'restangular' ])

.config([ '$routeProvider', function($routeProvider) {
	console.log("$routeProvider quodatum.doc.files");
	$routeProvider.when('/files', {
		templateUrl : '/static/doc/feats/files/files.xhtml',
		controller : "FilesCtrl"
	});

} ])

// controllers
.controller("FilesCtrl", [ "$scope", function($scope) {

	console.log("FilesCtrl2");
	$scope.treeData = {
		label : 'Root',
		state : 'expanded',
		children : [ {
			label : 'Child1',
			state : 'expanded',
			children : [ {
				label : 'Grandchild1',
				state : 'leaf',
				children : []
			} ]
		}, {
			label : 'ChildX'
		}, {
			label : 'ChildY'
		}
		]
	};

	$scope.getMoreData = function(node) {
		console.log("SELECT: ", node);
//		return $http.get('/tree-data/' + node.path).success(function(data) {
//			node.children = data;
//		});
	};

	$scope.$on('nodeSelected', function(event, node, context) {
		if (context.selectedNode) {
			context.selectedNode.class = '';
		}

		node.class = 'selectedNode';
		context.selectedNode = node;
	});
	//----------ya---------
	$scope.options = {
		    context: {
		        selectedNodes: []
		    },
		    onSelect: function ($event, node, context) {
		        if ($event.ctrlKey) {
		            var idx = context.selectedNodes.indexOf(node);
		            if (context.selectedNodes.indexOf(node) === -1) {
		                context.selectedNodes.push(node);
		            } else {
		                context.selectedNodes.splice(idx, 1);
		            }
		        } else {
		            context.selectedNodes = [node];
		        }
		    }
		};


		$scope.model = [{
		        label: 'parent1',
		        children: [{
		            label: 'childa'
		        }]
		    }, {
		        label: 'parent2',
		        children: [{
		            label: 'childb',
		            children: [{
		                label: 'innerChild'
		            }]
		        }]
		    }, {
		        label: 'parent3'
		    }];
} ]);
