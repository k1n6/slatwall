"use strict";
var logger;
(function(logger) {
  angular.module('logger').factory('$exceptionHandler', ['$injector', function($injector) {
    return function(exception, cause) {
      var $http = $injector.get('$http');
      var alertService = $injector.get('alertService');
      $http({
        url: '?slatAction=api:main.log',
        method: 'POST',
        data: $.param({
          exception: exception,
          cause: cause,
          apiRequest: true
        }),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'}
      }).error(function(data) {
        console.log(exception);
        alertService.addAlert({
          msg: exception,
          type: 'error'
        });
        console.log(exception);
      });
    };
  }]);
})(logger || (logger = {}));

//# sourceMappingURL=../services/exceptionhandler.js.map