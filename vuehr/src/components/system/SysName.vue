<template>
  <el-container>
    <el-header style="padding: 0px;display:flex;justify-content:space-between;align-items: center"></el-header>
    <div style="width:40%">
      <el-form :model="sys" status-icon ref="ruleForm" label-width="100px" class="demo-ruleForm">
        <!-- <el-form-item label="系统标题">
          <el-input v-model="sys.title"></el-input>
        </el-form-item>-->
        <el-form-item label="系统名称:" prop="pass">
          <el-input v-model="sys.leftname"></el-input>
        </el-form-item>
        <el-form-item label="版权所有:" prop="pass">
          <el-input v-model="sys.copyrighted"></el-input>
        </el-form-item>
        <el-form-item label="联系电话:" prop="pass">
          <el-input v-model="sys.phone"></el-input>
        </el-form-item>
        <el-form-item label="电子邮箱:" prop="pass">
          <el-input v-model="sys.email"></el-input>
        </el-form-item>
        <el-form-item label="网站标识码:" prop="pass">
          <el-input v-model="sys.identificationcode"></el-input>
        </el-form-item>

        <el-form-item>
          <el-button type="primary" @click="updatePassword('ruleForm')">确认修改</el-button>
          <!-- <el-button @click="resetForm('ruleForm')">重置</el-button> -->
        </el-form-item>
      </el-form>
    </div>
  </el-container>
</template>
<script>
export default {
  data() {
    return {
      ruleForm: {
        pass: "",
        checkPass: ""
      },
      sys: {
        title: "",
        leftname: "",
        rightname: "",
        path: "",
        image: "",
        des: "",
        copyrighted: "",
        phone: "",
        email: "",
        identificationcode: ""
      },
      id: "",
      name: "",
      point: "",
      updatePosId: -1,
      loading: false,
      dialogVisible: false,
      multipleSelection: [],
      type: []
    };
  },
  mounted: function() {
    this.loadTableData();
  },
  methods: {
    loadTableData() {
      var _this = this;
      this.loading = true;
      this.getRequest("/systems/name/").then(resp => {
        _this.loading = false;
        if (resp && resp.status == 200) {
          _this.sys = resp.data[0];
        }
      });
    },
    updatePassword() {
      var _this = this;
      // debugger;  {
      //   title: this.sys.title,
      //   leftname: this.sys.leftname
      // }
      this.putRequest("/systems/name/sys", this.sys).then(resp => {
        if (resp && resp.status == 200) {
        }
      });
    },
    resetForm(formName) {
      this.$refs[formName].resetFields();
    }
  }
};
</script>
