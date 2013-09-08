

app.constant 'ROUTES',

    index:
        url: '/'
        templateUrl: 'partials/view-team-search.html'
        controller:  'TeamSearchController'

    teamsSearch:
        url: '/teams/search'
        templateUrl: 'partials/view-team-search.html'
        controller:  'TeamSearchController'

    # teamsList:
    #     url: '/teams/list'
    #     templateUrl: 'partials/view-team-list.html'
    #     controller:  'TeamListController'

    # teamsDetails:
    #     url: '/teams/:teamId'
    #     templateUrl: 'partials/view-team-list.html'
    #     controller:  'TeamDetailsController'



app.config ($routeProvider, ROUTES) ->
    resolve =
        data: 'DataService'

    for id, route of ROUTES
        options = _.pick route, 'templateUrl', 'controller'
        options.resolve = resolve
        console.log route, options
        $routeProvider.when route.url, options

    $routeProvider.otherwise redirectTo:'/teams/search'



app.directive 'route', ($rootScope, $location) ->

    class RouteViewModel
        constructor: (@route) -> @active = false

    scope:
        route: '='

    restrict: 'A'
    replace: true
    template: \
    """
    <a ng-href="/\#{{ route.url }}">
        <i class="icon-{{ route.icon }} icon-route-{{ route.id }}"></i>
        {{ route.label }}
    </a>
    """
    link: (scope, element, attributes) ->
        scope.route.id = scope.route.label.toLowerCase()
        scope.$on '$routeChangeSuccess', ->
            isActive = scope.route.url is $location.path()
            scope.route.active = isActive



