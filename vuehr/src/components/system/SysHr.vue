<template>
  <div>
    <el-container>
      <el-header
        style="padding: 0px;display:flex;justify-content:space-between;align-items: center"
      >
        <div style="display: inline">
          <el-input
            placeholder="通过姓名搜索管理员,记得回车哦..."
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
            action="/system/hr/importUsers"
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
          <el-button type="success" size="mini" @click="exportUsers">
            <i class="fa fa-lg fa-level-down" style="margin-right: 5px"></i>导出数据
          </el-button>
          <el-button type="primary" size="mini" icon="el-icon-plus" @click="showAddEmpView">添加管理员</el-button>
        </div>
      </el-header>
      <el-main style="padding-left: 0px;padding-top: 0px">
        <div>
          <transition name="slide-fade">
            <div
              style="margin-bottom: 10px;border: 1px;border-radius: 5px;border-style: solid;padding: 5px 0px 5px 0px;box-sizing:border-box;border-color: #20a0ff"
              v-show="advanceSearchViewVisible"
            >
              <el-row></el-row>
              <el-row style="margin-top: 10px">
                <el-col :span="4">
                  民族:
                  <el-select
                    v-model="hr.nationId"
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
                    >{{hr.departmentName}}</div>
                  </el-popover>
                </el-col>

                <el-col :span="5" :offset="4">
                  <el-button size="mini" @click="cancelSearch">取消</el-button>
                  <el-button icon="el-icon-search" type="primary" size="mini" @click="searchEmp">搜索</el-button>
                </el-col>
              </el-row>
            </div>
          </transition>
          <el-table
            :data="hrs"
            v-loading="tableLoading"
            border
            stripe
            @selection-change="handleSelectionChange"
            size="mini"
            style="width: 100%"
          >
            <el-table-column type="selection" align="left" width="30"></el-table-column>
            <el-table-column prop="name" align="left" fixed label="姓名" width="90"></el-table-column>

            <el-table-column prop="gender" label="性别" width="50"></el-table-column>

            <el-table-column prop="idCard" width="150" align="left" label="身份证号码"></el-table-column>

            <el-table-column width="60" prop="nation.name" label="民族"></el-table-column>

            <el-table-column prop="phone" width="100" label="电话号码"></el-table-column>

            <el-table-column prop="department.name" align="left" width="100" label="所属部门"></el-table-column>
            <el-table-column width="100" align="left" prop="roles[0].nameZh" label="角色"></el-table-column>

            <el-table-column width="85" align="left" label="出生日期">
              <template slot-scope="scope">{{ scope.row.birthday | formatDate}}</template>
            </el-table-column>
            <el-table-column prop="address" width="220" align="left" label="联系地址"></el-table-column>
            <el-table-column prop="email" width="180" align="left" label="电子邮件"></el-table-column>

            <el-table-column fixed="right" label="操作" width="195">
              <template slot-scope="scope">
                <el-button
                  @click="showEditEmpView(scope.row)"
                  style="padding: 3px 4px 3px 4px;margin: 2px"
                  size="mini"
                >编辑</el-button>
                <el-button
                  @click="showaddRoleView(scope.row)"
                  style="padding: 3px 4px 3px 4px;margin: 2px"
                  type="primary"
                  size="mini"
                >角色管理</el-button>
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
              v-if="hrs.length>0"
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
    <el-form :model="user" :rules="rules" ref="editUserForm" style="margin: 0px;padding: 0px;">
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
                    v-model="user.name"
                    size="mini"
                    style="width: 150px"
                    placeholder="请输入管理员姓名"
                  ></el-input>
                </el-form-item>
              </div>
            </el-col>
            <el-col :span="5">
              <div>
                <el-form-item label="性别:" prop="gender">
                  <el-radio-group v-model="user.gender">
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
                    v-model="user.birthday"
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
                    v-model="user.nationId"
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

            <el-col :span="7">
              <div>
                <el-form-item label="联系地址:" prop="address">
                  <el-input
                    prefix-icon="el-icon-edit"
                    v-model="user.address"
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
                    >{{user.departmentName}}</div>
                  </el-popover>
                </el-form-item>
              </div>
            </el-col>
            <el-col :span="7">
              <div>
                <el-form-item label="电话号码:" prop="phone">
                  <el-input
                    prefix-icon="el-icon-phone"
                    v-model="user.phone"
                    size="mini"
                    style="width: 200px"
                    placeholder="电话号码..."
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
                    v-model="user.idCard"
                    size="mini"
                    style="width: 180px"
                    placeholder="请输入员工身份证号码..."
                  ></el-input>
                </el-form-item>
              </div>
            </el-col>

            <el-col :span="8">
              <div>
                <el-form-item label="邮箱:" prop="email">
                  <el-input
                    prefix-icon="el-icon-edit"
                    v-model="user.email"
                    size="mini"
                    style="width: 180px"
                    placeholder="请输入邮箱..."
                  ></el-input>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <span slot="footer" class="dialog-footer">
            <el-button size="mini" @click="cancelEidt">取 消</el-button>
            <el-button size="mini" type="primary" @click="addEmp('editUserForm')">确 定</el-button>
          </span>
        </el-dialog>
      </div>
    </el-form>

    <el-form :model="hr" :rules="rules" ref="addUserForm" style="margin: 0px;padding: 0px;">
      <div style="text-align: left">
        <el-dialog
          :title="dialogTitle"
          style="padding: 0px;"
          :close-on-click-modal="false"
          :visible.sync="dialogVisible1"
          width="77%"
        >
          <el-row>
            <el-col :span="6">
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
            <el-col :span="5">
              <div>
                <el-form-item label="性别:" prop="gender">
                  <el-radio-group v-model="hr.gender">
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
            <el-col :span="6">
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

            <el-col :span="7">
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
                    >{{hr.departmentName}}</div>
                  </el-popover>
                </el-form-item>
              </div>
            </el-col>
            <el-col :span="7">
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
            <el-col :span="8">
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

            <el-col :span="8">
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
          <span slot="footer" class="dialog-footer">
            <el-button size="mini" @click="cancelEidt">取 消</el-button>
            <el-button size="mini" type="primary" @click="addUser()">确 定</el-button>
          </span>
        </el-dialog>
      </div>
    </el-form>

    <div style="text-align: left">
      <el-dialog title="角色管理" :visible.sync="dialogVisible3" width="25%">
        <div class="user-info">
          用户角色:
          <el-tag
            v-for="role in role"
            :key="role.id"
            type="success"
            size="mini"
            style="margin-right: 5px"
            :disable-transitions="false"
          >{{role.nameZh}}</el-tag>
          <el-popover
            v-loading="eploading[0]"
            placement="right"
            title="角色列表"
            width="200"
            @hide="updateHrRoles()"
            :key="role.id"
            trigger="click"
          >
            <el-select v-model="selRoles" multiple placeholder="请选择角色">
              <el-option v-for="ar in role" :key="ar.id" :label="ar.nameZh" :value="ar.id"></el-option>
            </el-select>
            <el-button
              type="text"
              icon="el-icon-more"
              style="color: #09c0f6;padding-top: 0px"
              slot="reference"
              @click="loadSelRoles()"
              :disabled="moreBtnState"
            ></el-button>
          </el-popover>
        </div>
        <div>
          <span>选择角色</span>
          <el-select
            @change="selectGet"
            v-model="rid"
            style="width: 200px"
            placeholder="请选择"
            size="mini"
          >
            <el-option v-for="item in role" :key="item.id" :label="item.nameZh" :value="item.id"></el-option>
          </el-select>
        </div>

        <span slot="footer" class="dialog-footer">
          <el-button size="small" @click="dialogVisible3 = false">取消</el-button>
          <el-button size="small" type="primary" @click="addRole(rid)">确定</el-button>
        </span>
      </el-dialog>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      emps: [],
      hrs: [],
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
      cardLoading: [],
      totalCount: -1,
      currentPage: 0,
      obj: {},

      fullloading: false,
      cardLoading: [],
      eploading: [],
      allRoles: [],
      moreBtnState: false,
      selRoles: [],
      selRolesBak: [],
      rid: "",

      deps: [],
      roles: [],
      defaultProps: {
        label: "name",
        isLeaf: "leaf",
        children: "children"
      },
      dialogVisible: false,
      dialogVisible1: false,
      dialogVisible3: false,
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
        email: "",
        nationId: "",
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
        email: "",
        departmentName: "所属部门..."
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
        address: [
          { required: true, message: "必填:联系地址", trigger: "blur" }
        ],
        departmentId: [
          { required: true, message: "必填:部门", trigger: "change" }
        ]
      }
    };
  },
  mounted: function() {
    this.initData();
    this.loadEmps();
    this.initCards();
    this.loadAllRoles();
  },
  methods: {
    searchClick() {
      this.initCards();
      this.loadAllRoles();
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
    exportUsers() {
      window.open("/system/hr/exportUsers", "_parent");
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
      this.deleteRequest("/system/hr/" + ids).then(resp => {
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

      var searchWords;
      if (this.keywords === "") {
        searchWords = "all";
      } else {
        searchWords = this.keywords;
      }
      this.getRequest(
        "/system/hr/?page=" +
          this.currentPage +
          "&size=10&keywords=" +
          this.keywords +
          "&nationId=" +
          this.hr.nationId +
          "&departmentId=" +
          this.hr.departmentId
      ).then(resp => {
        this.tableLoading = false;
        if (resp && resp.status == 200) {
          var data = resp.data;
          _this.hrs = data.hrs;
          _this.roles = data.roles;
          _this.nation = data.nation;
          _this.totalCount = data.count;
          //            _this.emptyEmpData();

          console.log(data);
        }
      });
    },
    addEmp(formName) {
      var _this = this;
      this.$refs[formName].validate(valid => {
        if (valid) {
          if (this.hr.id) {
            //更新
            this.tableLoading = true;
            this.putRequest("/system/hr/", this.user).then(resp => {
              _this.tableLoading = false;
              this.loadEmps();
              if (resp && resp.status == 200) {
                var data = resp.data;

                _this.dialogVisible = false;
                this.emptyEmpData();

                this.loadEmps();
              }
            });
          } else {
            //添加
            this.tableLoading = true;
            this.postRequest("/system/hr/", this.hr).then(resp => {
              _this.tableLoading = false;
              if (resp && resp.status == 200) {
                var data = resp.data;

                _this.dialogVisible1 = false;
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
    addUser() {
      var _this = this;
      this.tableLoading = true;
      this.postRequest("/system/hr/", this.hr).then(resp => {
        _this.tableLoading = false;
        if (resp && resp.status == 200) {
          var data = resp.data;

          _this.dialogVisible1 = false;
          _this.emptyEmpData();
          _this.loadEmps();
        }
      });
    },
    addRole(rid) {
      var _this = this;
      this.dialogVisible3 = false;
      this.treeLoading = true;
      this.putRequest("/system/hr/roles", {
        hrId: this.hrId,
        rids: [rid]
      }).then(resp => {
        // _this.eploading.splice(index, 1, false);
        if (resp && resp.status == 200) {
          var data = resp.data;
          this.emptyEmpData();
          _this.loadEmps();
        }
      });
    },
    selectGet(vId) {
      let obj = {};
      obj = this.role.find(item => {
        //这里的selectList就是上面遍历的数据源
        return item.id === vId; //筛选出匹配数据
      });
      return obj.id;
      console.log(obj.name); //我这边的name就是对应label的
      console.log(obj.id);
    },
    showaddRoleView(row) {
      var _this = this;
      // this.loadAllDeps();
      this.dialogVisible3 = true;
       _this.role = this.row.roles;
      _this.hrId = row.id;
      // _this.rids = []

      event.stopPropagation();
    },

    reg() {
      this.postRequest("/system/hr/hr/reg", {
        username: 123,
        password: 123
      }).then(resp => {
        if (resp && resp.status == 200) {
          var data = resp.data;
          console.log(data);
        }
      });
    },
    cancelEidt() {
      this.dialogVisible = false;
      this.dialogVisible1 = false;
      this.emptyEmpData();
    },
    showDepTree() {
      this.showOrHidePop = !this.showOrHidePop;
    },
    showDepTree2() {
      this.showOrHidePop2 = !this.showOrHidePop2;
    },
    handleNodeClick(data) {
      this.hr.departmentName = data.name;
      this.hr.departmentId = data.id;
      this.user.departmentId = this.hr.departmentId;
      this.user.departmentName = this.hr.departmentName;
      this.showOrHidePop = false;
      this.depTextColor = "#606266";
    },
    handleNodeClick2(data) {
      this.hr.departmentName = data.name;
      this.hr.departmentId = data.id;
      this.showOrHidePop2 = false;
      this.depTextColor = "#606266";
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
          _this.role = data.roles;
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
      this.user.username = this.hr.phone;
    },
    showAddEmpView() {
      this.dialogTitle = "添加管理员";
      this.dialogVisible1 = true;
      var _this = this;

      _this.hr.enabled = true;
      _this.hr.username = "123";
      _this.hr.password = "123";
      _this.hr.remark = "1";
      _this.hr.userface = "";
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
        username: "",
        password: "",
        userface: "",
        idCard: "",
        remark: "",
        birthday: "",
        email: "",
        nationId: "",

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
