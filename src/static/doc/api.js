angular.module(
		'doc.api',
		[  ])
 .service('EntityService', ['$http', function ($http) {

        var urlBase = '/doc/data/entity/';
        var map={};
         console.log("entity");
        this.fields = function (name) {
            if(!name in map){
              console.log("fields");
              map[name]=$http.get(urlBase+name+"/field");
            };
            return map[name];
        };
 }])
;

