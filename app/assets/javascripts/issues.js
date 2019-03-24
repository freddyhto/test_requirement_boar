app = angular.module("requirements", ["ngResource"]);

app.controller("IssuesCtrl", ['$scope', '$resource', '$http', function($scope, $resource, $http){
  var list = this;
  var Issues = $resource("/issues/:id", {id: "@id"}, {score: {method: "POST"}});
  list.issues = Issues.query();

  list.PositiveVote = function(id){
    list.issues.$promise.then(function(){
      var issue = list.issues.filter(function(item){ 
        return item.id == id; 
      })[0];
      $http.post('/issues/score.json', {id: issue.id, vote: 'positive'}).then(function (response){
        issue.positive_votes += 1;
      });
    });
  }

  list.NegativeVote = function(id){
    list.issues.$promise.then(function(){
      var issue = list.issues.filter(function(item){ 
        return item.id == id; 
      })[0];
      $http.post('/issues/score.json', {id: issue.id, vote: 'negative'}).then(function (response){
        issue.negative_votes += 1;
      });
    });
  }

}]);