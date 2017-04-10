// database info
angular.module('quodatum.doc.jobs', [ 'ui.router' ])

.config(
    [ '$stateProvider', '$urlRouterProvider',
        function($stateProvider, $urlRouterProvider) {
          $stateProvider
          .state('job', {
            url : "/data/jobs",
            abstract : true,
            template : '<ui-view>Job list</ui-view>',
            data : {
              entity : "file"
            }
          })

          .state('job.index', {
            url : "",
            templateUrl : '/static/doc/feats/jobs/job-list.html',
            controller : "JobListCtrl",
            ncyBreadcrumb : {
              label : 'Jobs'
            }
          })
         
          .state('job.item', {
            url : "/:job",
            templateUrl : '/static/doc/feats/jobs/job.html',
            reloadOnSearch : false,
            ncyBreadcrumb : {
              label : '{{$stateParams.id}}',
              parent : 'job.index'
            },
            controller : "JobCtrl"
          })
        } ])

// controllers
.controller(
    "JobListCtrl",
    [ "$scope", "$stateParams","DiceService", function($scope, $stateParams,DiceService) {
      console.log("JobListCtrl");
      function update() {
        DiceService.list('job', $scope.params).then(function(d) {
          // console.log("models..",d);
          $scope.jobs = d;
        });
      }

      DiceService.setup($scope, update);
    }]
    )
    
.controller(
    "JobCtrl",
    [ "$scope",  "$stateParams", 
        function($scope,  $stateParams) {
          var job = $stateParams.job;
          console.log("job control: ", job);
          $scope.setTitle("Job: " + job);
    
        } ])
    
;
