// database info
angular.module('quodatum.doc.schema', [ 'restangular'])

.config(
		[ '$routeProvider', function($routeProvider) {
			console.log("$routeProvider quodatum.doc.schema");
			$routeProvider.when('/schema', {
				templateUrl : '/static/doc/feats/schema/schema.xhtml',
				controller : "SchemaCtrl"
			});

		} ])

// controllers
.controller("SchemaCtrl", [ "$scope","$resource","apiRoot", function($scope,$resource,apiRoot) {

	console.log("SchemaCtrl2");
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

} ])
;
