

app.directive 'teamSearch', ->
    restrict: 'E'
    scope:
        teams: '='
        foundTeams: '='
    replace: true
    templateUrl: '/widgets/widget-team-search.html'
    link: ($scope) ->



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



app.directive 'teamList', ($timeout, $rootScope) ->
    restrict: 'E'
    scope:
        teams: '='
        selectedTeams: '='
    replace: true
    templateUrl: '/widgets/widget-team-list.html'
    link: ($scope) ->
        $scope.focusedTeamIndex = 0

        $scope.showPreviousTeam = ->
            if $scope.focusedTeamIndex < 1
                $scope.focusedTeamIndex = $scope.availableTeams.length
            $scope.focusedTeamIndex = $scope.focusedTeamIndex - 1

        $scope.showNextTeam = ->
            $scope.focusedTeamIndex = ($scope.focusedTeamIndex + 1) % $scope.availableTeams.length

        $scope.selectTeam = (team) ->
            $scope.selectedTeams.push team
            $scope.selectedTeams = _.filter $scope.selectedTeams, do ->
                seen = {}
                (team) ->
                    return (seen[team.id] = true) if not seen[team.id]
                    return false

        $scope.compareTeams = $rootScope.compareTeams

        $scope.$watch 'selectedTeams', (selectedTeams) ->
            $scope.availableTeams = do ->
                selectedIds = _.map selectedTeams, (team) -> team.id
                _.reject $scope.teams, (team) -> team.id in selectedIds
            $scope.focusedTeamIndex = Math.min($scope.focusedTeamIndex, $scope.availableTeams.length-1)

        $scope.$watch 'teams', (teams) ->
            $scope.selectedTeams = []
            $scope.availableTeams = teams

        $scope.$watch 'focusedTeamIndex', (index) ->
            $scope.focusedTeam = $scope.availableTeams[index]



app.directive 'teamDetails', ->
    restrict: 'E'
    scope:
        team: '='
    replace: true
    templateUrl: '/widgets/widget-team-details.html'
    link: ($scope) ->



app.directive 'teamCompare', ->
    restrict: 'E'
    scope:
        teams: '='
    replace: true
    templateUrl: '/widgets/widget-team-compare.html'
    link: ($scope) ->
        console.log $scope.teams

