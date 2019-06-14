<template>
  <div>
    <span></span>
    <hr/>
    <!-- <div style="text-align: left">
      <el-input
        :placeholder="'添加考勤状态...'"
        size="mini"
        @keyup.enter.native="addPosition"
        style="width: 300px;"
        prefix-icon="el-icon-plus"
        v-model="name"
      ></el-input>
      
      <el-button type="primary" icon="el-icon-plus" size="mini" @click="addPosition">添加</el-button>
    </div> -->
    <div style="margin-top: 10px">
      <el-table
        v-loading="loading"
        :data="menu"
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
          :label="'菜单名称'"
          width="180"
          align="left"
        ></el-table-column>
  
        <el-table-column label="操作" align="left">
          <template slot-scope="scope">
            <el-button type="primary" size="mini" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
          </template>
        </el-table-column>
      </el-table>
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
      this.putRequest( "/system/basic/menu",
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
   
   
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    handleEdit(index, row) {
      this.name = row.name;
      this.id = row.id;
      this.dialogVisible = true;
    },
   

    loadTableData() {
      var _this = this;
      this.loading = true;
      this.getRequest("/system/basic/menu").then(resp => {
        _this.loading = false;
        if (resp && resp.status == 200) {
          _this.menu = resp.data.menus;
        }
      });
    }
  },
  data() {
    return {
      id:"",
      name:"",
      date:"",
      updatePosId: -1,
      loading: false,
      dialogVisible: false,
      multipleSelection: [],
      type: [],
      nameLabelName: "分类名称",
      menu: []
    };
  },
  props: ["state"]
};
</script>
