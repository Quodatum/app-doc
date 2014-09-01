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
.controller("FilesCtrl", [ "$scope", "Restangular","$resource","apiRoot",
                           function($scope,Restangular,$resource,apiRoot) {

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
		} ]
	};

	$scope.getMoreData = function(node) {
		console.log("SELECT: ", node);
		// return $http.get('/tree-data/' + node.path).success(function(data) {
		// node.children = data;
		// });
	};

	$scope.$on('nodeSelected', function(event, node, context) {
		if (context.selectedNode) {
			context.selectedNode.class = '';
		}

		node.class = 'selectedNode';
		context.selectedNode = node;
	});
	// ----------ya---------
	$scope.context = {
		selectedNodes : [],
		hits : 0
	};
	function getChildren(dir,node,context){ 
		var f=$resource(apiRoot+'/data/files');
		f.query({dir:dir}).$promise
		 .then(function (result) {
	            node.$model.children = result;
	            node.$children = context.nodifyArray(result);
	        })
	        ;
	};
	$scope.options = {

		onSelect : function($event, node, context) {
			context.hits++;
			if ($event.ctrlKey) {
				var idx = context.selectedNodes.indexOf(node);
				if (context.selectedNodes.indexOf(node) === -1) {
					context.selectedNodes.push(node);
				} else {
					context.selectedNodes.splice(idx, 1);
				}
			} else {
				context.selectedNodes = [ node ];
			}
		},
		 onExpand: function($event, node, context) {
			    var id=node.$model.label;
			    getChildren("/",node,context);
		 }
	};

	$scope.model = [ {
		label : 'parent1',
		children : [ {
			label : 'childa'
		}, {
			label : 'child x'
		}, {
			label : 'child y'
		} ]
	}, {
		label : 'parent2',
		children : [ {
			label : 'child b has a very long label',
			children : [ {
				label : 'innerChild'
			} ]
		} ]
	}, {
		label : 'parent3'
	} ];
} ]);
