angular.module('dcsupp').controller('CreateProjectCtrl', ['$scope', '$modal', function ($scope, $modal) {
    $scope.page = "create project";

    $scope.items = ['item1', 'item2', 'item3'];

    $scope.open = function (size) {

        var modalInstance = $modal.open({
            animation: true,
            templateUrl: 'CreateProject/CreateProjectSettings/create_project_settings.html',
            controller: 'CreateProjectSettingsCtrl',
            size: size,
            resolve: {
                items: function () {
                    return $scope.items;
                }
            }
        });

        modalInstance.result.then(function (selectedItem) {
            $scope.selected = selectedItem;
        }, function () {
        });
    };

}]);
