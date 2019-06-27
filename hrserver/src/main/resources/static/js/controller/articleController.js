//控制层
app.controller('articleController', function ($scope, $controller, $location, articleService, uploadService, itemCatService, typeTemplateService) {

    $controller('baseController', {$scope: $scope});//继承


    //读取列表数据绑定到表单中
    $scope.findAll = function () {
        articleService.findAll().success(
            function (response) {
                $scope.list = response;
            }
        );
    }

    //分页
    $scope.findPage = function (page, rows) {
        articleService.findPage(page, rows).success(
            function (response) {
                $scope.list = response.rows;
                $scope.paginationConf.totalItems = response.total;//更新总记录数
            }
        );
    };



    $scope.findArtByUser = function () {
        var hrId = $location.search()['id'];
        if (hrId == null) {
            return;
        }
        articleService.findArtByUser(1, 100000, '', hrId, '').success(
            function (response) {
                $scope.artUser = response.articles;
                $scope.paginationConf.totalItems = response.totalCount;//更新总记录数
            }
        );
    };

    $scope.findHomeArt = function () {
        articleService.findHomeArt().success(
            function (response) {
                $scope.art1 = response.art1;
                $scope.art2 = response.art2;
                $scope.art3 = response.art3;
                $scope.art4 = response.art4;
                $scope.art5 = response.art5;
                $scope.articletop = response.articletop;
                $scope.articlehome = response.articlehome;
            }
        )
    };

    //分页
    $scope.findByCate = function (page, cid, keywords) {
        articleService.findByCate(page, cid, keywords).success(
            function (response) {
                $scope.art = response.articles;
                $scope.paginationConf.totalItems = response.totalCount;//更新总记录数
                console.log(response);

            }
        );
    };

    $scope.cid = '';
    $scope.keywords = '';
    $scope.changes = function (page,keywords) {
        var cid = $location.search()['cid'];
        if (cid == null) {
            return;
        }
        if (page == null || page == '') {
            page = 1;
        }

        $scope.findByCate(page, cid, keywords);


    };


    $scope.htmlContents = '';

    //查询实体
    $scope.getArticleById = function () {
        var aid = $location.search()['id'];
        if (aid == null) {
            return;
        }

        articleService.getArticleById(aid).success(
            function (response) {
                $scope.article = response;
                $scope.htmlContents = response.htmlContent;
                // if (response.success) {
                //     location.href = "notice.html"
                // }

            }
        );
    };

    // $scope.username = "";
    // $scope.password = "";
    $scope.submitClick = function (username, password) {
        articleService.submitClick(username, password).success(
            function (response) {
                $scope.hr = response.obj;
                console.log(response);
                if ($scope.hr != null && response.status == 200) {
                    location.href = "personal.html#?id=" + $scope.hr.id;
                    // $scope.user = response.obj;

                } else {
                    alert(response.msg);
                }
            }
        )
    }


    $scope.hrId = "0";
    $scope.findHrById = function () {
        var hrId = $location.search()['id'];
        if (hrId == null) {
            return;
        }
        articleService.findHrById(hrId).success(
            function (response) {
                $scope.hr = response;
                $scope.hrId = hrId;
            }
        );
    };

    $scope.findSchByUid = function () {
        var hrId = $location.search()['id'];
        if (hrId == null) {
            return;
        }
        articleService.findSchByUid(hrId).success(
            function (response) {
                $scope.sch = response.schedules;
                $scope.schCount = response.count;
            }
        );
    }


    $scope.searchEntity = {};//定义搜索对象
    $scope.keywords = '';//定义搜索对象

    //搜索
    $scope.search = function (page, count) {
        var cid = $location.search()['cid'];
        if (cid == null) {
            return;
        }
        articleService.search(page, count, cid, '').success(
            function (response) {
                art = response.articles;
                $scope.paginationConf.totalItems = response.totalCount;//更新总记录数
            }
        );
    };

    $scope.article = {
        id: -1,
        title: "",
        htmlContent: "",
        mdContent: "",

        cid: "",
        uid: "",
        author: "",
        state: 1
    };

    $scope.save = function () {
        var hrId = $location.search()['id'];
        if (hrId == null) {
            return;
        }
        $scope.article.htmlContent = editor.html();
        $scope.article.mdContent = editor.html();
        $scope.article.uid = hrId;

        var serviceObject;
        /*if ($scope.arts.id != null) {
            serviceObject = articleService.update($scope.arts);
        } else {
            serviceObject = articleService.add($scope.arts);
        }*/
        debugger;
        articleService.addArt($scope.article).success(
            function (response) {
                if (response.success) {
                    //重新查询
                    /*alert("保存成功");
                    $scope.entity = {};
                    editor.html("");*/
                    location.href = "personal.html#?id=" + hrId;
                } else {
                    alert(response.msg);
                }
            }
        );
    };


    $scope.uploadFile = function () {
        uploadService.uploadFile().success(function (response) {
                if (response.success) {

                    $scope.image_entity.url = response.message;

                } else {
                    alert(response.message)
                }
            }
        ).error(function () {
            alert("上传发生错误");
        })
    };

    $scope.findSysName = function () {
        articleService.findSysName().success(
            function (response) {
                $scope.sys = response[0];

            })
    }


});
