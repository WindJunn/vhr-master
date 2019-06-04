<template>
  <div>
    <el-container>
      <el-header
        style="height:20px"
      ></el-header>

      <el-main style="padding-left: 0px;padding-top: 0px">
        <el-form
          :model="hr"
          :rules="rules"
          ref="ruleForm"
          label-width="100px"
          class="demo-ruleForm"
        >
          <el-row>
            <el-col style="width:30%">
              <div>
                <el-form-item label="姓名:" prop="name">
                  <el-input
                    prefix-icon="el-icon-edit"
                    v-model="hr.name"
                    size="mini"
                    style="width: 150px"
                    placeholder="请输入管理员姓名"
                  ></el-input>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row>
            <el-col style="width:30%">
              <div>
                <el-form-item label="性别:" prop="gender">
                  <el-radio-group v-model="hr.gender">
                    <el-radio label="男">男</el-radio>
                    <el-radio style="margin-left: 15px" label="女">女</el-radio>
                  </el-radio-group>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row>
            <el-col style="width:30%">
              <div>
                <el-form-item label="出生日期:" prop="birthday">
                  <el-date-picker
                    v-model="hr.birthday"
                    size="mini"
                    value-format="yyyy-MM-dd HH:mm:ss"
                    style="width: 150px"
                    type="date"
                    placeholder="出生日期"
                  ></el-date-picker>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row>
            <el-col style="width:30%">
              <div>
                <el-form-item label="民族:" prop="nationId">
                  <el-select
                    v-model="hr.nationId"
                    style="width: 150px"
                    size="mini"
                    placeholder="请选择民族"
                  >
                    <el-option
                      v-for="item in nations"
                      :key="item.id"
                      :label="item.name"
                      :value="item.id"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row>
            <el-col style="width:30%">
              <div>
                <el-form-item label="联系地址:" prop="address">
                  <el-input
                    prefix-icon="el-icon-edit"
                    v-model="hr.address"
                    size="mini"
                    style="width: 200px"
                    placeholder="联系地址..."
                  ></el-input>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row>
            <el-col style="width:30%">
              <div>
                <el-form-item label="所属部门:" prop="departmentId">
                  <el-popover
                    v-model="showOrHidePop"
                    placement="right"
                    title="请选择部门"
                    trigger="manual"
                    disabled
                  >
                    <el-tree
                      :data="deps"
                      :default-expand-all="true"
                      :props="defaultProps"
                      :expand-on-click-node="false"
                      @node-click="handleNodeClick"
                    ></el-tree>
                    <div
                      slot="reference"
                      style="width: 150px;height: 26px;display: inline-flex;font-size:13px;border: 1px;border-radius: 5px;border-style: solid;padding-left: 13px;box-sizing:border-box;border-color: #dcdfe6;cursor: pointer;align-items: center"
                      @click.left="showDepTree"
                      v-bind:style="{color: depTextColor}"
                    >{{hr.department.name}}</div>
                  </el-popover>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row>
            <el-col style="width:30%">
              <div>
                <el-form-item label="电话号码:" prop="phone">
                  <el-input
                    prefix-icon="el-icon-phone"
                    v-model="hr.phone"
                    size="mini"
                    style="width: 200px"
                    placeholder="电话号码..."
                  ></el-input>
                </el-form-item>
              </div>
            </el-col>
          </el-row>

          <el-row>
            <el-col style="width:30%">
              <div>
                <el-form-item label="身份证号码:" prop="idCard">
                  <el-input
                    prefix-icon="el-icon-edit"
                    v-model="hr.idCard"
                    size="mini"
                    style="width: 180px"
                    placeholder="请输入员工身份证号码..."
                  ></el-input>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row>
            <el-col style="width:30%">
              <div>
                <el-form-item label="邮箱:" prop="email">
                  <el-input
                    prefix-icon="el-icon-edit"
                    v-model="hr.email"
                    size="mini"
                    style="width: 180px"
                    placeholder="请输入邮箱..."
                  ></el-input>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <!-- <span  >
            <el-button size="mini" @click="cancelEidt">取 消</el-button>
            <el-button size="mini" type="primary" @click="addEmp('ruleForm')">确 定</el-button>
          </span>-->
          <el-form-item style="width:30%">
            <el-button type="primary" @click="updatePer('ruleForm')">确认修改</el-button>
          </el-form-item>
        </el-form>
      </el-main>
    </el-container>
  </div>
