
app.controller 'TeamListController', ($scope) ->
    console.debug 'Teams list controller'

app.controller 'TeamDetailsController', ($scope, $routeParams) ->
    console.debug 'Teams details controller for team', $routeParams.teamId

app.controller 'TeamSearchController', ($scope) ->
    console.debug 'Teams search controller'
