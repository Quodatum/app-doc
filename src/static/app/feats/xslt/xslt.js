// database info
angular.module('abp.angular.xslt', [ 'restangular'])
.config(
        [ '$routeProvider', 
		function($routeProvider) {
        	console.log("$routeProvider")
           $routeProvider.when('/xslt', {
               templateUrl : '/static/palmyra/feats/xslt/xslt.xhtml',
               controller : "XsltCtrl"
           });  

      }])
 

// controllers
.controller("XsltCtrl", [  '$routeParams', '$scope','$location',
                             '$modal','Restangular','flashr','$http',
           function( $routeParams, $scope,$location,$modal,Restangular,
        		   flashr,$http) {
	
	console.log("xsltCtrl2");
	$scope.state={xml:"<foo/>", 
			      xslt:"<xslt/>",
			     result:"",
			     showResult:false};
	
	$scope.aceopts={ useWrapMode : true,
			   showGutter: true,
			   theme:'chrome',
			   mode:'xml',
			   onLoad: function(_editor){
				   _editor.setOptions({
					    enableBasicAutocompletion: true
					});
					console.log("load");
					 ace.require('apb/abide/settingsmenu').init(_editor);
				     ace.require('apb/abide/keysmenu').init(_editor);
				     ace.require('apb/abide/breakpoints').init(_editor);
				   //  ace.require('apb/abide/token_tooltip').TokenTooltip(_editor);
				   //  ace.require('apb/abide/smart');
					/* var langTools = ace.require("ace/ext/language_tools");
					    
					    // uses http://rhymebrain.com/api.html
					    var rhymeCompleter = {
					        getCompletions: function(editor, session, pos, prefix, callback) {
					            if (prefix.length === 0) { callback(null, []); return }
					            $.getJSON(
					                "http://rhymebrain.com/talk?function=getRhymes&word=" + prefix,
					                function(wordList) {
					                    // wordList like [{"word":"flow","freq":24,"score":300,"flags":"bc","syllables":"1"}]
					                    callback(null, wordList.map(function(ea) {
					                        return {name: ea.word, value: ea.word, score: ea.score, meta: "rhyme"}
					                    }));
					                })
					        }
					    }
					    langTools.addCompleter(rhymeCompleter);*/
				},
			   onChange: function(_editor){
					//todo
				   }
	};
	
	$http({method: "GET", url: "/static/palmyra/feats/xslt/sample.xsl"})
	  .success(function(data){ // data should be text string here
		  $scope.state.xslt=data;
	  }
	);
	
	
	$scope.transform=function(){
		Restangular.all("xslt")
					.post("exec",{
							xml:$scope.state.xml,
						    xslt:$scope.state.xslt
						   }
					)
					.then(function(d){
						console.log(d);
						if(d.rc=="0"){
							flashr.now.success("result");
							$scope.state.result=d.result;
							$scope.state.showResult=true;
						}else{
								flashr.now.error(d.info);
							}
						});
		
	};

}])
;
          