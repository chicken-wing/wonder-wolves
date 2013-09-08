

app.directive 'teamSearch', ->
    restrict: 'E'
    scope:
        teams: '='
        foundTeams: '='
    replace: true
    templateUrl: '/widgets/widget-team-search.html'
    link: ($scope) ->



app.service 'TeamFinder', ($rootScope) ->

    findTeamsWithLanguage = (teams, language) ->
        result = _.filter teams, (team) ->
            languages = _.flatten _.map team.projects, (project) -> project.languages
            return language in languages
        return result

    findTeamsWithLanguages = (teams, languages) ->
        teamSets = _.map languages, (language) -> findTeamsWithLanguage teams, language
        return _.flatten _.map teamSets, do ->
            seen = {}
            (teams) -> _.filter teams, (team) ->
                return false if seen[team.name]
                return (seen[team.name] = true)

    searchHandler: (teams, searchResults) ->
        results =
            who:  searchResults.who.value
            when: searchResults.when.value
            what: searchResults.what.value
        $rootScope.langs = results.who
        return findTeamsWithLanguages teams, results.who



app.directive 'nlTeamSearchForm', ($rootScope, TeamFinder) ->
    restrict: 'E'
    transclude: true
    replace: true
    template: '<form ng-transclude></form>'
    link: ($scope) ->

        values =
            who:
                ios:            ['Obj-C']
                web:            ['Scala', 'Ruby', 'Javascript']
                php:            ['PHP']
                java:           ['Java']
                frontend:       ['HTML', 'CSS', 'Javascript']
                nocturnal:      ['Clojure']
                sexy:           ['Javascript']

        $scope.nlSelects =
            who:
                options:  [
                    {label:'iOS Ninjas',value:values.who.ios}
                    {label:'Web Ballers',value:values.who.web}
                    {label:'PHP Noobs',value:values.who.php}
                    {label:'Java Singleton Factory Makers', value:values.who.java}
                    {label:'Frontend Hipsters',value:values.who.frontend}
                    {label:'Sexy People',value:values.who.sexy}
                    {label:'Nocturnal Neckbeards',value:values.who.nocturnal}
                ]
            what:
                options: [
                    'Mobile App'
                    'Web Service'
                    'SUPER AWESOME IDEA!!'
                    'Website'
                    'Prototype'
                    'Landing Page'
                    'Disaster'
                ]
            when:
                options: [
                    'Next Month'
                    'Next Week'
                    'Tomorrow'
                    'Yesterday'
                ]

        $scope.submitForm = ->
            teams = TeamFinder.searchHandler $scope.teams, $scope.nlSelects
            $rootScope.listTeams teams






app.directive 'teamList', ($timeout, $rootScope) ->
    restrict: 'E'
    scope:
        teams: '='
        selectedTeams: '='
    replace: true
    templateUrl: '/widgets/widget-team-list.html'
    link: ($scope) ->
        $scope.focusedTeamIndex = 0

        $scope.activateModal = ->
            $rootScope.modalActive = true

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
                    return (seen[team.name] = true) if not seen[team.name]
                    return false

        $scope.compareTeams = $rootScope.compareTeams

        $scope.$watch 'selectedTeams', (selectedTeams) ->
            $scope.availableTeams = do ->
                selectedIds = _.map selectedTeams, (team) -> team.name
                _.reject $scope.teams, (team) -> team.name in selectedIds
            $scope.focusedTeamIndex = Math.min($scope.focusedTeamIndex, $scope.availableTeams.length-1)

        $scope.$watch 'teams', (teams) ->
            $scope.selectedTeams = []
            $scope.availableTeams = teams

        $scope.$watch 'focusedTeamIndex', (index) ->
            $scope.focusedTeam = $scope.availableTeams[index]


app.directive 'teamDetails', ($rootScope) ->
    restrict: 'E'
    scope:
        team: '='
    replace: true
    templateUrl: '/widgets/widget-team-details.html'
    link: ($scope) ->
        $scope.langs = $rootScope.langs
        $scope.langUsed = (language) ->
            language in $scope.langs
        $rootScope.$watch 'modalActive', (modalActive) ->
            $scope.modalActive = modalActive
        $scope.goToSearchPage = ->
            $rootScope.modalActive = false
            $rootScope.goToSearchPage()


app.directive 'teamCompare', ->
    restrict: 'E'
    scope:
        teams: '='
    replace: true
    templateUrl: '/widgets/widget-team-compare.html'
    link: ($scope) ->
        console.log $scope.teams

