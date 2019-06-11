<template>
  <div>
    <el-container class="home-container">
      <el-header class="home-header">
        <span class="home_title">新时代农民讲习所</span>
        <div style="display: flex;align-items: center;margin-right: 7px">
          
          <div>
            <span
              @click="login()"
              class="el-dropdown-link home_userinfo"
              style="display: flex;align-items: center;width: 40px;height: 40px;margin-right: 5px;margin-left: 5px;border-radius: 40px"
            >点击登录</span>
          </div>
          <el-dropdown @command="handleCommand">
            <span class="el-dropdown-link home_userinfo" style="display: flex;align-items: center">
              {{user.name}}
              <i>
                <img
                  v-if="user.userface!=''"
                  :src="user.userface"
                  style="width: 40px;height: 40px;margin-right: 5px;margin-left: 5px;border-radius: 40px"
                >
              </i>
            </span>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item>个人中心</el-dropdown-item>
              <el-dropdown-item>设置</el-dropdown-item>
              <el-dropdown-item command="logout" divided>注销</el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </div>
      </el-header>

        <el-form
          :rules="rules"
          
          label-position="left"
          label-width="0px"
          v-loading="loading"
        >
            <el-dialog
              style="padding: 0px;"
              :close-on-click-modal="false"
              :visible.sync="dialogVisible"
              width="35%"
            >
              <h3 class="login_title">系统登录</h3>
              <el-form-item prop="account">
                <el-input
                  type="text"
                  v-model="loginForm.username"
                  auto-complete="off"
                  placeholder="账号"
                ></el-input>
              </el-form-item>
              <el-form-item prop="checkPass">
                <el-input
                  type="password"
                  v-model="loginForm.password"
                  auto-complete="off"
                  placeholder="密码"
                ></el-input>
              </el-form-item>
              <el-checkbox class="login_remember" v-model="checked" label-position="left">记住密码</el-checkbox>
              <el-form-item style="width: 100%">
                <el-button type="primary" style="width: 100%" @click="submitClick">登录</el-button>
              </el-form-item>
            </el-dialog>
        </el-form>

    </el-container>
  </div>
</template>
<script>
export default {
  computed: {
    user() {
      return this.$store.state.user;
    },
    routes() {
      return this.$store.state.routes;
    }
  },
  data() {
    return {
      isDot: false,
      dialogVisible: false,
      rules: {
        account: [{ required: true, message: "请输入用户名", trigger: "blur" }],
        checkPass: [{ required: true, message: "请输入密码", trigger: "blur" }]
      },
      checked: true,
      loginForm: {
        username: "admin",
        password: "123"
      },
      loading: false
    };
  },
  methods: {
    login() {
      this.dialogVisible = true;
    },
    loadNF() {
      var _this = this;
      this.getRequest("/chat/sysmsgs").then(resp => {
        var isDot = false;
        resp.data.forEach(msg => {
          if (msg.state == 0) {
            isDot = true;
          }
        });
        _this.$store.commit("toggleNFDot", isDot);
      });
    },
    goChat() {
      this.$router.push({ path: "/chat" });
    },
    devMsg() {
      this.$alert(
        "为了确保所有的小伙伴都能看到完整的数据演示，数据库只开放了查询权限和部分字段的更新权限，其他权限都不具备，完整权限的演示需要大家在自己本地部署后，换一个正常的数据库用户后即可查看，这点请大家悉知!",
        "友情提示",
        {
          confirmButtonText: "确定",
          callback: action => {
            this.$notify({
              title: "重要重要!",
              type: "warning",
              message:
                "小伙伴们需要注意的是，目前只有权限管理模块完工了，因此这个项目中你无法看到所有的功能，除了权限管理相关的模块。权限管理相关的模块主要有两个，分别是 [系统管理->基础信息设置->权限组] 可以管理角色和资源的关系， [系统管理->操作员管理] 可以管理用户和角色的关系。",
              duration: 0
            });
          }
        }
      );
    },
    handleCommand(cmd) {
      var _this = this;
      if (cmd == "logout") {
        this.$confirm("注销登录, 是否继续?", "提示", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        })
          .then(() => {
            _this.getRequest("/logout");
            _this.$store.commit("logout");
            _this.$router.replace({ path: "/" });
          })
          .catch(() => {
            _this.$message({
              type: "info",
              message: "取消"
            });
          });
      }
    },
    submitClick: function() {
      var _this = this;
      this.loading = true;
      this.postRequest("/login", {
        username: this.loginForm.username,
        password: this.loginForm.password
      }).then(resp => {
        _this.loading = false;
        if (resp && resp.status == 200) {
          var data = resp.data;
          _this.$store.commit("login", data.obj);
          var path = _this.$route.query.redirect;
          _this.$router.replace({
            path: path == "/" || path == undefined ? "/home" : path
          });
        }
      });
    }
  }
};
</script>
<style>
.login-container {
  border-radius: 15px;
  background-clip: padding-box;
  margin: 180px auto;
  width: 350px;
  padding: 35px 35px 15px 35px;
  background: #fff;
  border: 1px solid #eaeaea;
  box-shadow: 0 0 25px #cac6c6;
}
.login_title {
  margin: 0px auto 40px auto;
  text-align: center;
  color: #505458;
}
.login_remember {
  margin: 0px 0px 35px 0px;
  text-align: left;
}
.home-container {
  height: 100%;
  position: absolute;
  top: 0px;
  left: 0px;
  width: 100%;
}

.home-header {
  background-color: #20a0ff;
  color: #333;
  text-align: center;
  display: flex;
  align-items: center;
  justify-content: space-between;
  box-sizing: content-box;
  padding: 0px;
}

.home-aside {
  background-color: #ececec;
}

.home-main {
  background-color: #fff;
  color: #000;
  text-align: center;
  margin: 0px;
  padding: 0px;
}

.home_title {
  color: #fff;
  font-size: 22px;
  display: inline;
  margin-left: 8px;
}

.home_userinfo {
  color: #fff;
  cursor: pointer;
}

.home_userinfoContainer {
  display: inline;
  margin-right: 20px;
}

.el-submenu .el-menu-item {
  width: 180px;
  min-width: 175px;
}
</style>
