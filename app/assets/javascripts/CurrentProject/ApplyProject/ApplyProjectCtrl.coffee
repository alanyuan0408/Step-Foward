controllerFunction = ($scope, modalService, $stateParams, $state, ProjectApplication, ProjectRequirement, RequirementSubcategory, StudentAttribute) ->
    $scope.modalService = modalService

    $scope.application = {}
    $scope.attributes = []
    $scope.requirements = []

    $scope.createApplication = () ->
        payload =
            application:
                $scope.application
            requirements:
                $scope.requirements
            project:
                $stateParams.id

        ProjectApplication.create(payload).success((data) ->
            $state.go('your_applications.application_info', {id: data.id}))
        return

    $scope.loadRequirements = () ->
        payload = project: $stateParams.id
        ProjectRequirement.getByProject(payload).success((projectRequirements) ->
            for req in projectRequirements

                RequirementSubcategory.getById(req.requirement_subcategory_id).success((subcategory) ->
                    if subcategory.student_attribute
                        payload = subcategory: subcategory.id
                        StudentAttribute.getBySubcategoryAndCurrentUser(payload).success((studentAttribute) ->
                            attr = id: subcategory.id, attribute_type: subcategory.attribute_type, sub_category_name: subcategory.sub_category_name
                            if studentAttribute.id
                                if subcategory.attribute_type == 'Number' then attr.value = parseInt(studentAttribute.value) else attr.value = studentAttribute.value
                            $scope.requirements.push(attr)
                        )
                )
        )


    $scope.loadRequirements()


angular
.module('dcsupp')
.controller('ApplyProjectCtrl',
    ['$scope', 'modalService', '$stateParams', '$state', 'ProjectApplication', 'ProjectRequirement',
     'RequirementSubcategory', 'StudentAttribute', controllerFunction])
