
//Syntax allows to chain factories
angular.module('quodatum.directives', [])
// set height on element to extend to window
// http://stackoverflow.com/questions/14703517/angular-js-set-element-height-on-page-load
.directive('fillheight', function ($window) {
    return function (scope, element) {
        var w = angular.element($window);
		var e=$(element);
        scope.getWindowDimensions = function () {
             var x=e.offset();
		    // console.log("--",element,"xxxxx:",x);
            return { 'h': w.height(), 'w': w.width(),"top":x.top };
        };
		
        scope.$watch(scope.getWindowDimensions, function (newValue, oldValue) {
            scope.windowHeight = newValue.h;
            scope.windowWidth = newValue.w;
            scope.style = function () {
                return { 
                    'height': (newValue.h - newValue.top -10) + 'px',
                    'min-height': '200px' 
					
                };
            };

        }, true);

        w.bind('resize', function () {
            scope.$apply();
        });
    }
})
// http://jsfiddle.net/n8dPm/
.directive("tree", function($compile) {
    return {
        restrict: "E",
        scope: {family: '='},
        template: 
            '<p>{{ family.name }}</p>'+
            '<ul>' + 
                '<li ng-repeat="child in family.children">' + 
                    '<tree family="child"></tree>' +
                '</li>' +
            '</ul>',
        compile: function(tElement, tAttr) {
            var contents = tElement.contents().remove();
            var compiledContents;
            return function(scope, iElement, iAttr) {
                if(!compiledContents) {
                    compiledContents = $compile(contents);
                }
                compiledContents(scope, function(clone, scope) {
                         iElement.append(clone); 
                });
            };
        }
    };
})

// <div filetree="{script:'/restxq/abide/ide/filelist2',multiFolder:false}"
//   on-pick="newPick(pick)"	></div>
.directive("filetree", function($compile,$timeout) {
       return {
        // Restrict it to be an attribute in this case
        restrict: 'A',
		  scope: {
            onPick: '&'
        },
        // responsible for registering DOM listeners as well as updating the DOM
        link: function(scope, element, attrs) {
            $(element).fileTree(
			        scope.$eval(attrs.filetree),
			        function(e){$timeout(function(){
								scope.onPick({pick: e});},0)}
			);
        }
    };
})
.directive('apbDropdown', ['$parse', '$compile', '$timeout', function($parse, $compile, $timeout) {
  'use strict';

  var buildTemplate = function(items, ul) {
    if(!ul) ul = ['<ul class="dropdown-menu" role="menu" aria-labelledby="drop1">', '</ul>'];
    angular.forEach(items, function(item, index) {
      var li = '<li>' +
        '<a tabindex="-1"  ng-click="_setSort(\'' + item.field + '\')">' +
        (item.label || '') + '</a>';
      li += '</li>';
      ul.splice(index + 1, 0, li);
    });
     ul.splice( 1, 0,  '<li class="disabled"><a tabindex="-1" href="#">Sort by...</a></li>');
    return ul;
  };

  return {
    restrict: 'EA',
    scope: true,
    link: function postLink(scope, iElement, iAttrs) {

      var getter = $parse(iAttrs.apbDropdown),
          items = getter(scope);

      // Defer after any ngRepeat rendering
      $timeout(function() {

        if(!angular.isArray(items)) {
          // @todo?
        }

        var dropdown = angular.element(buildTemplate(items).join(''));
        dropdown.insertAfter(iElement);

        // Compile dropdown-menu
        $compile(iElement.next('ul.dropdown-menu'))(scope);

      });

      iElement
        .addClass('dropdown-toggle')
        .attr('data-toggle', "dropdown");

    }
  };

}])
