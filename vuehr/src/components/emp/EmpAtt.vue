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
            action="/attendance/importAtt"
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
          <el-button type="success" size="mini" @click="exportAtt">
            <i class="fa fa-lg fa-level-down" style="margin-right: 5px"></i>导出数据
          </el-button>
          <!-- <el-button type="primary" size="mini" icon="el-icon-plus" @click="showAddEmpView">添加考勤</el-button> -->
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
            :data="atts"
            v-loading="tableLoading"
            border
            stripe
            @selection-change="handleSelectionChange"
            size="mini"
            style="width: 100%"
          >
            <el-table-column type="selection" align="left" width="30"></el-table-column>
            <el-table-column prop="student.name" align="left" fixed label="姓名" width="90"></el-table-column>
            <el-table-column prop="student.gender" label="性别" width="50"></el-table-column>

            <el-table-column prop="student.idCard" width="150" align="left" label="身份证号码"></el-table-column>

            <el-table-column prop="student.phone" width="100" label="电话号码"></el-table-column>
            <el-table-column prop="department.name" align="left" width="100" label="所属部门"></el-table-column>
            <el-table-column prop="atime" width="100" label="考勤时间">
              <template slot-scope="scope">{{ scope.row.atime | formatDate}}</template>
            </el-table-column>
            <el-table-column prop="attname.name" width="100" label="考勤状态"></el-table-column>
            <!-- <el-table-column prop="student.workID" width="95" align="left" label="学号"></el-table-column> -->

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
              v-if="atts.length>0"
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
    <el-form :model="att" :rules="rules" ref="addAttForm" style="margin: 0px;padding: 0px;">
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
                <el-form-item label="姓名:" prop="student.name">
                  <el-input
                    prefix-icon="el-icon-edit"
                    v-model="att.name"
                    size="mini"
                    style="width: 150px"
                    placeholder="请输入学员姓名"
                    disabled
                  ></el-input>
                </el-form-item>
              </div>
            </el-col>
            <el-col :span="6">
              <div>
                <el-form-item label="所属部门:" prop="department.departmentId">
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
                    >{{att.departmentName}}</div>
                  </el-popover>
                </el-form-item>
              </div>
            </el-col>

            <el-col :span="8">
              <div>
                <el-form-item label="身份证号码:" prop="student.idCard">
                  <el-input
                    prefix-icon="el-icon-edit"
                    v-model="att.idCard"
                    size="mini"
                    style="width: 180px"
                    placeholder="请输入员工身份证号码..."
                    disabled
                  ></el-input>
                </el-form-item>
              </div>
            </el-col>
          </el-row>

          <el-row>
            <el-col :span="6">
              <div>
                <el-form-item label="考勤时间:" prop="atime">
                  <el-date-picker
                    v-model="attendance.atime"
                    size="mini"
                    value-format="yyyy-MM-dd"
                    style="width: 150px"
                    type="date"
                    placeholder="请选择考勤时间"
                  ></el-date-picker>
                </el-form-item>
              </div>
            </el-col>

            <el-col :span="8">
              <div>
                <el-form-item label="考勤状态:" prop="attendance.aname">
                  <el-select
                    v-model="attendance.stateId"
                    style="width: 130px"
                    size="mini"
                    placeholder="请选择考勤状态"
                  >
                    <el-option
                      v-for="item in attname"
                      :key="item.id"
                      :label="item.name"
                      :value="item.id"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <span slot="footer" class="dialog-footer">
            <el-button size="mini" @click="cancelEidt">取 消</el-button>
            <el-button size="mini" type="primary" @click="addAtt('addAttForm')">确 定</el-button>
          </span>
        </el-dialog>
      </div>
    </el-form>

    <el-form :model="att" :rules="rules" ref="attendance" style="margin: 0px;padding: 0px;">
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
                <el-form-item label="姓名:" prop="student.name">
                  <el-input
                    prefix-icon="el-icon-edit"
                    v-model="att.name"
                    size="mini"
                    style="width: 150px"
                    disabled
                  ></el-input>
                </el-form-item>
              </div>
            </el-col>

            <el-col :span="8">
              <div>
                <el-form-item label="身份证号码:" prop="student.idCard">
                  <el-input
                    prefix-icon="el-icon-edit"
                    v-model="att.idCard"
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
                    >{{att.departmentName}}</div>
                  </el-popover>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="4">
              <div>
                <el-form-item label="考勤记录（次）："></el-form-item>
              </div>
            </el-col>
            <el-col :span="4">
              <div>
                <el-form-item label="出勤:" prop="nativePlace">1</el-form-item>
              </div>
            </el-col>

            <el-col :span="5">
              <div>
                <el-form-item label="迟到:" prop="address">0</el-form-item>
              </div>
            </el-col>
            <el-col :span="5">
              <div>
                <el-form-item label="早退:" prop="address">0</el-form-item>
              </div>
            </el-col>
            <el-col :span="5">
              <div>
                <el-form-item label="缺勤:" prop="address">2</el-form-item>
              </div>
            </el-col>
          </el-row>

          <el-calendar>
            <!-- 这里使用的是 2.5 slot 语法，对于新项目请使用 2.6 slot 语法-->
            <template slot="dateCell" slot-scope="{date, data}">
              <p
                :class="data.isSelected ? 'is-selected' : ''"
              >{{ data.day.split('-').slice(1).join('-') }} {{ data.isSelected ? '✔️' : ''}}</p>
            </template>
          </el-calendar>

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
      atts: [],
      attname: [],
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
        points: 0,
        atime: "",
        aname: "",
        stateId: "",
        sid: ""
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
      attendance: {
        id: "",
        atime: "",
        stateId: "",
        sid: "",
        des: ""
      },

      rules: {
        name: [{ required: true, message: "必填:姓名", trigger: "blur" }],
        gender: [{ required: true, message: "必填:性别", trigger: "blur" }],

        nationId: [{ required: true, message: "必填:民族", trigger: "change" }],

        phone: [{ required: true, message: "必填:电话号码", trigger: "blur" }],

        departmentId: [
          { required: true, message: "必填:部门", trigger: "change" }
        ],
        workID: [{ required: true, message: "必填:学号", trigger: "blur" }],
        points: [{ required: true, message: "积分", trigger: "change" }]
      }
    };
  },
  computed: {
    userhr() {
      return this.$store.state.user;
    }
  },
  mounted: function() {
    this.initData();
    this.loadEmps();
  },
  methods: {
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
    exportAtt() {
      window.open("/attendance/exportAtt", "_parent");
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
      this.$confirm(
        "此操作将永久删除[" + row.student.name + "], 是否继续?",
        "提示",
        {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }
      )
        .then(() => {
          this.doDelete(row.id);
        })
        .catch(() => {});
    },
    doDelete(ids) {
      this.tableLoading = true;
      var _this = this;
      this.deleteRequest("/attendance/att/" + ids).then(resp => {
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
        "/attendance/att?page=" +
          this.currentPage +
          "&size=10&keywords=" +
          this.keywords +
          "&atime=" +
          this.att.atime +
          "&stateId=" +
          this.att.stateId +
          "&sid=" +
          this.att.sid +
          "&departmentId=" +
          this.att.departmentId +
          "&upid=" +
          this.userhr.departmentId
      ).then(resp => {
        this.tableLoading = false;
        if (resp && resp.status == 200) {
          var data = resp.data;
          _this.atts = data.atts;
          _this.totalCount = data.count;
          //            _this.emptyEmpData();
        }
      });
    },
    addAtt(formName) {
      var _this = this;
      this.$refs[formName].validate(valid => {
        if (valid) {
          if (this.att.id) {
            //更新
            this.tableLoading = true;
            this.putRequest("/attendance/att", this.attendance).then(resp => {
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
            this.postRequest("/attendance/att", this.att).then(resp => {
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
      this.getRequest("/attendance/basicdata").then(resp => {
        if (resp && resp.status == 200) {
          var data = resp.data;
          _this.nations = data.nations;
          _this.attname = data.attname;
          _this.politics = data.politics;
          _this.deps = data.deps;
          _this.positions = data.positions;
        }
        console.log(resp.data);
      });
    },
    showEditEmpView(row) {
      console.log(row);
      this.dialogTitle = "编辑考勤";
      this.att = row;
      this.att.atime = this.formatDate(row.atime);
      this.att.name = row.student.name;
      this.att.idCard = row.student.idCard;

      this.att.departmentId = row.department.id;
      this.att.departmentName = row.department.name;
      this.att.stateId = row.attname.id;
      this.att.aname = row.attname.name;
      //        delete this.emp.department;
      this.dialogVisible = true;

      this.attendance.id = row.id;
      this.attendance.atime = this.att.atime;
      this.attendance.aname = this.att.aname;
      this.attendance.stateId = this.att.stateId;
    },
    showAddEmpView() {
      this.dialogTitle = "添加考勤";
      this.dialogVisible = true;
      var _this = this;
    },
    showEditPointView(row) {
      this.dialogTitle = "积分修改";
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
      this.att = row;
      this.att.atime = this.formatDate(row.atime);
      this.att.name = row.student.name;
      this.att.idCard = row.student.idCard;

      this.att.departmentId = row.department.id;
      this.att.departmentName = row.department.name;
      this.att.stateId = row.attname.id;
      this.att.aname = row.attname.name;
      this.att.stateId = row.stateId.id;

      this.dialogVisible2 = true;
    },
    emptyEmpData() {
      this.att = {
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
        atime: "",
        aname: "",
        stateId: "",
        sid: ""
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

.is-selected {
  color: #1989fa;
}
</style>

