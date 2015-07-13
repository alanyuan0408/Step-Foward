controllerFunction = ($scope, requestService) ->

    $scope.category_name = ""
    $scope.category_nameDefault = ""

    $scope.category =
        sub_category_name: ""
        attribute_type: "Number"
        placeholder: ""
        student_attribute: 0
    $scope.categoryDefault =
        sub_category_name: ""
        attribute_type: "Number"
        placeholder: ""
        student_attribute: 0

    $scope.pagenumber = 1
    $scope.sendParams_category =
        method: 'POST'
        url: '/requirement_categories.json'
    $scope.sendParams_subcategory =
        method: 'POST'
        url: '/requirement_subcategories.json'


    $scope.getCSS = ->
        console.log("clicked")
        if $scope.category.student_attribute
            $scope.category.student_attribute = 0
            $("#student_attribute").addClass("btn-default").removeClass("btn-primary")
            $("#student_attribute").html("False")
        else
            $scope.category.student_attribute = 1
            $("#student_attribute").addClass("btn-primary").removeClass("btn-default")
            $("#student_attribute").html("True")


    successFunction = (data) ->
        console.log("success")
        clearForm()

    successFunction2 = (data) ->
        console.log("success")
        clearForm2()

    clearForm = ->
        $scope.category_name = angular.copy($scope.category_nameDefault)

    clearForm2 = ->
        $scope.category = angular.copy($scope.categoryDefault)


    $scope.create_category = ->
        $scope.payload_category = 
            requirement_category:
                category_name: $scope.category_name

        requestService.service($scope.sendParams_category, $scope.payload_category).success(successFunction)

    $scope.create_subcategory = ->
        $scope.payload_category = 
            requirement_subcategory:
                sub_category_name: $scope.category.sub_category_name
                attribute_type: $scope.category.attribute_type
                placeholder: $scope.category.placeholder
                student_attribute: $scope.category.student_attribute

        requestService.service($scope.sendParams_subcategory, $scope.payload_category).success(successFunction2)


    $('[data-toggle="tooltip"]').tooltip()


angular
    .module('dcsupp')
    .controller('ManageCategoryCtrl', ['$scope', 'requestService', controllerFunction])