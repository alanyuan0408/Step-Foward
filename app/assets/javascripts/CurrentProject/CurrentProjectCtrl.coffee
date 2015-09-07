# ---------------------------------------------------------
# Page 3: Current Project
#
# This is the current projects page for the application. It
# lists the current projects students can apply for and it
# includes the requirements students will need to access.
# ---------------------------------------------------------

controllerFunction = ($scope, modalService, Project, RequirementSubcategory, $q) ->

	$scope.modalService = modalService
	$scope.projects = null
	$scope.direction = 0
	$scope.filter = 'In progress'
	$scope.subcategories = []
	$scope.requirements = []

	$scope.items = [
		'item1'
		'item2'
		'item3'
	]
	$scope.pagenumber = {current: 0, completed: 0, inProgress: 0}

#	$scope.flipInProgress = (pushDirection) ->
#		payload =
#			direction: pushDirection
#			pagenumber: $scope.pagenumber.inProgress
#		$scope.direction = pushDirection
#
#		Project.flipInProgress(payload).success((data) ->
#			if (data)
#				$scope.projects = data
#				if $scope.direction > 0
#					$scope.pagenumber.inProgress += 1
#				else if $scope.direction < 0
#					$scope.pagenumber.inProgress -= 1
#				else
#					$scope.pagenumber.inProgress = 1
#
#				$scope.pagenumber.current = $scope.pagenumber.inProgress
#		)
#
#	$scope.flipCompleted = (pushDirection) ->
#		payload =
#			direction: pushDirection
#			pagenumber: $scope.pagenumber.completed
#		$scope.direction = pushDirection
#
#		Project.flipCompleted(payload).success((data) ->
#			if (data)
#				$scope.projects = data
#				if $scope.direction > 0
#					$scope.pagenumber.completed += 1
#				else if $scope.direction < 0
#					$scope.pagenumber.completed -= 1
#				else
#					$scope.pagenumber.completed = 1
#				$scope.pagenumber.current = $scope.pagenumber.inProgress
#		)

#	$scope.loadSubcategories = () ->
#		RequirementSubcategory.getAll().success((data) ->
#			for item in data
#				$scope.subcategories.push({name: item.sub_category_name, id: item.id})
#		)


	#	get Project filter tags by keyword
	$scope.loadTags = (query) ->
		deferred = $q.defer();
		RequirementSubcategory.studentAttributeRequirementSubcategoriesWithKeyword(keyword: query)
		.success((data) ->

			deferred.resolve(data.map((val) ->
				name: val.sub_category_name
				id: val.id
			)))
		return deferred.promise

	#	filter list of projects
	$scope.filterProjects = () ->
		Project.filterProjects(filter: $scope.requirements).success((data) ->
			$scope.projects = data
		)


	# --- JQuery Initialization Code ---

	$('[data-toggle="tooltip"]').tooltip()
#	$scope.loadSubcategories()
	$scope.filterProjects();


angular
.module('dcsupp')
.controller('CurrentProjectCtrl', ['$scope', 'modalService', 'Project', 'RequirementSubcategory','$q', controllerFunction])
