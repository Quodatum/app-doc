// database info
angular.module('apb.angular.tree', [ 'restangular', 'ui.layout'])

.config(
		[ '$routeProvider', function($routeProvider) {
			console.log("$routeProvider apb.angular.tree");
			$routeProvider.when('/tree', {
				templateUrl : '/static/palmyra/feats/tree/tree.xhtml',
				controller : "TreeCtrl"
			});

		} ])

// controllers
.controller("TreeCtrl", [ "$scope", function($scope) {

	console.log("TreeCtrl2");
	$scope.treeOptions = {
		nodeChildren : "children",
		dirSelectable : false
		
	};
	$scope.add=function(){
		$scope.dataForTheTree.push($scope.dataForTheTree[0]);	
	}
	$scope.selectedNode ="ggg";
	$scope.showSelected = function(node) {
		$scope.selectedNode =node.$$hashKey;
	};

	$scope.dataForTheTree = [ {
		"name" : "Joe",
		"age" : "21",
		"children" : [ {
			"name" : "Smith",
			"age" : "42",
			"children" : []
		}, {
			"name" : "Gary",
			"age" : "21",
			"children" : [ {
				"name" : "Jenifer",
				"age" : "23",
				"children" : [ {
					"name" : "Dani",
					"age" : "32",
					"children" : []
				}, {
					"name" : "Max",
					"age" : "34",
					"children" : []
				} ]
			} ]
		} ]
	}, {
		"name" : "Albert",
		"age" : "33",
		"children" : []
	}, {
		"name" : "Ron",
		"age" : "29",
		"children" : []
	} ];

} ]);
