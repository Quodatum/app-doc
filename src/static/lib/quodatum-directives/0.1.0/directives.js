/* quodatum.directives
 * filepick shows file directory tree
 * tree
 * filetree
 * apbDropdown generates sort by drop down.
 */
angular
		.module('quodatum.directives', [ 'ngResource' ])
		// <filetree value=/>
		.directive(
				"filepick",
				[
						'apiRoot',
						function($compile, apiRoot) {

							return {
								restrict : "E",
								scope : {
									value : '=ngModel',
									onselect:"&",
									endpoint:'=',
									view:'@'	// tree or find
								},
								templateUrl : '../static/lib/quodatum-directives/0.1.0/filepick.html',
								compile: function(element, attrs){
									console.log("compile");
								       if (!attrs.view) { attrs.view = "tree"; }
							
								    },
								controller : function($scope, $resource,$timeout) {
									$scope.busy=false;
									$scope.view="tree";
									$scope.pattern="*.xsd";
									console.log("FILEPICK",$scope.endpoint,$scope.view);
									
									function getChildren(path, node, context) {
										console.log("getChildren");
										$scope.busy=true;
										var f = $resource($scope.endpoint);
										f.query({
											path : path
										}).$promise.then(function(result) {
											node.$model.children = result;
											node.$children = context
													.nodifyArray(result);
											$scope.busy=false;
										});
									}
									;
									$scope.context = {
										selectedNodes : [],
										hits : 0
									};
									$scope.toggleview = function(){
											$scope.view=($scope.view=="tree")?"find":"tree";
										};
									
									$scope.options = {
										hasChildrenKey : "isdir",

										onSelect : function($event, node,
												context) {
											context.hits++;
											
											if ($event.ctrlKey) {
												var idx = context.selectedNodes
														.indexOf(node);
												if (context.selectedNodes
														.indexOf(node) === -1) {
													context.selectedNodes
															.push(node);
												} else {
													context.selectedNodes
															.splice(idx, 1);
												}
											} else {
												context.selectedNodes = [ node ];
											}
										},
										onExpand : function($event, node,
												context) {
											var id = node.$model.path;
											getChildren(id, node, context);
										},
										onDblClick:function( $event, node, context){
											$scope.action();
										}
									};

									$scope.model = [ {
										name : '/',
										path : "/",
										has_children : true,
										children : []
									} ];
									
									$scope.action=function(){
										if($scope.view=="find"){
											console.log("fid",$scope.context)
											alert("find"+$scope.pattern);
											
											return;
										};
										if(!$scope.context.selectedNode)return;
										var p=$scope.context.selectedNode.$model;
										//@see http://weblogs.asp.net/dwahlin/creating-custom-angularjs-directives-part-3-isolate-scope-and-function-parameters
										$scope.value=p.path;
										$scope.view="tree";
										$scope.onselect()($scope.context);
									};
									
									//getChildren("/", $scope.model[0], $scope.context)
//									 $timeout(
//											 function( ) {
//											 console.log( "$evalAsync" );
//											 getChildren("/",$scope.context.rootNode,$scope.context);
//											 }
//											 ); 
								}
							}
						} ])
		// http://jsfiddle.net/n8dPm/
		.directive(
				"tree",
				function($compile) {
					return {
						restrict : "E",
						scope : {
							family : '='
						},
						template : '<p>{{ family.name }}</p>' + '<ul>'
								+ '<li ng-repeat="child in family.children">'
								+ '<tree family="child"></tree>' + '</li>'
								+ '</ul>',
						compile : function(tElement, tAttr) {
							var contents = tElement.contents().remove();
							var compiledContents;
							return function(scope, iElement, iAttr) {
								if (!compiledContents) {
									compiledContents = $compile(contents);
								}
								compiledContents(scope, function(clone, scope) {
									iElement.append(clone);
								});
							};
						}
					};
				})

		// <div
		// filetree="{script:'/restxq/abide/ide/filelist2',multiFolder:false}"
		// on-pick="newPick(pick)" ></div>
		.directive(
				"filetree",
				function($compile, $timeout) {
					return {
						// Restrict it to be an attribute in this case
						restrict : 'A',
						scope : {
							onPick : '&'
						},
						// responsible for registering DOM listeners as well as
						// updating the DOM
						link : function(scope, element, attrs) {
							$(element).fileTree(scope.$eval(attrs.filetree),
									function(e) {
										$timeout(function() {
											scope.onPick({
												pick : e
											});
										}, 0)
									});
						}
					};
				})
						
