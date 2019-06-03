<template>
  <div>
    <div style="text-align: left">
      <el-input
        :placeholder="'添加考勤状态...'"
        size="mini"
        @keyup.enter.native="addPosition"
        style="width: 300px;"
        prefix-icon="el-icon-plus"
        v-model="name"
      ></el-input>
      
      <el-button type="primary" icon="el-icon-plus" size="mini" @click="addPosition">添加</el-button>
    </div>
    <div style="margin-top: 10px">
      <el-table
        v-loading="loading"
        :data="catData"
        size="mini"
        stripe
        border
        @selection-change="handleSelectionChange"
        style="width: 80%"
      >
        <el-table-column type="selection" width="55" align="left"></el-table-column>
        <el-table-column prop="id" label="编号" width="80" align="left"></el-table-column>
        <el-table-column
          prop="name"
          :label="'考勤状态'"
          width="180"
          align="left"
        ></el-table-column>
  
        <!-- <el-table-column width="180" label="创建时间" align="left">
          <template slot-scope="scope">{{ scope.row.date | formatDate}}</template>
        </el-table-column> -->
        <el-table-column label="操作" align="left">
          <template slot-scope="scope">
            <el-button size="mini" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
            <el-button size="mini" type="danger" @click="handleDelete(scope.$index, scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
    <div style="text-align: left;margin-top: 10px">
      <el-button
        type="danger"
        size="mini"
        v-if="catData.length>0"
        :disabled="multipleSelection.length==0"
        @click="deleteMany"
      >批量删除</el-button>
    </div>
    <div style="text-align: left">
      <el-dialog
        :title="'编辑名称'"
        :visible.sync="dialogVisible"
        width="25%"
      >
        <el-input v-model="name" size="mini" placeholder="请输入新的名称..."></el-input>
       
        <span slot="footer" class="dialog-footer">
          <el-button size="mini" @click="dialogVisible = false">取 消</el-button>
          <el-button type="primary" size="mini" @click="updatePosNameExec">确 定</el-button>
        </span>
      </el-dialog>
    </div>
  </div>
</template>
<script>
export default {
  mounted: function() {
    this.loadTableData();
  },
  methods: {
    updatePosNameExec() {
      if (!this.isNotNullORBlank(this.name)) {
        this.$message.warning(
          "名称不能为空!"
        );
        return;
      }
      this.loading = true;
      var _this = this;
      this.putRequest( "/attname/",
        {
          name: this.name,
          id: this.id,
        }
      ).then(resp => {
        _this.loading = false;
        if (resp && resp.status == 200) {
          this.dialogVisible = false;
          var data = resp.data;
          _this.loadTableData();
        }
      });
    },
    deleteMany() {
      var _this = this;
      this.$confirm(
        "删除" + this.multipleSelection.length + "条数据, 是否继续?",
        "提示",
        {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }
      )
        .then(() => {
          var multipleSelection = _this.multipleSelection;
          var ids = "";
          multipleSelection.forEach(row => {
            ids = ids + row.id + ",";
          });
          _this.doDelete(ids);
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消删除"
          });
        });
    },
    addPosition() {
      if (!this.isNotNullORBlank(this.name)) {
        this.$message.warning(
          "名称不能为空!"
        );
        return;
      }
      
      var _this = this;
      this.loading = true;
      this.postRequest("/attname/",
        {
          name: this.name,
        }
      ).then(resp => {
        _this.loading = false;
        if (resp && resp.status == 200) {
          var data = resp.data;

          _this.loadTableData();
          _this.name = "";
        }
      });
    },
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    handleEdit(index, row) {
      this.name = row.name;
      this.id = row.id;
      this.dialogVisible = true;
    },
    handleDelete(index, row) {
      var _this = this;
      this.$confirm("删除[" + row.name + "], 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(() => {
          _this.doDelete(row.id);
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消删除"
          });
        });
    },
    doDelete(ids) {
      var _this = this;
      _this.loading = true;
      var url ="/attname/";
      this.deleteRequest(url + ids).then(resp => {
        _this.loading = false;
        if (resp && resp.status == 200) {
          _this.loadTableData();
        }
      });
    },
    loadTableData() {
      var _this = this;
      this.loading = true;
      this.getRequest("/attname/all").then(resp => {
        _this.loading = false;
        if (resp && resp.status == 200) {
          _this.catData = resp.data;
        }
      });
    }
  },
  data() {
    return {
      id:"",
      name:"",
      cateId: -1,
      cateName: "",
      date:"",
      updatePosId: -1,
      loading: false,
      dialogVisible: false,
      multipleSelection: [],
      type: [],
      nameLabelName: "分类名称",
      catData: []
    };
  },
  props: ["state"]
};
</script>
