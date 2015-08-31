
# -------------------------------------------------------------------------------------------------------
# Page 2: Account Page
#
# Summary:
# This is the Account Page for DCSUPP. It contains the student settings and allows students to change their 
# personal information. The student settings can be added, removed or modified in the Manage Categories
# tab and all categories containing Student Settings are listed on the left and all subcategories within
# the categories that are student settings are listed on the right. The information is populated using
# angular $http calls and stored as scope variables.
#
# Page Placement [Referred to in the Comments]:
#
# [Left-Side]
# The Navigation panel with [prev][pagenumber][next]. The main categories are listed here.

# [Right-Side]
# The SubCategories within the main categories are listed here. SubCategories can be modified 
#
# [Top-right]
# Popup button, displays the Information and Settings Popup menus.
# -------------------------------------------------------------------------------------------------------


AccountFunction = ($scope, $modal, modalService, requestService, User, $state, RequirementSubcategory, StudentAttribute) ->
        
    # --- Page Variables ----

    #Scope Varaible Used in Popup Identification
    $scope.modalService = modalService

    $scope.items = [
        'item1'
        'item2'
        'item3'
    ]

    #Javascript Object Storing Current User Information
    $scope.user = null
    #Page Number in Left-Side Navigation (Categories listed below Prev [pageNumber] Next)
    $scope.pagenumber = 1
    #List of Categories in Left-Side Navigation
    $scope.categories = null
    #Current Selected Category in Left-Side Navigation
    $scope.selectCategory = null

    #Edit SubCategory
    $scope.edit =
        input_number: 0
        input_text: ""
        input_boolean: false
        input_date: new Date()
    #edit Global Blank
    $scope.editBlank =
        input_number: 0
        input_text: ""
        input_boolean: false
        input_date: new Date()

    #Student Attribute SubCategory Information [Pulled from backend]
    $scope.attribute_subcategory = null
    #SubCategories within the Selected Category
    $scope.subcategories = null
    $scope.merged_category = []

    # --- Merge Attribute + Categories ---
    # Merge the SubCategories with the student attributes for display purposes
    $scope.mergeCategories = ->
        #Emtpy the subcategories array
        $scope.merged_category.length = 0

        for category in $scope.subcategories
            if category.student_attribute
                if $scope.studentAttribute(category.id)
                    #The student Attribute is availble
                    append_category = studentAttribute(category.id)
                    append_category.type = "attribute"
                    append_category.edit = false
                    $scope.merged_category.push(append_category)
                else
                    category.type = "category"
                    category.edit = false
                    $scope.merged_category.push(category)
        console.log($scope.merged_category)

    # --- Update Entry ---

    $scope.update = ->

        #Clear the Edit Form from Frontend + Send Information to Backend
        $scope.edit = angular.copy($scope.editBlank)

        for category in $scope.merged_category
            if (category.edit)
                category.edit = false
        return

    # --- Edit Entry ---

    $scope.edit_entry = (id) ->
        $scope.edit = angular.copy($scope.editBlank)

        for category in $scope.merged_category
            if (category.id == id)
                category.edit = true
            else if (category.edit)
                category.edit = false
        return

    # --- Get User ---

    $scope.getUser = ->
        User.getUser().success (data) ->
            $scope.user = data
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

    # --- Grab User Settings ---

    $scope.userAttributes = (category_id)->
        StudentAttribute.getallUserAttribute($scope.user.id, category_id).success (data) ->
            $scope.attribute_subcategory = data
            $scope.mergeCategories()
        return

    # --- Grab SubCategories ---

    $scope.loadSubcategories = (category)->
        payload =
            target_id: category.id

        # Selected SubCategory
        $scope.selectCategory = category
        RequirementSubcategory.getAllOfCategory(payload).success (data) ->
            $scope.subcategories = data
            $scope.userAttributes(category.id)
        return

    # --- Check Student Attribute ---

    $scope.studentAttribute = (id) ->
        #Iterate Over the Array
        for category of $scope.attribute_subcategory
            if (category.id == id)
                return category
        return false

    # --- Submit Student Attribute

    ###
    $scope.submit = () ->
        value = null
        payload =
            url: '/student_attributes.json'
            value: value

    ###

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
    $scope.flip(0)
    $scope.getUser()

angular.module('dcsupp').controller('AccountCtrl', ['$scope',
    '$modal', 'modalService', 'requestService', 'User', '$state', 'RequirementSubcategory', 'StudentAttribute', AccountFunction])