AccountFunction = ($scope, $modal, modalService, requestService, User, $state) ->
        
    $scope.modalService = modalService

    # --- Page Variables ----
        
    $scope.items = [
        'item1'
        'item2'
        'item3'
    ]

    $scope.nameCollapsed = $scope.emailCollapsed = true
    $scope.user = {}
    $scope.pagenumber = 1
    $scope.categories = null

    # --- Get User ---

    $scope.getUser = ->
        User.getUser().success((data) ->
            $scope.user = data
            $scope.payload = jQuery.extend(true, {}, data))
        return

    # --- Patch User --- 

    $scope.patchUser = ->
        patchSendParams =
            url: '/users/' + $scope.user.id + '.json'
            method: 'PATCH'
        requestService.service(patchSendParams, $scope.payload).success((data) ->
            $scope.getUser())
        return

    $scope.updateProject = ->
        $state.go('update_project', {id: 1})

    # --- Settings Navigation --- 

    $scope.flip = (pushDirection) ->
        payload = 
            direction: pushDirection
            pagenumber: $scope.pagenumber
        sendParams =
            method: 'POST'
            url: '/flip_student_settings.json'
        $scope.direction = pushDirection

        requestService.service(sendParams, payload).success(flipSuccess)

    flipSuccess = (data) ->
        if (data)
            $scope.categories = data
            if $scope.direction > 0
                $scope.pagenumber += 1
            else if $scope.direction < 0
                $scope.pagenumber -= 1
            else
                $scope.pagenumber = 1

    # --- Jquery Initialization --- 
    $scope.getUser()
    $scope.flip(0)

angular.module('dcsupp').controller('AccountCtrl', ['$scope',
    '$modal', 'modalService', 'requestService', 'User', '$state', AccountFunction])