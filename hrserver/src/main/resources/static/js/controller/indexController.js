app.controller("indexController", function ($scope,$controller, loginService1) {
    $scope.showLoginName = function () {
        loginService1.loginName().success(
            function (response) {
            $scope.loginName = response.loginName;
        })
    }

});