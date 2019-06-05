<template>
  <div>
    <span></span>
    <hr>
    <div style="text-align: left">
      <el-input
        :placeholder="'输入积分项目...'"
        size="mini"
        style="width: 15%;"
        v-model="name"
      ></el-input>
      <el-input
        :placeholder="'输入积分项目分数...'"
        size="mini"
        style="width: 12%;"
        v-model="point"
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
        <el-table-column prop="name" :label="'积分项目'" width="180" align="left"></el-table-column>
        <el-table-column prop="point" :label="'积分分数'" width="180" align="left"></el-table-column>

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
      <el-dialog :title="'编辑名称'" :visible.sync="dialogVisible" width="25%">
        <el-input v-model="name" size="" placeholder="请输入新的名称..."></el-input>
        <hr style="width:20%">
        <el-input v-model="point" size="" placeholder="请输入新的分数..."></el-input>

        <span slot="footer" class="dialog-footer">
          <el-button size="mini"   @click="cancelEidt">取 消</el-button>
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
        this.$message.warning("名称不能为空!");
        return;
      }
      this.loading = true;
      var _this = this;
      this.putRequest("/pointoption/", {
        id: this.id,
        name: this.name,
        point: this.point,
        
      }).then(resp => {
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
        this.$message.warning("名称不能为空!");
        return;
      }

      var _this = this;
      this.loading = true;
      this.postRequest("/pointoption/", {
        name: this.name,
        point:this.point
      }).then(resp => {
        _this.loading = false;
        if (resp && resp.status == 200) {
          var data = resp.data;

          _this.loadTableData();
          _this.name = "";
          _this.point = "";
        }
      });
    },
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    cancelEidt() {
      this.dialogVisible = false;
      this.emptyEmpData();
    },
    handleEdit(index, row) {
      this.name = row.name;
      this.id = row.id;
      this.point = row.point;
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
      var url = "/pointoption/";
      this.deleteRequest(url + ids).then(resp => {
        _this.loading = false;
        if (resp && resp.status == 200) {
          _this.loadTableData();
        }
      });
    },
    emptyEmpData(){
      this.point="";
      this.name="";
    },
    loadTableData() {
      var _this = this;
      this.loading = true;
      this.getRequest("/pointoption/all").then(resp => {
        _this.loading = false;
        if (resp && resp.status == 200) {
          _this.catData = resp.data;
        }
      });
    }
  },
  data() {
    return {
      id: "",
      name: "",
      point:"",
      updatePosId: -1,
      loading: false,
      dialogVisible: false,
      multipleSelection: [],
      type: [],
      nameLabelName: "分类名称",
      catData: [],
      pointoption:[]
    };
  },
  props: ["state"]
};
</script>
