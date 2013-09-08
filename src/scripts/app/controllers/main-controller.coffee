
app.controller 'MainController', ($scope, $rootScope, DataService) ->

    $scope.subview = 'list'

    $rootScope.compareTeams = (teams) ->
        $scope.selectedTeams = teams
        $scope.subview = 'compare'

    $rootScope.listTeams = (teams) ->
        $scope.subview = 'list'

    $rootScope.teams = DataService.teams

    # $rootScope.teams = [
    #     {
    #         id: _.uniqueId()
    #         name: 'Disrupt Studio'
    #         city: 'New York City'
    #         members: [
    #             {
    #                 name: 'Wayne Spiegel'
    #                 languages: [
    #                     'HTML5'
    #                     'JavaScript'
    #                     'CSS'
    #                     'Jade'
    #                 ]
    #                 skills: [
    #                     'UI Design'
    #                     'UX Design'
    #                     'Interaction Design'
    #                     'Front-end Development'
    #                 ]
    #                 portfolio: [
    #                 ]
    #             }
    #         ]
    #     }
    #     {
    #         id: _.uniqueId()
    #         name: 'Wombat Studio'
    #         city: 'New York City'
    #         members: [
    #             {
    #                 name: 'Wayne Spiegel'
    #                 languages: [
    #                     'HTML5'
    #                     'JavaScript'
    #                     'CSS'
    #                     'Jade'
    #                 ]
    #                 skills: [
    #                     'UI Design'
    #                     'UX Design'
    #                     'Interaction Design'
    #                     'Front-end Development'
    #                 ]
    #             }
    #         ]
    #     }
    #     {
    #         id: _.uniqueId()
    #         name: 'SupSup Studio'
    #         city: 'New York City'
    #         members: [
    #             {
    #                 name: 'Wayne Spiegel'
    #                 languages: [
    #                     'HTML5'
    #                     'JavaScript'
    #                     'CSS'
    #                     'Jade'
    #                 ]
    #                 skills: [
    #                     'UI Design'
    #                     'UX Design'
    #                     'Interaction Design'
    #                     'Front-end Development'
    #                 ]
    #             }
    #         ]
    #     }
    # ]