// value is sortfield with direction. dropdown has options list 
.directive(
				"sortui",
				[
						'apiRoot',
						function($compile, apiRoot) {

							return {
								restrict : "E",
								scope : {
									params : '=ngModel',
									onselect:"&",
									endpoint:'=',
									options:"=",
									view:'@'	
								},
								templateUrl : '../static/lib/quodatum-directives/0.1.0/sortui.html',
								
								controller : function($scope, $resource) {
									$scope.field="XXY";
									$scope.isopen=false;
									
									$scope._setSort = function(fld) {
										setsort(fld, (fld == $scope.field) ? !$scope.desc : true);
									};
									$scope.sortclick = function() {
										var s = $scope.params.sort;
										var desc = "-" == s.charAt(0);
										s = s.substr(desc || "+" == s.charAt(0) ? 1 : 0);
										$scope.params.sort = (desc ? "" : "-") + s
									};
									$scope.fieldclick = function(aa) {
										//$scope.field=aa;
										$scope.params.sort=aa;
										$scope.isopen=false;
									};
									$scope.$watch('params.sort', function(newVal, oldVal, $scope) {
										if (!newVal)
											return;
										var s = newVal.charAt(0)
										$scope.field = newVal.substr(("-" == s || "+" == s) ? 1 : 0)
										$scope.desc = "-" == s;
									});
									function setsort(fld, desc) {
										$scope.params.sort = (desc ? "-" : "") + fld
									}
								}
							}}])
.directive(
				"uipage",
				[
						'apiRoot',
						function($compile, apiRoot) {

							return {
								restrict : "E",
								scope : {
									value : '=ngModel',
									onselect:"&",
									endpoint:'=',
									view:'@'	
								},
								templateUrl : '../static/lib/quodatum-directives/0.1.0/uipage.html',
								
								controller : function($scope, $resource) {
									$scope._setSort = function(fld) {
										setsort(fld, (fld == $scope.field) ? !$scope.desc : true);
									};
									$scope.sortclick = function() {
										var s = $scope.params.sort;
										var desc = "-" == s.charAt(0);
										s = s.substr(desc || "+" == s.charAt(0) ? 1 : 0);
										$scope.params.sort = (desc ? "" : "-") + s
									};

									$scope.$watch('params.sort', function(newVal, oldVal, $scope) {
										if (!newVal)
											return;
										var s = newVal.charAt(0)
										$scope.field = newVal.substr(("-" == s || "+" == s) ? 1 : 0)
										$scope.desc = "-" == s;
									});
									function setsort(fld, desc) {
										$scope.params.sort = (desc ? "-" : "") + fld
									}
								}
							}}])
.directive('cvaBar',['$interpolate', function($interpolate) {
  return {
      restrict: 'AE',
      replace: 'true',
     
      templateUrl : '../static/lib/quodatum-directives/0.1.0/actionbar.html',
      controller : function($scope){
    	  $scope.eval=function(exp){   		  
    		  var r=$interpolate(exp)({item:$scope.item});
    		  console.log("eval ",exp,"#",r,"#",$scope.item);
    		  return r;
    	  };
      }
      /*
     link: function(scope, elem, attrs) {
    	      elem.bind('mouseover', function() {
    	        elem.css('cursor', 'w-resize');
    	      });
    	    }
    	    */	  
  };
}])
							
;
							
