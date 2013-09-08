
app.controller 'MainController', ($scope, $rootScope, DataService) ->

    $scope.subview = 'search'
    $scope.modalActive = false

    $rootScope.compareTeams = (teams) ->
        $scope.selectedTeams = teams
        $scope.subview = 'compare'

    $rootScope.listTeams = (teams) ->
        $scope.subview = 'list'
        $scope.matchedTeams = teams

    $rootScope.goToSearchPage = ->
        $scope.subview = 'search'
        $scope.matchedTeams = []

    $rootScope.teams = _.map DataService.teams, (team) ->
        team.projects = _.sortBy team.projects, (project) -> project.languages.length
        team.projects = _.reject team.projects, (project) -> project.languages.length is 0
        console.log
        return team