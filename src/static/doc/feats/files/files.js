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

	
	// ----------ya---------
	$scope.context = {
		selectedNodes : [],
		hits : 0
	};
	function getChildren(dir,node,context){ 
		var f=$resource(apiRoot+'/data/list');
		f.query({dir:dir}).$promise
		 .then(function (result) {
	            node.$model.children = result;
	            node.$children = context.nodifyArray(result);
	        })
	        ;
	};
	$scope.fsel=function(p){
		alert("AA:"+p.path);
	};
	$scope.options = {
		hasChildrenKey:"isdir",
		
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
			    var id=node.$model.path;
			    getChildren(id,node,context);
		 }
	};

	$scope.model = [ {
		name : 'root',
		path:"/",
		 has_children:true,
		 children:[]
} ];
}]);	
