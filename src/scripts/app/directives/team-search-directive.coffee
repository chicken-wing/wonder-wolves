

app.directive 'teamSearch', ->
    restrict: 'E'
    scope:
        teams: '='
        foundTeams: '='
    replace: true
    templateUrl: '/widgets/widget-team-search.html'
    link: ($scope) ->


app.directive 'teamList', ->
    restrict: 'E'
    scope:
        teams: '='
    replace: true
    templateUrl: '/widgets/widget-team-list.html'
    link: ($scope) ->

        $scope.$watch 'teams', ->
            $scope.selectedTeams = []

        $scope.selectTeam = (team) ->
            $scope.selectedTeams.push team


app.directive 'nlTeamSearchForm', ->
    restrict: 'E'
    transclude: true
    replace: true
    template: '<form ng-transclude></form>'
    link: ($scope) ->
        $scope.nlSelects =
            who:
                options:  [
                    'Great Grandmothers'
                    'Sexy People'
                    'bacons'
                ]
                value: null
