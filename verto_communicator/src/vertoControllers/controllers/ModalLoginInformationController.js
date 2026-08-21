(function() {
  'use strict';

  angular
    .module('vertoControllers')
    .controller('ModalLoginInformationController', ['$scope',
      '$http', '$location', '$uibModalInstance', 'verto', 'storage',
      function($scope, $http, $location, $uibModalInstance, verto, storage) {
        console.debug('Executing ModalLoginInformationController.');

        $scope.verto = verto;
        $scope.storage = storage;

        $scope.ok = function() {
          $uibModalInstance.close('Ok.');
        };

        $scope.cancel = function() {
          $uibModalInstance.dismiss('cancel');
        };

        verto.data.name = storage.data.name;
        verto.data.email = storage.data.email;

      }
    ]);

})();
