//服务层
app.service('articleService',function($http){
	    	
	//读取列表数据绑定到表单中
	this.findAll=function(){
			return $http.get('../art/all');
	};
	//分页 
	this.findPage=function(page,rows){
		return $http.get('../goods/findPage.do?page='+page+'&rows='+rows);
	};
	//分页
	this.findByCate=function(page,cid,keywords){
		return $http.get('art/all?page='+page+'&count=10&cid='+cid+'&keywords='+keywords);
	};

	//搜索
	this.search=function(page,count,cid,keywords){
		return $http.get('art/all?page='+page+'&count='+count+'&cid='+cid+'&keywords='+keywords);
	}

	this.findHomeArt=function(){
		return $http.get('art/home');
	};
	this.getArticleById=function(aid){
		return $http.get('art/'+aid);
	};

	this.submitClick=function (username, password) {
		return $http.post('/login?username='+username+'&password'+password);
	};
	//查询实体
	this.findOne=function(id){
		return $http.get('../goods/findOne.do?id='+id);
	}
	//增加 
	this.add=function(entity){
		return  $http.post('../goods/add.do',entity );
	}
	//修改 
	this.update=function(entity){
		return  $http.post('../goods/update.do',entity );
	}
	//删除
	this.dele=function(ids){
		return $http.get('../goods/delete.do?ids='+ids);
	}


	this.updateStatus=function (ids,status) {
		return $http.get('../goods/updateStatus.do?ids='+ids+'&status='+status);

    }
});
