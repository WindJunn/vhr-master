<template>
  <div>
    <el-container>
      <el-header
        style="padding: 0px;display:flex;justify-content:space-between;align-items: center"
      >
        <div style="display: inline">
          <el-input
            placeholder="通过学员名搜索学员,记得回车哦..."
            clearable
            @change="keywordsChange"
            style="width: 300px;margin: 0px;padding: 0px;"
            size="mini"
            :disabled="advanceSearchViewVisible"
            @keyup.enter.native="searchEmp"
            prefix-icon="el-icon-search"
            v-model="keywords"
          ></el-input>
          <el-button
            type="primary"
            size="mini"
            style="margin-left: 5px"
            icon="el-icon-search"
            @click="searchEmp"
          >搜索</el-button>
          <el-button
            slot="reference"
            type="primary"
            size="mini"
            style="margin-left: 5px"
            @click="showAdvanceSearchView"
          >
            <i
              class="fa fa-lg"
              v-bind:class="[advanceSearchViewVisible ? faangledoubleup:faangledoubledown]"
              style="margin-right: 5px"
            ></i>高级搜索
          </el-button>
        </div>
        <div style="margin-left: 5px;margin-right: 20px;display: inline">
          <el-upload
            :show-file-list="false"
            accept="application/vnd.ms-excel"
            action="/student/basic/importEmp"
            :on-success="fileUploadSuccess"
            :on-error="fileUploadError"
            :disabled="fileUploadBtnText=='正在导入'"
            :before-upload="beforeFileUpload"
            style="display: inline"
          >
            <el-button size="mini" type="success" :loading="fileUploadBtnText=='正在导入'">
              <i class="fa fa-lg fa-level-up" style="margin-right: 5px"></i>
              {{fileUploadBtnText}}
            </el-button>
          </el-upload>
          <el-button type="success" size="mini" @click="exportEmps">
            <i class="fa fa-lg fa-level-down" style="margin-right: 5px"></i>导出数据
          </el-button>
          <el-button type="primary" size="mini" icon="el-icon-plus" @click="showAddEmpView">添加学员</el-button>
        </div>
      </el-header>
      <el-main style="padding-left: 0px;padding-top: 0px">
        <div>
          <transition name="slide-fade">
            <div
              style="margin-bottom: 10px;border: 1px;border-radius: 5px;border-style: solid;padding: 5px 0px 5px 0px;box-sizing:border-box;border-color: #20a0ff"
              v-show="advanceSearchViewVisible"
            >
              <el-row>
                <el-col :span="4">
                  民族:
                  <el-select
                    v-model="emp.nationId"
                    style="width: 130px"
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
                </el-col>

                <el-col :span="5">
                  所属部门:
                  <el-popover
                    v-model="showOrHidePop2"
                    placement="right"
                    title="请选择部门"
                    trigger="manual"
                  >
                    <el-tree
                      :data="deps"
                      :default-expand-all="true"
                      :props="defaultProps"
                      :expand-on-click-node="false"
                      @node-click="handleNodeClick2"
                    ></el-tree>
                    <div
                      slot="reference"
                      style="width: 130px;height: 26px;display: inline-flex;font-size:13px;border: 1px;border-radius: 5px;border-style: solid;padding-left: 13px;box-sizing:border-box;border-color: #dcdfe6;cursor: pointer;align-items: center"
                      @click="showDepTree2"
                      v-bind:style="{color: depTextColor}"
                    >{{emp.departmentName}}</div>
                  </el-popover>
                </el-col>
              </el-row>
              <el-row style="margin-top: 10px">
                <el-col :span="5" :offset="4">
                  <el-button size="mini" @click="cancelSearch">取消</el-button>
                  <el-button icon="el-icon-search" type="primary" size="mini" @click="searchEmp">搜索</el-button>
                </el-col>
              </el-row>
            </div>
          </transition>
          <el-table
            :data="emps"
            v-loading="tableLoading"
            border
            stripe
            @selection-change="handleSelectionChange"
            size="mini"
            style="width: 100%"
          >
            <el-table-column type="selection" align="left" width="30"></el-table-column>
            <el-table-column prop="name" align="left" fixed label="姓名" width="90"></el-table-column>
            <el-table-column prop="workID" width="95" align="left" label="学号"></el-table-column>
            <el-table-column prop="gender" label="性别" width="50"></el-table-column>
            <el-table-column width="85" align="left" label="出生日期">
              <template slot-scope="scope">{{ scope.row.birthday | formatDate}}</template>
            </el-table-column>
            <el-table-column prop="idCard" width="150" align="left" label="身份证号码"></el-table-column>
            <el-table-column prop="wedlock" width="70" label="婚姻状况"></el-table-column>
            <el-table-column width="60" prop="nation.name" label="民族"></el-table-column>
            <el-table-column prop="nativePlace" width="80" label="籍贯"></el-table-column>

            <el-table-column prop="phone" width="100" label="电话号码"></el-table-column>
            <el-table-column prop="address" width="220" align="left" label="联系地址"></el-table-column>
            <el-table-column prop="department.name" align="left" width="100" label="所属部门"></el-table-column>
            <el-table-column prop="points" align="left" width="70" label="积分">
              <template slot-scope="scope">
                <el-popover trigger="hover" placement="top">
                  <p>积分记录：</p>
                  <p>积分: {{ scope.row.name }}</p>
                  <p>住址: {{ scope.row.address }}</p>
                  <div slot="reference" class="name-wrapper">
                    <el-tag size="medium">{{ scope.row.points }}</el-tag>
                  </div>
                </el-popover>
              </template>
            </el-table-column>
            <el-table-column fixed="right" label="操作" width="250">
              <template slot-scope="scope">
                <el-button
                  @click="showEditEmpView(scope.row)"
                  style="padding: 3px 4px 3px 4px;margin: 2px"
                  size="mini"
                >编辑</el-button>
                <el-button
                  style="padding: 3px 4px 3px 4px;margin: 2px"
                  type="primary"
                  size="mini"
                  @click="showEditPointView(scope.row)"
                >积分管理</el-button>
                <el-button
                  style="padding: 3px 4px 3px 4px;margin: 2px"
                  type="primary"
                  size="mini"
                  @click="showAttendanceView(scope.row)"
                >查看考勤</el-button>
                <el-button
                  type="danger"
                  style="padding: 3px 4px 3px 4px;margin: 2px"
                  size="mini"
                  @click="deleteEmp(scope.row)"
                >删除</el-button>
              </template>
            </el-table-column>
          </el-table>
          <div style="display: flex;justify-content: space-between;margin: 2px">
            <el-button
              type="danger"
              size="mini"
              v-if="emps.length>0"
              :disabled="multipleSelection.length==0"
              @click="deleteManyEmps"
            >批量删除</el-button>
            <el-pagination
              background
              :page-size="10"
              :current-page="currentPage"
              @current-change="currentChange"
              layout="prev, pager, next"
              :total="totalCount"
            ></el-pagination>
          </div>
        </div>
      </el-main>
    </el-container>
    <el-form :model="emp" :rules="rules" ref="addEmpForm" style="margin: 0px;padding: 0px;">
      <div style="text-align: left">
        <el-dialog
          :title="dialogTitle"
          style="padding: 0px;"
          :close-on-click-modal="false"
          :visible.sync="dialogVisible"
          width="77%"
        >
          <el-row>
            <el-col :span="6">
              <div>
                <el-form-item label="姓名:" prop="name">
                  <el-input
                    prefix-icon="el-icon-edit"
                    v-model="emp.name"
                    size="mini"
                    style="width: 150px"
                    placeholder="请输入学员姓名"
                  ></el-input>
                </el-form-item>
              </div>
            </el-col>
            <el-col :span="5">
              <div>
                <el-form-item label="性别:" prop="gender">
                  <el-radio-group v-model="emp.gender">
                    <el-radio label="男">男</el-radio>
                    <el-radio style="margin-left: 15px" label="女">女</el-radio>
                  </el-radio-group>
                </el-form-item>
              </div>
            </el-col>
            <el-col :span="6">
              <div>
                <el-form-item label="出生日期:" prop="birthday">
                  <el-date-picker
                    v-model="emp.birthday"
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
            <el-col :span="6">
              <div>
                <el-form-item label="民族:" prop="nationId">
                  <el-select
                    v-model="emp.nationId"
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
            <el-col :span="5">
              <div>
                <el-form-item label="籍贯:" prop="nativePlace">
                  <el-input
                    v-model="emp.nativePlace"
                    size="mini"
                    style="width: 120px"
                    placeholder="学员籍贯"
                  ></el-input>
                </el-form-item>
              </div>
            </el-col>

            <el-col :span="7">
              <div>
                <el-form-item label="联系地址:" prop="address">
                  <el-input
                    prefix-icon="el-icon-edit"
                    v-model="emp.address"
                    size="mini"
                    style="width: 200px"
                    placeholder="联系地址..."
                  ></el-input>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="6">
              <div>
                <el-form-item label="所属部门:" prop="departmentId">
                  <el-popover
                    v-model="showOrHidePop"
                    placement="right"
                    title="请选择部门"
                    trigger="manual"
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
                    >{{emp.departmentName}}</div>
                  </el-popover>
                </el-form-item>
              </div>
            </el-col>
            <el-col :span="7">
              <div>
                <el-form-item label="电话号码:" prop="phone">
                  <el-input
                    prefix-icon="el-icon-phone"
                    v-model="emp.phone"
                    size="mini"
                    style="width: 200px"
                    placeholder="电话号码..."
                  ></el-input>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="6">
              <div>
                <el-form-item label="学号:" prop="workID">
                  <el-input
                    v-model="emp.workID"
                    size="mini"
                    style="width: 150px"
                    placeholder="学员学号..."
                  ></el-input>
                </el-form-item>
              </div>
            </el-col>
            <el-col :span="7">
              <div>
                <el-form-item label="积分:" prop="points">
                  <el-input
                    v-model="emp.points"
                    size="mini"
                    style="width: 150px"
                    placeholder="积分..."
                  ></el-input>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="8">
              <div>
                <el-form-item label="身份证号码:" prop="idCard">
                  <el-input
                    prefix-icon="el-icon-edit"
                    v-model="emp.idCard"
                    size="mini"
                    style="width: 180px"
                    placeholder="请输入学员身份证号码..."
                  ></el-input>
                </el-form-item>
              </div>
            </el-col>

            <el-col :span="8">
              <div>
                <el-form-item label="婚姻状况:" prop="wedlock">
                  <el-radio-group v-model="emp.wedlock">
                    <el-radio label="已婚">已婚</el-radio>
                    <el-radio style="margin-left: 15px" label="未婚">未婚</el-radio>
                    <el-radio style="margin-left: 15px" label="离异">离异</el-radio>
                  </el-radio-group>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <span slot="footer" class="dialog-footer">
            <el-button size="mini" @click="cancelEidt">取 消</el-button>
            <el-button size="mini" type="primary" @click="addEmp('addEmpForm')">确 定</el-button>
          </span>
        </el-dialog>
      </div>
    </el-form>

    <el-form
      :model="ruleForm"
      :rules="rules1"
      ref="ruleForm"
      class="demo-ruleForm"
      label-width="100px"
    >
      <div style="text-align: left">
        <el-dialog
          :title="dialogTitle"
          style="padding: 0px;"
          :close-on-click-modal="false"
          :visible.sync="dialogVisible1"
          width="85%"
        >
          <el-tag>总积分</el-tag>:
          <el-tag>{{emp.points}}</el-tag>
          <el-row>
            <el-col style="width:25%">
              <div>
                <el-form-item label="积分项目:" prop="name">
                 <el-select
                    v-model="emp.nationId"
                    style="width: 150px"
                    size="mini"
                    placeholder="请选择积分项目"
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
            <el-col style="width:20%">
              <div>
                <el-form-item label="积分分数:" prop="phone">
                  <el-input
                    v-model="emp.points"
                    size="mini"
                    style="width: 50%"
                  ></el-input>
                </el-form-item>
              </div>
            </el-col>
            <el-col style="width:20%">
              <div>
                <el-form-item label="积分时间:" prop="time">
                  <el-date-picker
                    v-model="emp.points"
                    size="mini"
                    value-format="yyyy-MM-dd"
                    style="width: 50%"
                    type="date"
                    placeholder="选择日期"
                  ></el-date-picker>
                </el-form-item>
              </div>
            </el-col>
            <el-col style="width:35%">
              <div>
                <el-form-item label="积分描述:" prop="phone">
                  <el-input
                    v-model="emp.points"
                    size="mini"
                    style="width: 70%"
                  ></el-input>
                </el-form-item>
              </div>
            </el-col>
          </el-row>

          <el-form-item style="left">
            <el-button type="primary" @click="submitForm('ruleForm')" size="mini">增加积分记录</el-button>
            <el-button @click="resetForm('ruleForm')" size="mini">重置</el-button>
          </el-form-item>
        </el-dialog>
      </div>
    </el-form>

    <el-form :model="emp" :rules="rules" ref="attendance" style="margin: 0px;padding: 0px;">
      <div style="text-align: left">
        <el-dialog
          :title="dialogTitle"
          style="padding: 0px;"
          :close-on-click-modal="false"
          :visible.sync="dialogVisible2"
          width="77%"
        >
          <el-row>
            <el-col :span="6">
              <div>
                <el-form-item label="姓名:" prop="name">
                  <el-input
                    prefix-icon="el-icon-edit"
                    v-model="emp.name"
                    size="mini"
                    style="width: 150px"
                    disabled
                  ></el-input>
                </el-form-item>
              </div>
            </el-col>

            <el-col :span="8">
              <div>
                <el-form-item label="身份证号码:" prop="idCard">
                  <el-input
                    prefix-icon="el-icon-edit"
                    v-model="emp.idCard"
                    size="mini"
                    style="width: 180px"
                    placeholder="请输入学员身份证号码..."
                    disabled
                  ></el-input>
                </el-form-item>
              </div>
            </el-col>

            <el-col :span="6">
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
                    >{{emp.departmentName}}</div>
                  </el-popover>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row>
            <template>
              <el-tag type="danger">考勤记录(次)：</el-tag>
            </template>
            <template v-for="(item,index) in counts">
              <el-tag>{{index}}</el-tag>:
              <el-tag type="info">{{item}}</el-tag>&#12288;
            </template>
          </el-row>

          <span slot="footer" class="dialog-footer">
            <el-button size="mini" @click="cancelEidt">取 消</el-button>
            <el-button size="mini" type="primary" @click="a('attendance')">确 定</el-button>
          </span>
        </el-dialog>
      </div>
    </el-form>
  </div>
