# State management

Uses `ui-router` and `angular-breadcrumb`

## define states
add .states to module. Below is typical structure

````
   .state('component', {
                url : "/data/component",
                abstract : true,
                ncyBreadcrumb: { skip:true},
                template : '<ui-view>library</ui-view>'
    })
              
  .state('component.index', {
                url : "",
                templateUrl : '/static/doc/feats/components/components.xhtml',
                ncyBreadcrumb: { label: 'components' },
                controller : "ScrollCtrl"
    })
  
  .state('component.item', {
                url : "/:name",
                templateUrl : '/static/doc/feats/components/comp1.xhtml',
                ncyBreadcrumb: { label: '{{$stateParams.name}}',parent: 'component.index' },
                controller : "CompCtrl"
    })
````
 ## breadcrumbs
 ````
    <cva-bar ng-model="bar">bar</cva-bar>
 ````