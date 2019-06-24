<template>
  <div>
    <el-container>
      <el-header
        style="padding: 0px;display:flex;justify-content:space-between;align-items: center"
      ></el-header>
      <div style="width:60%">
        <el-form :model="top" status-icon ref="ruleForm" label-width="100px" class="demo-ruleForm">
          <el-form-item label="头条标题" prop="pass">
            <el-input v-model="top.name"></el-input>
          </el-form-item>
          <el-form-item label="头条图片地址" prop="pass">
            <el-input v-model="top.picurl"></el-input>
          </el-form-item>

          <el-form-item
            style="display: flex;align-items: center;margin-top: 15px;justify-content: flex-start"
          >
            <el-button type="primary" @click="updateTop('ruleForm')">确认修改</el-button>
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
    updateTop() {
      var _this = this;
      this.putRequest("/top/", {
        name: this.top.name,
        picurl: this.top.picurl
      }).then(resp => {
        if (resp && resp.status == 200) {
        }
      });
    },

    handleSelectionChange(val) {
      this.multipleSelection = val;
    },

    loadTableData() {
      var _this = this;
      this.loading = true;
      this.getRequest("/top/").then(resp => {
        if (resp && resp.status == 200) {
          _this.top = resp.data;
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
      catData: [],
      top: {}
    };
  },
  props: ["state"]
};
</script>