</template>
<script>
export default {
  data() {
    return {
      emps: [],
      keywords: "",
      fileUploadBtnText: "导入数据",
      beginDateScope: "",
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
      counts: [],
      defaultProps: {
        label: "name",
        isLeaf: "leaf",
        children: "children"
      },
      dialogVisible: false,
      dialogVisible1: false,
      dialogVisible2: false,
      tableLoading: false,
      advanceSearchViewVisible: false,
      showOrHidePop: false,
      showOrHidePop2: false,
      emp: {
        name: "",
        gender: "",
        birthday: "",
        idCard: "",
        wedlock: "",
        nationId: "",
        nativePlace: "",
        phone: "",
        address: "",
        departmentId: "",
        departmentName: "所属部门...",
        posId: "",
        workID: "",
        points: 0
      },
      ruleForm: {
        name: "",
        region: "",
        date1: "",
        type: [],
        resource: "",
        desc: ""
      },
      att: {
        name: "",
        gender: "",
        birthday: "",
        idCard: "",
        wedlock: "",
        nationId: "",
        nativePlace: "",
        phone: "",
        address: "",
        departmentId: "",
        departmentName: "所属部门...",
        workID: "",
        atime: "",
        aname: "",
        stateId: "",
        sid: ""
      },
      sid: "",

      rules1: {
        name: [
          { required: true, message: "请输入整数积分", trigger: "blur" },
          { min: 1, max: 4, message: "长度在 1 到 3 个字符", trigger: "blur" }
        ],
        region: [
          { required: true, message: "请选择积分项目", trigger: "change" }
        ],
        date1: [
          {
            type: "date",
            required: true,
            message: "请选择日期",
            trigger: "change"
          }
        ],

        resource: [
          { required: true, message: "请选择活动资源", trigger: "change" }
        ],
        desc: [{ required: true, message: "请填写积分描述", trigger: "blur" }]
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
        wedlock: [
          { required: true, message: "必填:婚姻状况", trigger: "blur" }
        ],
        nationId: [{ required: true, message: "必填:民族", trigger: "change" }],
        nativePlace: [
          { required: true, message: "必填:籍贯", trigger: "blur" }
        ],
        phone: [{ required: true, message: "必填:电话号码", trigger: "blur" }],
        address: [
          { required: true, message: "必填:联系地址", trigger: "blur" }
        ],
        departmentId: [
          { required: true, message: "必填:部门", trigger: "change" }
        ],
        posId: [{ required: true, message: "必填:职位", trigger: "change" }],
        workID: [{ required: false, message: "必填:学号", trigger: "blur" }],
        points: [{ required: true, message: "积分", trigger: "change" }]
      }
    };
  },
  mounted: function() {
    this.initData();
    this.loadEmps();
  },
  methods: {
    submitForm(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          alert("submit!");
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    resetForm(formName) {
      this.$refs[formName].resetFields();
    },

    fileUploadSuccess(response, file, fileList) {
      if (response) {
        this.$message({ type: response.status, message: response.msg });
      }
      this.loadEmps();
      this.fileUploadBtnText = "导入数据";
    },
    fileUploadError(err, file, fileList) {
      this.$message({ type: "error", message: "导入失败!" });
      this.fileUploadBtnText = "导入数据";
    },
    beforeFileUpload(file) {
      this.fileUploadBtnText = "正在导入";
    },
    exportEmps() {
      window.open("/student/basic/exportEmp", "_parent");
    },
    cancelSearch() {
      this.advanceSearchViewVisible = false;
      this.emptyEmpData();
      this.beginDateScope = "";
      this.loadEmps();
    },
    showAdvanceSearchView() {
      this.advanceSearchViewVisible = !this.advanceSearchViewVisible;
      this.keywords = "";
      if (!this.advanceSearchViewVisible) {
        this.emptyEmpData();
        this.beginDateScope = "";
        this.loadEmps();
      }
    },
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    deleteManyEmps() {
      this.$confirm(
        "此操作将删除[" + this.multipleSelection.length + "]条数据, 是否继续?",
        "提示",
        {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }
      )
        .then(() => {
          var ids = "";
          for (var i = 0; i < this.multipleSelection.length; i++) {
            ids += this.multipleSelection[i].id + ",";
          }
          this.doDelete(ids);
        })
        .catch(() => {});
    },
    deleteEmp(row) {
      this.$confirm("此操作将永久删除[" + row.name + "], 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(() => {
          this.doDelete(row.id);
        })
        .catch(() => {});
    },
    doDelete(ids) {
      this.tableLoading = true;
      var _this = this;
      this.deleteRequest("/student/basic/emp/" + ids).then(resp => {
        _this.tableLoading = false;
        if (resp && resp.status == 200) {
          var data = resp.data;

          _this.loadEmps();
        }
      });
    },
    keywordsChange(val) {
      if (val == "") {
        this.loadEmps();
      }
    },
    searchEmp() {
      this.loadEmps();
    },
    currentChange(currentChange) {
      this.currentPage = currentChange;
      this.loadEmps();
    },
    loadEmps() {
      var _this = this;
      this.tableLoading = true;
      this.getRequest(
        "/student/basic/emp?page=" +
          this.currentPage +
          "&size=10&keywords=" +
          this.keywords +
          "&nationId=" +
          this.emp.nationId +
          "&departmentId=" +
          this.emp.departmentId
      ).then(resp => {
        this.tableLoading = false;
        if (resp && resp.status == 200) {
          var data = resp.data;
          _this.emps = data.emps;
          _this.totalCount = data.count;
          //            _this.emptyEmpData();
        }
      });
    },
    addEmp(formName) {
      var _this = this;
      this.$refs[formName].validate(valid => {
        if (valid) {
          if (this.emp.id) {
            //更新
            this.tableLoading = true;
            this.putRequest("/student/basic/emp", this.emp).then(resp => {
              _this.tableLoading = false;
              if (resp && resp.status == 200) {
                var data = resp.data;
                _this.dialogVisible = false;
                _this.emptyEmpData();
                _this.loadEmps();
              }
            });
          } else {
            //添加
            this.tableLoading = true;
            this.postRequest("/student/basic/emp", this.emp).then(resp => {
              _this.tableLoading = false;
              if (resp && resp.status == 200) {
                var data = resp.data;

                _this.dialogVisible = false;
                _this.emptyEmpData();
                _this.loadEmps();
              }
            });
          }
        } else {
          return false;
        }
      });
    },
    cancelEidt() {
      this.dialogVisible = false;
      this.dialogVisible1 = false;
      this.dialogVisible2 = false;
      this.emptyEmpData();
    },
    showDepTree() {
      this.showOrHidePop = !this.showOrHidePop;
    },
    showDepTree2() {
      this.showOrHidePop2 = !this.showOrHidePop2;
    },
    handleNodeClick(data) {
      this.emp.departmentName = data.name;
      this.emp.departmentId = data.id;
      this.showOrHidePop = false;
      this.depTextColor = "#606266";
    },
    handleNodeClick2(data) {
      this.emp.departmentName = data.name;
      this.emp.departmentId = data.id;
      this.showOrHidePop2 = false;
      this.depTextColor = "#606266";
    },
    initData() {
      var _this = this;
      this.getRequest("/student/basic/basicdata").then(resp => {
        if (resp && resp.status == 200) {
          var data = resp.data;
          _this.nations = data.nations;
          _this.politics = data.politics;
          _this.deps = data.deps;
          _this.positions = data.positions;
          _this.joblevels = data.joblevels;
          _this.emp.workID = data.workID;
        }
        console.log(resp.data);
      });
    },
    showEditEmpView(row) {
      console.log(row);
      this.dialogTitle = "编辑学员";
      this.emp = row;
      this.emp.birthday = this.formatDate(row.birthday);

      this.emp.nationId = row.nation.id;
      this.emp.departmentId = row.department.id;
      this.emp.departmentName = row.department.name;
      // this.emp.posId = row.position.id;
      //        delete this.emp.department;
      this.dialogVisible = true;
    },
    showAddEmpView() {
      this.dialogTitle = "添加学员";
      this.dialogVisible = true;
      var _this = this;
      this.getRequest("/student/basic/maxWorkID").then(resp => {
        if (resp && resp.status == 200) {
          _this.emp.workID = resp.data;
        }
      });
    },
    showEditPointView(row) {
      this.dialogTitle = "积分管理";
      this.emp = row;
      this.emp.points = row.points;
      // this.emp.conversionTime = this.formatDate(row.conversionTime);

      this.emp.nationId = row.nation.id;
      this.emp.departmentId = row.department.id;
      this.emp.departmentName = row.department.name;

      this.dialogVisible1 = true;
    },

    showAttendanceView(row) {
      this.dialogTitle = "考勤详情";
      this.emp = row;
      this.emp.id = row.id;
      this.emp.points = row.points;

      this.emp.nationId = row.nation.id;
      this.emp.departmentId = row.department.id;
      this.emp.departmentName = row.department.name;

      this.dialogVisible2 = true;

      var _this = this;
      this.getRequest("/attendance/count?sid=" + this.emp.id).then(resp => {
        if (resp && resp.status == 200) {
          _this.counts = resp.data.counts;
          console.log(_this.counts);
        }
      });
    },
    emptyEmpData() {
      this.emp = {
        name: "",
        gender: "",
        birthday: "",
        idCard: "",
        wedlock: "",
        nationId: "",
        nativePlace: "",
        phone: "",
        address: "",
        departmentId: "",
        departmentName: "所属部门...",
        posId: "",
        workID: "",
        points: 0
      };
    }
  }
};
</script>
<style>
.el-dialog__body {
  padding-top: 0px;
  padding-bottom: 0px;
}

.slide-fade-enter-active {
  transition: all 0.8s ease;
}

.slide-fade-leave-active {
  transition: all 0.8s cubic-bezier(1, 0.5, 0.8, 1);
}

.slide-fade-enter,
.slide-fade-leave-to {
  transform: translateX(10px);
  opacity: 0;
}
</style>