</template>
<script>
export default {
  computed: {
    users() {
      return this.$store.state.user;
    }
  },
  data() {
    return {
      emps: [],
      hrs: [],
      keywords: "",
      faangledoubleup: "fa-angle-double-up",
      faangledoubledown: "fa-angle-double-down",
      dialogTitle: "",
      multipleSelection: [],
      depTextColor: "#c0c4cc",
      nations: [],
      politics: [],
      positions: [],
      joblevels: [],
      totalCount: -1,
      currentPage: 1,

      deps: [],
      roles: [],
      defaultProps: {
        label: "name",
        isLeaf: "leaf",
        children: "children"
      },
      tableLoading: false,
      advanceSearchViewVisible: false,
      showOrHidePop: false,
      showOrHidePop2: false,
      hr: {
        id: "",
        name: "",
        phone: "",
        gender: "",
        address: "",
        departmentId: "",
        enabled: "",
        username: "",
        password: "",
        userface: "",
        idCard: "",
        remark: "",
        birthday: "",
        nationId: "",
        email: "",
        departmentName: "所属部门..."
      },
      user: {
        id: "",
        name: "",
        phone: "",
        gender: "",
        address: "",
        departmentId: "",
        enabled: "",
        username: "",
        password: "",
        userface: "",
        idCard: "",
        remark: "",
        birthday: "",
        nationId: "",
        email: ""
      },
      rules: {
        name: [{ required: true, message: "必填:姓名", trigger: "blur" }],
        gender: [{ required: true, message: "必填:性别", trigger: "blur" }],
        birthday: [
          { required: true, message: "必填:出生日期", trigger: "blur" }
        ],
        idCard: [
          {
            required: true,
            message: "必填:身份证号码",
            trigger: "blur"
          },
          {
            pattern: /(^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$)|(^[1-9]\d{5}\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{2}$)/,
            message: "身份证号码格式不正确",
            trigger: "blur"
          }
        ],

        phone: [{ required: true, message: "必填:电话号码", trigger: "blur" }],
        address: [{ required: true, message: "必填:联系地址", trigger: "blur" }]
      }
    };
  },
  mounted: function() {
    this.initData();
    this.loadEmps();
  },
  methods: {
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },

    keywordsChange(val) {
      if (val == "") {
        this.loadEmps();
      }
    },

    currentChange(currentChange) {
      this.currentPage = currentChange;
      this.loadEmps();
    },
    loadEmps() {
      var _this = this;
      this.getRequest("/system/hr/name/" + this.users.username).then(resp => {
        this.tableLoading = false;
        if (resp && resp.status == 200) {
          var user = resp.data;
          _this.hr = user;
          _this.roles = data.roles;
          _this.nation = data.nation;
          //            _this.emptyEmpData();
          console.log(data);
        }
      });
    },
    showDepTree() {
      this.showOrHidePop = !this.showOrHidePop;
    },
    showDepTree2() {
      this.showOrHidePop2 = !this.showOrHidePop2;
    },

    initData() {
      var _this = this;
      this.getRequest("/system/hr/basicdata").then(resp => {
        if (resp && resp.status == 200) {
          var data = resp.data;
          _this.nations = data.nations;
          _this.politics = data.politics;
          _this.deps = data.deps;
          _this.positions = data.positions;
          _this.roles = data.roles;
        }
      });
    },
    updatePer() {
      this.user.id = this.users.id;
      this.user.name = this.hr.name;
      this.user.gender = this.hr.gender;
      this.user.phone = this.hr.phone;
      this.user.address = this.hr.address;
      // this.user.departmentId = this.hr.departmentId;
      //       this.user.username=null;
      // this.user.password=null;
      this.user.enabled = true;
      this.user.idCard = this.hr.idCard;
      this.user.email = this.hr.email;
      this.user.birthday = this.hr.birthday;
      this.user.nationId = this.hr.nationId;

      this.putRequest("/system/hr/", this.user).then(resp => {
        if (resp && resp.status == 200) {
          var data = resp.data;
          _this.loadEmps();
        }
      });
    },
    showEditEmpView(row) {
      console.log(row);
      this.dialogTitle = "编辑管理员";
      this.hr = row;
      this.hr.birthday = this.formatDate(row.birthday);

      this.hr.nationId = row.nation.id;
      this.hr.departmentId = row.department.id;
      this.hr.departmentName = row.department.name;
      this.dialogVisible = true;

      this.user.id = row.id;
      this.user.name = this.hr.name;
      this.user.gender = this.hr.gender;
      this.user.phone = this.hr.phone;
      this.user.address = this.hr.address;
      this.user.departmentId = this.hr.departmentId;
      this.user.departmentName = this.hr.departmentName;
      this.user.enabled = this.hr.enabled;
      this.user.idCard = this.hr.idCard;
      this.user.email = this.hr.email;
      this.user.birthday = this.hr.birthday;
      this.user.nationId = this.hr.nationId;
    },

    emptyEmpData() {
      this.hr = {
        id: "",
        name: "",
        phone: "",
        gender: "",
        address: "",
        departmentId: "",
        enabled: true,
        username: phone,
        password: 123,
        userface: "",
        idCard: "",
        remark: "",
        birthday: "",
        nationId: "",
        email: "",
        departmentName: "所属部门..."
      };
      this.user = {
        // id: "",
        name: "",
        phone: "",
        gender: "",
        address: "",
        departmentId: "",
        // enabled: true,
        username: "",
        password: "",
        userface: "",
        idCard: "",
        remark: "",
        birthday: "",
        nationId: "",
        email: "",
        departmentName: "所属部门..."
      };
    }
  }
};
</script>

