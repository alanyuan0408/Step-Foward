# -------------------------------------------------------------------------------------------------------
# UI-Router state declaration for Index.
# -------------------------------------------------------------------------------------------------------
angular.module('dcsupp').config(['$stateProvider', ($stateProvider) ->
    $stateProvider.state '/',
        url: '/?:goto'
        controller: 'IndexCtrl'
])