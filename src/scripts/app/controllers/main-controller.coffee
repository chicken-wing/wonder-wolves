
app.controller 'MainController', ($scope, $rootScope) ->

    $scope.subview = 'search'

    $rootScope.teams = [
        {
            name: 'Unicorns'
        }
        {
            name: 'Wombats'
        }
        {
            name: 'Supsups'
        }
    ]
