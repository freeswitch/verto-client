(function() {
  'use strict';

  angular
    .module('vertoControllers')
    .controller('ModalDialpadController', ['$scope',
      '$uibModalInstance',
      function($scope, $uibModalInstance) {

        $scope.ok = function() {
          $uibModalInstance.close('Ok.');
        };

        $scope.cancel = function() {
          $uibModalInstance.dismiss('cancel');
        };

      }
    ]);
})();