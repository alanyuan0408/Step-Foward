controllerFunction = ($scope, requestService, $modal, modalService) ->

	$scope.modalService = modalService

	# --- Page Variables ----

	$scope.pagenumber = 1
	$scope.projects = null
	$scope.direction = 0

	$scope.items = [
		'item1'
		'item2'
		'item3'
	]

	# --- Project Navigation ---

	$scope.flip = (pushDirection) ->
		payload = 
			direction: pushDirection
			pagenumber: $scope.pagenumber
		$scope.direction = pushDirection
		sendParams =
			method: 'POST'
			url: '/flip_project_direction.json'

		requestService.service(sendParams, payload).success(successFunction)

	successFunction = (data) ->
		if (data)
			$scope.projects = data
			if $scope.direction > 0
				$scope.pagenumber += 1
			else if $scope.direction < 0
				$scope.pagenumber -= 1
			else
				$scope.pagenumber = 1

	# --- JQuery Initialization Code ---

	$('[data-toggle="tooltip"]').tooltip()
	$scope.flip(0)

angular
.module('dcsupp')
.controller('CurrentProjectCtrl', ['$scope', 'requestService', '$modal', 'modalService', controllerFunction])
