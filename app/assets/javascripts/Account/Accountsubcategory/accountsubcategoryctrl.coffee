# -------------------------------------------------------------------------------------------------------
# UI-View of the subcategoryListing
# -------------------------------------------------------------------------------------------------------
angular.module('dcsupp').controller 'AttributeSubCategoryCtrl', 
    ['$scope','$stateParams', '$state', 'User','RequirementSubcategory', 
    'RequirementCategory', 'StudentAttribute', 
    ($scope, $stateParams, $state, User, RequirementSubcategory, RequirementCategory, StudentAttribute) ->

        #------------------------------------------------------
        #                   Scope Variables
        #------------------------------------------------------

        #   SINGLE OBJECT: Selected Category: AJAX populated
        $scope.category = null
        #   SINGLE OBJECT: Selected Category: ng-click populated
        $scope.selectsubCategory = null
        #   LIST: SubCategories of $scope.category: AJAX populated
        $scope.subcategories = []
        #   LIST: Attribute Categories of $scope.category: AJAX populated
        $scope.attribute_subcategory = []
        #   LIST: Merge List of $scope.subcategories and $scope.attribute_subcategory: Angular Construct
        $scope.merged_category = []
        #   MODEL: ng-input model used by users to input describe attributes: ng-input populated
        $scope.edit =
            input_number: null
            input_text: null
            input_boolean: false
            input_date: new Date()
        #   MODEL: ng-input model used to reset $scope.edt: Angular Construct
        $scope.editBlank =
            input_number: null
            input_text: null
            input_boolean: false
            input_date: new Date()

        #------------------------------------------------------
        #                   Scope Functions
        #------------------------------------------------------

        # --- Update Entry --- 
        #Send the SubCategory Information to the backend
        $scope.update = ()->
            if ($scope.selectsubCategory.student_attribute)
                $scope.edit.subcategory_id = $scope.selectsubCategory.id
            else
                $scope.edit.subcategory_id = $scope.selectsubCategory.requirement_subcategory_id
            $scope.edit.category_id = $stateParams.id

            StudentAttribute.createAttribute($scope.edit).success (data)->
                $scope.unselectEdit()

        # --- Edit Entry --- 
        #Enable Editing for the selected SubCategory
        $scope.edit_entry = (subcategory) ->
            #If Attribute was previously created, set the default value
            $scope.edit = angular.copy($scope.editBlank)
            console.log(subcategory)

            if (subcategory.type == 'attribute')
                #Set the selected is an attribute
                for category in $scope.subcategories
                    if (category.id == subcategory.requirement_subcategory_id)
                        $scope.selectsubCategory = category

                #Set the Edit to the previous default value
                if ($scope.selectsubCategory.attribute_type == "Number")
                    $scope.edit.input_number = parseInt(subcategory.value)
                else if ($scope.selectsubCategory.attribute_type == "Date")
                    $scope.edit.input_date = new Date(subcategory.value)
                else if ($scope.selectsubCategory.attribute_type == "Boolean")
                    if (subcategory.value == 't')
                        $scope.edit.input_boolean = true
                    else
                        $scope.edit.input_boolean = false
                else if ($scope.selectsubCategory.attribute_type == "Input Field")
                    $scope.edit.input_text = subcategory.value
            else
                #Select is a category
                for category in $scope.subcategories
                    if (category.id == subcategory.id)
                        $scope.selectsubCategory = category

            #Set the attribute to edit true
            for category in $scope.merged_category
                if (category.id == subcategory.id)
                    category.edit = true
                else if (category.edit)
                    category.edit = false

            return

        #------------------------------------------------------
        #                   Helper Functions
        #------------------------------------------------------

        # --- Unselect Edit ---
        $scope.unselectEdit = ->
            #Change the Category Edit to false
            for category in $scope.merged_category
                if (category.edit)
                    category.edit = false
            $scope.edit = angular.copy($scope.editBlank)
            $scope.getCategory()
            return

        # --- Check Student Attribute ---
        $scope.student_attribute_available = (attribute_id) ->
            #Iterate Over the Array [The Array is JSON]
            for key, category of $scope.attribute_subcategory
                if (category.requirement_subcategory_id == attribute_id)
                    return category
            return false

        #------------------------------------------------------
        #              Initialization Functions
        #------------------------------------------------------

        # --- Get SubCategory --- (Initialization Function: 1)
        $scope.getCategory = ->
            payload =
                id: $stateParams.id
            RequirementCategory.category(payload).success (data) ->
                $scope.category = data
                $scope.loadSubcategories($scope.category)
            return

        # --- Grab SubCategories --- (Initialization Function: 2)
        $scope.loadSubcategories = (category)->
            payload =
                target_id: category.id
            RequirementSubcategory.getAllOfCategory(payload).success (data) ->
                $scope.subcategories = data
                $scope.userAttributes($scope.category)
            return

        # --- Grab User Settings --- (Initialization Function: 3)
        $scope.userAttributes = (category)->
            StudentAttribute.getallUserAttribute(category.id).success (data) ->
                $scope.attribute_subcategory = data
                $scope.mergeCategories()
            return

        # --- Merge Attribute and Categories --- (Initialization Function: 4)
        $scope.mergeCategories = ->
            #Emtpy the subcategories array
            if $scope.merged_category
                $scope.merged_category.length = 0

            category_id = 1
            for category in $scope.subcategories
                #Filter out the none Student Attributes
                if category.student_attribute
                    if $scope.student_attribute_available(category.id)
                        append_category = $scope.student_attribute_available(category.id)
                        append_category.sub_category_name = category.sub_category_name
                        append_category.type = "attribute"
                        append_category.edit = false
                        append_category.id = category_id
                        $scope.merged_category.push(append_category)
                    else
                        category.type = "category"
                        category.edit = false
                        category.id = category_id
                        $scope.merged_category.push(category)
                category_id = category_id + 1

        # --- Initialization ---
        $scope.getCategory()
    ]