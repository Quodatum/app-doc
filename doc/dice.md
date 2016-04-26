# dice

## Server
A framework to generate dynamically filtered and sorted json data.
Uses entity model

## Client
DiceService in doc/services.js
Requests data using current parameters.


DiceService.one('app', app).then(function(d) {
            $scope.app = d;
            // console.log(">>", d);
          });