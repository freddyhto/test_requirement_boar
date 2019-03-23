app = angular.module("requirements", ["ngResource"]);

app.controller("IssuesCtrl", function($scope, $resource){
  var list = this;
  var Issues = $resource("/issues/:verb/:id", {id: "@id"}, {score: {method: "POST"}});
  list.issues = Issues.query();

  list.PositiveVote = function(id){
    list.issues.$promise.then(function(){
      var issue = list.issues.filter(function(item){ return item.id == id; })[0];
      issue.$score({verb: "score", vote: "positive"});
    });
  }

  list.NegativeVote = function(id){
    console.log(id)
  }
    //{id: "", title: "", description: "", positive_point: "", negative_point: ""}
});