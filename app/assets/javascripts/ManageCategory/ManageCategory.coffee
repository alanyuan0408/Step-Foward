angular.module('dcsupp').config ($stateProvider) ->
    $stateProvider.state 'manage_category',
        url: '/manage_category'
        templateUrl: 'ManageCategory/_manage_category.html'
        controller: 'ManageCategoryCtrl'
        data:
            permissions:
                only: ['administrator', 'professor', 'student']