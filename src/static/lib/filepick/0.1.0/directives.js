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
									value : '=',
									onselect:"&"
								},
								templateUrl : '../static/lib/filepick/0.1.0/filepick.html',
								controller : function($scope, $resource) {
									function getChildren(path, node, context) {
										var f = $resource("data/file/list");
										f.query({
											path : path
										}).$promise.then(function(result) {
											node.$model.children = result;
											node.$children = context
													.nodifyArray(result);
										});
									}
									;
									$scope.context = {
										selectedNodes : [],
										hits : 0
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
										name : 'root',
										path : "/",
										has_children : true,
										children : []
									} ];
									
									$scope.action=function(){
										var p=$scope.context.selectedNode.$model;
										//@see http://weblogs.asp.net/dwahlin/creating-custom-angularjs-directives-part-3-isolate-scope-and-function-parameters
										$scope.onselect()($scope.context);
									};
									$scope.busy=false;
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
		.directive(
				'apbDropdown',
				[
						'$parse',
						'$compile',
						'$timeout',
						function($parse, $compile, $timeout) {
							'use strict';

							var buildTemplate = function(items, ul) {
								if (!ul)
									ul = [
											'<ul class="dropdown-menu" role="menu" aria-labelledby="drop1">',
											'</ul>' ];
								angular
										.forEach(
												items,
												function(item, index) {
													var li = '<li>'
															+ '<a tabindex="-1"  ng-click="_setSort(\''
															+ item.field
															+ '\')">'
															+ (item.label || '')
															+ '</a>';
													li += '</li>';
													ul.splice(index + 1, 0, li);
												});
								ul
										.splice(1, 0,
												'<li class="disabled"><a tabindex="-1" href="#">Sort by...</a></li>');
								return ul;
							};

							return {
								restrict : 'EA',
								scope : true,
								link : function postLink(scope, iElement,
										iAttrs) {

									var getter = $parse(iAttrs.apbDropdown), items = getter(scope);

									// Defer after any ngRepeat rendering
									$timeout(function() {

										if (!angular.isArray(items)) {
											// @todo?
										}

										var dropdown = angular
												.element(buildTemplate(items)
														.join(''));
										dropdown.insertAfter(iElement);

										// Compile dropdown-menu
										$compile(
												iElement
														.next('ul.dropdown-menu'))
												(scope);

									});

									iElement.addClass('dropdown-toggle').attr(
											'data-toggle', "dropdown");

								}
							};

						} ])
