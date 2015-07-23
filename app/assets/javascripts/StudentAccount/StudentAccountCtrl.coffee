angular.module('dcsupp').controller 'StudentAccountCtrl', [
    '$scope'
    '$modal'
    'modalService'
    'requestService'
    'User'
    ($scope, $modal, modalService, requestService, User) ->
        $scope.modalService = modalService
        $scope.items = [
            'item1'
            'item2'
            'item3'
        ]

        $scope.nameCollapsed = $scope.emailCollapsed = true
        $scope.student = {}
        $scope.payload = {}

        $scope.getStudent = ->
            User.getUser().success((data) ->
                $scope.student = data
                $scope.payload = jQuery.extend(true, {}, data))
            return

        $scope.patchStudent = ->
            patchSendParams =
                url: '/users/' + $scope.student.id + '.json'
                method: 'PATCH'
            requestService.service(patchSendParams, $scope.payload).success((data) ->
                $scope.getStudent())
            return

        $scope.getStudent();
]