# -------------------------------------------------------------------------------------------------------
# UI-View of the subcategoryListing
# -------------------------------------------------------------------------------------------------------


PersonalIntroductionFunction = ($scope, $modal, modalService, requestService, User, $state, StudentAttribute) ->

    #Edit SubCategory
    $scope.userInformation =
        input_email: ""
        input_text: ""

    # --- Get User ---
    # Grab the User Attribute
    $scope.getUser = ->
        User.getUser().success (data) ->
            $scope.user = data
            #Get Previous User Information
            $scope.userInformation.input_email = $scope.user.contact_email
            $scope.userInformation.input_text = $scope.user.introduction
        return

    # --- Update User ---
    # Update the User's Information
    $scope.updateUser = ->
        User.updateUser($scope.userInformation).success (data) ->
            $scope.userInformation = angular.copy($scope.userInformationBlank)
        return

    # --- Jquery Initialization --- 
    $scope.getUser()

angular.module('dcsupp').controller('PersonalIntroductionCtrl', ['$scope',
                                                    '$modal', 'modalService', 'requestService', 'User', '$state',
                                                    'StudentAttribute', PersonalIntroductionFunction])