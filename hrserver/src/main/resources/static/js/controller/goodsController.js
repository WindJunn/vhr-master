//控制层
app.controller('goodsController', function ($scope, $controller, $location, goodsService, uploadService, itemCatService, typeTemplateService) {

    $controller('baseController', {$scope: $scope});//继承

    //读取列表数据绑定到表单中  
    $scope.findAll = function () {
        goodsService.findAll().success(
            function (response) {
                $scope.list = response;
            }
        );
    }

    //分页
    $scope.findPage = function (page, rows) {
        goodsService.findPage(page, rows).success(
            function (response) {
                $scope.list = response.rows;
                $scope.paginationConf.totalItems = response.total;//更新总记录数
            }
        );
    }

    //查询实体
    $scope.findOne = function (id) {
        goodsService.findOne(id).success(
            function (response) {
                $scope.entity = response;
            }
        );
    }

    //保存
    $scope.add = function () {
        $scope.entity.goodsDesc.introduction = editor.html();
        goodsService.add($scope.entity).success(
            function (response) {
                if (response.success) {
                    //重新查询
                    alert("新增成功");
                    $scope.entity = {};
                    editor.html("");
                } else {
                    alert(response.message);
                }
            }
        );
    };

    $scope.save = function () {
        $scope.entity.goodsDesc.introduction = editor.html();

        var serviceObject;
        if($scope.entity.goods.id!=null) {
            serviceObject=goodsService.update($scope.entity);
        } else {
            serviceObject=goodsService.add($scope.entity);
        }
        serviceObject.success(
            function (response) {
                if (response.success) {
                    //重新查询
                    /*alert("保存成功");
                    $scope.entity = {};
                    editor.html("");*/
                    location.href="goods.html";
                } else {
                    alert(response.message);
                }
            }
        );
    };




    //批量删除
    $scope.dele = function () {
        //获取选中的复选框
        goodsService.dele($scope.selectIds).success(
            function (response) {
                if (response.success) {
                    $scope.reloadList();//刷新列表
                    $scope.selectIds = [];
                }
            }
        );
    }

    $scope.searchEntity = {};//定义搜索对象

    //搜索
    $scope.search = function (page, rows) {
        goodsService.search(page, rows, $scope.searchEntity).success(
            function (response) {
                $scope.list = response.rows;
                $scope.paginationConf.totalItems = response.total;//更新总记录数
            }
        );
    }

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

    $scope.entity = {goods: {}, goodsDesc: {itemImages: [], specificationItems: []}};
    // 将当前上传的图片实体存入图片列表
    $scope.add_image_entity = function () {
        $scope.entity.goodsDesc.itemImages.push($scope.image_entity);
    }


    $scope.remove_image_entity = function (index) {
        $scope.entity.goodsDesc.itemImages.splice(index, 1);
    }

    $scope.selectItemCat1List = function () {
        itemCatService.findByParentId(0).success(
            function (response) {
                $scope.itemCat1List = response;
            }
        )
    };

    $scope.$watch('entity.goods.category1Id', function (newValue, oldValue) {
        itemCatService.findByParentId(newValue).success(
            function (response) {
                $scope.itemCat2List = response;
            }
        )
    });

    $scope.$watch('entity.goods.category2Id', function (newValue, oldValue) {
        itemCatService.findByParentId(newValue).success(
            function (response) {
                $scope.itemCat3List = response;
            }
        )
    });

    $scope.$watch('entity.goods.category3Id', function (newValue, oldValue) {
        itemCatService.findOne(newValue).success(
            function (response) {
                $scope.entity.goods.typeTemplateId = response.typeId;
            }
        )
    });

    // 读取模板ID
    $scope.$watch('entity.goods.typeTemplateId', function (newValue, oldValue) {
        typeTemplateService.findOne(newValue).success(
            function (response) {
                $scope.typeTemplate = response;
                $scope.typeTemplate.brandIds = JSON.parse($scope.typeTemplate.brandIds);

                if ($location.search()['id'] == null) {
                    $scope.entity.goodsDesc.customAttributeItems = JSON.parse($scope.typeTemplate.customAttributeItems);

                }
            }
        );

        typeTemplateService.findSpecList(newValue).success(
            function (response) {
                $scope.specList = response;
            }
        )
    });


    $scope.updateSpecAttribute = function ($event, name, value) {

        // 1.判断是否规格选项是否有值
        // 2.有值--
        // 2.1 判断是否取消
        // 2.2 判断选项是否全不选
        // 3.无值

        var object = $scope.searchObjectById(
            $scope.entity.goodsDesc.specificationItems, "attributeName", name);
        if (object != null) {

            if ($event.target.checked) {
                object.attributeValue.push(value);
            } else {
                object.attributeValue.splice(object.attributeValue.indexOf(value), 1);

                if (object.attributeValue.length == 0) {
                    $scope.entity.goodsDesc.specificationItems.splice($scope.entity.goodsDesc.specificationItems.indexOf(object), 1);
                }
            }
        } else {
            $scope.entity.goodsDesc.specificationItems.push({"attributeName": name, "attributeValue": [value]});
        }
    };


    // 创建SKU列表
    $scope.cteateItemList = function () {

        $scope.entity.itemList = [{spec: {}, price: 0, num: 9999, status: '0', isDefault: '0'}];

        var items = $scope.entity.goodsDesc.specificationItems;

        for (var i = 0; i < items.length; i++) {
            $scope.entity.itemList = addColumn($scope.entity.itemList, items[i].attributeName, items[i].attributeValue);
        }
    };

    addColumn = function (list, columnName, columnValues) {
        var newList = [];
        for (var i = 0; i < list.length; i++) {

            var oldRow = list[i];

            for (var j = 0; j < columnValues.length; j++) {
                var newRow = JSON.parse(JSON.stringify(oldRow));
                newRow.spec[columnName] = columnValues[j];
                newList.push(newRow);
            }
        }

        return newList;
    };


    $scope.status = ['未审核', '已审核', '审核未通过', '关闭'];


    $scope.itemCatList = [];
    $scope.findItemCatList = function () {
        itemCatService.findAll().success(
            function (response) {
                for (var i = 0; i < response.length; i++) {
                    $scope.itemCatList[response[i].id] = response[i].name;

                }
            }
        );
    };

    $scope.findOne = function () {
        // 获取参数值
        var id = $location.search()['id'];
        if (id == null) {
            return;
        }
        goodsService.findOne(id).success(
            function (response) {
                $scope.entity = response;
                editor.html($scope.entity.goodsDesc.introduction);


                $scope.entity.goodsDesc.itemImages = JSON.parse($scope.entity.goodsDesc.itemImages);
                // 扩展属性
                $scope.entity.goodsDesc.customAttributeItems = JSON.parse($scope.entity.goodsDesc.customAttributeItems);

                // 规格
                $scope.entity.goodsDesc.specificationItems = JSON.parse($scope.entity.goodsDesc.specificationItems);

                // SKU列表

                for(var i = 0;i<$scope.entity.itemList.length;i++) {
                    $scope.entity.itemList[i].spec=JSON.parse($scope.entity.itemList[i].spec);
                }

            }
        )
    };

    $scope.checkAttributeValue = function (specName, optionName) {
        var items = $scope.entity.goodsDesc.specificationItems;
        var object = $scope.searchObjectById(items, "attributeName", specName);

        alert(object.attributeValue.indexOf(optionName) >= 0);
        if (object == null) {
            return false;
        } else {
            return (object.attributeValue.indexOf(optionName) >= 0)?true:false;
        }

    }


});	
