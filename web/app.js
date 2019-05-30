var app = angular.module('ThueXe',['ngRoute']);

app.config(['$qProvider', function ($qProvider,$httpProvider) {
    $qProvider.errorOnUnhandledRejections(false);
    // $httpProvider.defaults.useXDomain = true;
    // delete $httpProvider.defaults.headers.common['X-Requested-With'];
}]);

app.controller('TTXE',
    function ($scope,$http) {
        
        $http.get("http://localhost:9006/api/thiscontroller/showTTXE")
        .then(function(response){
            $scope.mydata = response.data;
            console.log(response);
        });

        $scope.deleteTTXE = function(index){
            var bsx = $scope.mydata[index].TTX_BSX;
            // var data= {TTX_BSX: bsx};
            console.log(bsx);
            var cf = confirm('Bạn có chắc chắn xóa thông tin này?');
            if(cf == true){
                $http.delete('http://localhost:9006/api/thiscontroller/deleteTTXE?TTX_BSX='+ bsx)
                .then(function(response){
                    
                    if(response.data.Success == true){
                        alert('xóa thành công');
                        console.log(response.data.Success);
                        window.location.reload();
                    }else{
                        alert('Không thể xóa');
                        console.log(response);
                    }
                });
            }
            
        }; //end of deleteTTXE


    }
);


