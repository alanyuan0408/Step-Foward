# -------------------------------------------------------------------------------------------------------
# Page: Your Reference Requests
#
# Summary:
# This is the Your Reference Requests page for DCSUPP for
# professors to view and manage any reference requests by students.
# -------------------------------------------------------------------------------------------------------
controllerFunction = ($scope, modalService, $stateParams, Reference, Project, ProjectApplication, User) ->
    #   pop-up service for page settings + information
    $scope.modalService = modalService

    #   true iff something on this page resulted in an error to alert error message
    $scope.error = false

    #   get all reference requests for this professor
    $scope.getReferenceRequests = () ->
        $scope.references = []
        Reference.getReferenceRequestsOfProfessor().success((data) ->
            $scope.references = data

            #   for each reference request, get student's name and project title and id
            async.each($scope.references, (reference, callback) ->
                async.waterfall([
                        (callback) ->
                            ProjectApplication.getById(reference.project_application_id).success((projectApplication) ->
                                callback(null, projectApplication)
                            )
                        (projectApplication, callback) ->
                            User.getById(projectApplication.user_id).success((student) ->
                                reference.student =
                                    name : student.name
                                callback(null, projectApplication)
                            )
                        (projectApplication, callback) ->
                            Project.getById(projectApplication.project_id).success((project) ->
                                reference.project =
                                    title : project.title
                                    id : project.id
                                callback(null)
                            )
                    ],
                    (err) ->
                        callback()
                )
            , (err) ->
                $scope.err = error != null
            )

        )

    #   reject a reference request
    $scope.rejectReference = (reference) ->
        Reference.processReferenceApproval(reference: reference.id, approved: false).success((data) ->
            $scope.error = false
            $scope.getReferenceRequests()
        ).error((data) ->
            $scope.error = true
        )

    # run this code when page loads
    $scope.getReferenceRequests()

angular
.module('dcsupp')
.controller('YourReferenceRequestsCtrl', ['$scope', 'modalService', '$stateParams', 'Reference', 'Project', 'ProjectApplication', 'User', controllerFunction])