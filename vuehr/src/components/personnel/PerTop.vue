<template>
  <div>
      <el-container>
    <el-header style="padding: 0px;display:flex;justify-content:space-between;align-items: center"></el-header>
    <div style="width:60%">
      <el-form :model="catData" status-icon ref="ruleForm" label-width="100px" class="demo-ruleForm">
        
        <el-form-item label="头条图片地址" prop="pass">
          <el-input v-model="catData.name"></el-input>
        </el-form-item>

        <el-form-item style="display: flex;align-items: center;margin-top: 15px;justify-content: flex-start">
          <el-button type="primary" @click="updatePassword('ruleForm')">确认修改</el-button>
        </el-form-item>
      </el-form>
    </div>
  </el-container>
  </div>
</template>
<script>
export default {
  mounted: function() {
    this.loadTableData();
  },
  methods: {
    updatePosNameExec() {
      if (!this.isNotNullORBlank(this.cateName)) {
        this.$message.warning("名称不能为空!");
        return;
      }
      this.loading = true;
      var _this = this;
      this.putRequest("/admin/category/", {
        cateName: this.cateName,
        id: this.cateId
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
      if (!this.isNotNullORBlank(this.cateName)) {
        this.$message.warning("名称不能为空!");
        return;
      }

      var _this = this;
      this.loading = true;
      this.postRequest("/admin/category/", {
        cateName: this.cateName
      }).then(resp => {
        _this.loading = false;
        if (resp && resp.status == 200) {
          var data = resp.data;

          _this.loadTableData();
          _this.cateName = "";
        }
      });
    },
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    handleEdit(index, row) {
      this.cateName = row.cateName;
      this.cateId = row.id;
      this.dialogVisible = true;
    },
    handleDelete(index, row) {
      var _this = this;
      this.$confirm("删除[" + row.cateName + "], 是否继续?", "提示", {
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
      var url = "/admin/category/";
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
      this.getRequest("/admin/category/all").then(resp => {
        _this.loading = false;
        if (resp && resp.status == 200) {
          _this.catData = resp.data;
        }
      });
    }
  },
  data() {
    return {
      cateId: -1,
      cateName: "",
      date: "",
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
