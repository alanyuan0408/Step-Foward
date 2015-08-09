controllerFunction = ($scope, $stateParams, ProjectApplication, ProjectRequirement, RequirementSubcategory, StudentAttribute) ->
    $scope.attributes = []

#
#    $scope.loadStudentAttributes = ->
#        payload = project: $stateParams.id
#        ProjectRequirement.getByProject(payload).success((projectRequirements) ->
#            for req in projectRequirements
#                    payload = subcategory: req.requirement_subcategory_id
#                    StudentAttribute.getBySubcategoryAndCurrentUser(payload).success((studentAttribute) ->
#                        $scope.attributes.push(studentAttribute)
#                    )
#                )

    $scope.loadApplicationInfo = ->
        ProjectApplication.getById($stateParams.id).success((data) ->
            $scope.application = data
            payload = project: data.project_id
            ProjectRequirement.getByProject(payload).success((projectRequirements) ->
                for req in projectRequirements
                    RequirementSubcategory.getById(req.requirement_subcategory_id).success((subcategory) ->
                        payload = subcategory: subcategory.id
                        StudentAttribute.getBySubcategoryAndCurrentUser(payload).success((studentAttribute) ->
                            $scope.attributes.push(sub_category_name: subcategory.sub_category_name, value: studentAttribute.value)
                        )
                    )
            )
        )


    $scope.loadApplicationInfo()




angular
.module('dcsupp')
.controller('ApplicationInfoCtrl', ['$scope', '$stateParams', 'ProjectApplication', 'ProjectRequirement', 'RequirementSubcategory', 'StudentAttribute', controllerFunction])