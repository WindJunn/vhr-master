<style type="text/css">
.blog_table_footer {
  display: flex;
  box-sizing: content-box;
  padding-top: 10px;
  padding-bottom: 0px;
  margin-bottom: 0px;
  justify-content: space-between;
}
</style>
<template>
  <div>
    <hr>
    <div style="display: flex;justify-content: flex-start">
      <el-input
        placeholder="通过标题搜索该分类下的博客..."
        prefix-icon="el-icon-search"
        v-model="keywords"
        style="width: 400px"
        size="mini"
      ></el-input>
      <el-button
        type="primary"
        icon="el-icon-search"
        size="mini"
        style="margin-left: 3px"
        @click="searchClick"
      >搜索</el-button>
    </div>
    <!--<div style="width: 100%;height: 1px;background-color: #20a0ff;margin-top: 8px;margin-bottom: 0px"></div>-->
    <el-table
      ref="multipleTable"
      :data="articles"
      tooltip-effect="dark"
      border
      stripe
      size="mini"
      style="width: 100%"
      @selection-change="handleSelectionChange"
      v-loading="loading"
    >
      <el-table-column type="selection" width="35" align="left"></el-table-column>
      <el-table-column fixed label="标题" width="300" align="left">
        <template slot-scope="scope">
          <span
            style="color: #409eff;cursor: pointer"
            @click="itemClick(scope.row)"
          >{{ scope.row.title}}</span>
          <!-- <router-link to="/detail" style="color: #409eff;cursor: pointer">{{ scope.row.title}}</router-link> -->
        </template>
      </el-table-column>
      <el-table-column label="最近编辑时间" width="140" align="left">
        <template slot-scope="scope">{{ scope.row.editTime | formatDateTime}}</template>
      </el-table-column>
      <el-table-column prop="author" label="作者" width="120" align="left"></el-table-column>
      <el-table-column prop="cateName" label="所属分类" width="100" align="left"></el-table-column>
      <el-table-column prop="pageView" label="点击量" width="100" align="left"></el-table-column>
      <el-table-column fixed="right" label="操作" width="400">
        <template slot-scope="scope">
          <el-button size="mini" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
          <el-button size="mini" type="primary" @click="updateTop(scope.row)">置顶</el-button>
          <el-button size="mini" type="danger" @click="handleDelete(scope.$index, scope.row)">删除</el-button>

          <el-button size="mini" type="danger" @click="shield(scope.row)" v-show="scope.row.enable==1">屏蔽</el-button>
          <el-button size="mini" type="danger" @click="reshield(scope.row)" v-show="scope.row.enable==0">取消屏蔽</el-button>
        </template>
      </el-table-column>
    </el-table>
    <div class="blog_table_footer">
      <el-button
        type="danger"
        size="mini"
        style="margin: 0px;"
        v-show="this.articles.length>0 && showDelete"
        :disabled="this.selItems.length==0"
        @click="deleteMany"
      >批量删除</el-button>
      <span></span>
     
      <el-pagination
        background
        @size-change="handleSizeChange"
        @current-change="currentChange"
        :current-page="currentPage"
        :page-sizes="[10, 15, 20, 30, 50]"
        :page-size="pageSize"
        layout="total, sizes, prev, pager, next, jumper"
        :total="totalCount"
        v-show="this.articles.length>0"
      ></el-pagination>
    </div>
  </div>
</template>

<script>
import { putRequest } from "../../utils/api";
import { getRequest } from "../../utils/api";
//  import Vue from 'vue'
//  var bus = new Vue()

