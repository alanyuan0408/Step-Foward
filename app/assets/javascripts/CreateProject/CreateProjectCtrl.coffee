controllerFunction = ($scope, requestService, modalService, User) ->
	$scope.modalService = modalService

	$scope.project =
		title: ""
		text: ""
	$scope.projectDefault =
		title: ""
		text: ""
	$scope.sendParams =
		url: '/projects.json'
		method: "POST"

	successFunction = (data) ->
		console.log("Created Project")
		clearForm()


	clearForm = ->
		$scope.project = angular.copy($scope.projectDefault)


	$scope.create = ->
		User.getUser().success((data) ->
			$scope.payload =
				project:
					title: $scope.project.title
					text: $scope.project.text
					user_id: data.id

			requestService.service($scope.sendParams, $scope.payload).success(successFunction)
		)


	$('[data-toggle="tooltip"]').tooltip()


angular
	.module('dcsupp')
	.controller('CreateProjectCtrl', ['$scope', 'requestService', 'modalService', 'User', controllerFunction])