export default {
  data() {
    return {
      articles: [],
      selItems: [],
      loading: false,
      currentPage: 1,
      totalCount: -1,
      pageSize: 10,
      keywords: "",
      dustbinData: [],
      activeName: "post"
    };
  },
  mounted: function() {
    var _this = this;
    this.loading = true;
    this.loadBlogs(1, this.pageSize);
    var _this = this;
    window.bus.$on("blogTableReload", function() {
      _this.loading = true;
      _this.loadBlogs(_this.currentPage, _this.pageSize);
    });
  },
  methods: {
    searchClick() {
      this.loadBlogs(1, this.pageSize);
    },
    itemClick(row) {
      this.$router.push({ path: "/blogDetail", query: { aid: row.id } });
    },
    deleteMany() {
      var selItems = this.selItems;
      for (var i = 0; i < selItems.length; i++) {
        this.dustbinData.push(selItems[i].id);
      }
      this.deleteToDustBin(selItems[0].state);
    },
    //翻页
    currentChange(currentPage) {
      this.currentPage = currentPage;
      this.loading = true;
      this.loadBlogs(currentPage, this.pageSize);
    },
    loadBlogs(page, count) {
      var _this = this;
      var url = "";
      url =
        "/article/all/admin?page=" +
        page +
        "&count=" +
        count +
        "&cid=" +
        '' +
        "&keywords=" +
        this.keywords;

      getRequest(url)
        .then(
          resp => {
            _this.loading = false;
            if (resp.status == 200) {
              _this.articles = resp.data.articles;
              _this.totalCount = resp.data.totalCount;
            } else {
              _this.$message({ type: "error", message: "数据加载失败!" });
            }
          },
          resp => {
            _this.loading = false;
            if (resp.response.status == 403) {
              _this.$message({ type: "error", message: resp.response.data });
            } else {
              _this.$message({ type: "error", message: "数据加载失败!" });
            }
          }
        )
        .catch(resp => {
          //压根没见到服务器
          _this.loading = false;
          _this.$message({ type: "error", message: "数据加载失败!" });
        });
    },
    handleSelectionChange(val) {
      this.selItems = val;
    },
    handleSizeChange(pageSize) {
      this.pageSize = pageSize;
      this.loadBlogs(this.currentPage, this.pageSize);
    },
    handleEdit(index, row) {
      this.$router.push({
        path: "/per/train",
        query: { from: this.activeName, id: row.id }
      });
    },

    updateTop(row) {
      var _this = this;
      this.putRequest("/top/aid", {
        aid: row.id
      }).then(resp => {
        if (resp && resp.status == 200) {
        }
      });
    },
    shield(row) {
      var _this = this;
      this.putRequest("/article/shield", {
        enable:0,
        aid: row.id
      }).then(resp => {
        if (resp && resp.status == 200) {
          this.loadBlogs(this.currentPage, this.pageSize);
        }
      });
    },
    reshield(row) {
      var _this = this;
      this.putRequest("/article/shield", {
        enable:1,
        aid: row.id
      }).then(resp => {
        if (resp && resp.status == 200) {
          this.loadBlogs(this.currentPage, this.pageSize);
        }
      });
    },
    handleDelete(index, row) {
      this.dustbinData.push(row.id);
      this.deleteToDustBin(row.state);
    },
    deleteToDustBin(state) {
      var _this = this;
      this.$confirm(
        state != 2
          ? "将该文件放入回收站，是否继续?"
          : "永久删除该文件, 是否继续?",
        "提示",
        {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }
      )
        .then(() => {
          _this.loading = true;
          var url = "";
          if (_this.state == -2) {
            url = "/admin/article/dustbin";
          } else {
            url = "/article/dustbin";
          }
          putRequest(url, { aids: _this.dustbinData, state: state }).then(
            resp => {
              if (resp.status == 200) {
                var data = resp.data;
                _this.$message({ type: data.status, message: data.msg });
                if (data.status == "success") {
                  window.bus.$emit("blogTableReload"); //通过选项卡都重新加载数据
                }
              } else {
                _this.$message({ type: "error", message: "删除失败!" });
              }
              _this.loading = false;
              _this.dustbinData = [];
            },
            resp => {
              _this.loading = false;
              _this.$message({ type: "error", message: "删除失败!" });
              _this.dustbinData = [];
            }
          );
        })
        .catch(() => {
          _this.$message({
            type: "info",
            message: "已取消删除"
          });
          _this.dustbinData = [];
        });
    }
  },
  props: ["state", "showEdit", "showDelete", "post"]
};
</script>
