<template>
  <div>
    <el-container class="home-container">
      <!-- <el-header class="home-header">
       

        <div class="section">
       
          <ul class="login">
            <li class="log-item">
              <ul>
                <li>讲思想&nbsp;&nbsp;&nbsp;千有方向</li>
                <li>讲技术&nbsp;&nbsp;&nbsp;千有本领</li>
              </ul>
            </li>
            <li class="log-item">
              <ul>
                <li>讲感恩&nbsp;&nbsp;&nbsp;千有激情</li>
                <li>讲比武&nbsp;&nbsp;&nbsp;千有榜样</li>
              </ul>
            </li>
            <li class="log-item">
              <ul>
                <li>讲政策&nbsp;&nbsp;&nbsp;千有思路</li>
                <li>讲道德&nbsp;&nbsp;&nbsp;千有精神</li>
              </ul>
            </li>
            <li class="search gy-flex">
              <input type="text" placeholder="请输入关键字">
              <i class="iconfont icon-iconfontzhizuobiaozhun22"></i>
              <a href="./index.html">登录</a>
            </li>
            <li>
                <button
                  @click="login()"
                >点击登录</button>
            </li>
          </ul>
        </div>
      </el-header> -->

      <!-- <el-main>
        <hr>
        <hr>
        
      </el-main> -->
<!-- 
      <el-footer>
        <div class="fo-top">
          <div class="section pad-left bianm">便民服务：</div>
          <div class="section gy-flex pad-left fo-sec">
            <ul class="foot-list">
              <li>
                <img src="images/logo.jpg" alt>
              </li>
              <li class="banquan">
                <p>版权所有：</p>
                <sapn>宁夏固原市宣传部</sapn>
              </li>
              <li>
                <p>联系电话：</p>
                <span>(0954)2088900</span>
              </li>
              <li>
                <p>电子邮箱：</p>
                <span>gydzzw@126.com</span>
              </li>
              <li>
                <p>网站标识码：</p>
                <span>6404000021|Copyright@ all rights reserved 宁 ICP 备 05001237号</span>
              </li>
            </ul>
            <div class="right-line"></div>
            <ul class="foot-right">
              <li>网站导航</li>
              <li>
                <a href="##">固原市人民政府官网</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                <a href="##">固原党建网</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                <a href="##">固原市人民信息网</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                <a href="##">固原市人民信息网</a>
              </li>
              <li>
                <a href="##">固原市人民政府官网</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                <a href="##">固原市人民信息网</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                <a href="##">固原市人民信息网</a>
              </li>
              <li>
                <a href="##">固原市人民政府官网</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                <a href="##">固原党建网</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                <a href="##">固原市人民信息网</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                <a href="##">固原市人民信息网</a>
              </li>
              <li>
                <a href="##">固原市人民政府官网</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                <a href="##">固原党建网</a>
              </li>
              <li>
                <img class="zf" src="images/zf.jpg" alt>
                <img class="jg" src="images/jg.jpg" alt>
              </li>
            </ul>
          </div>
        </div>
      </el-footer> -->

      <el-form :rules="rules" label-position="left" label-width="0px" v-loading="loading">
        <el-dialog
          style="padding: 0px;"
          :close-on-click-modal="false"
          :visible.sync="dialogVisible"
          width="35%"
        >
          <h3 class="login_title">系统登录</h3>
          <el-form-item prop="account">
            <el-input type="text" v-model="loginForm.username" auto-complete="off" placeholder="账号"></el-input>
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
      dialogVisible: true,
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
/* @import "css/iconfont.css"; */
/* @import "./css/public.css"; */
/* @import "css/swiper.min.css"; */
/* @import "css/index.css"; */

.section {
  width: 1200px;
  margin: 0 auto;
}
.head-logo {
  width: 100%;
  border-bottom: 4px double #20a0ff;
}
.bg {
  width: 755px;
  margin: 56px auto 40px;
  height: 60px;
  background: #20a0ff;
}

.login {
  display: flex;
  justify-content: space-around;
  align-items: center;
  height: 132px;
}
.log-item {
  color: #f80707;
  font-style: italic;
  line-height: 32px;
}

.login-container {
  border-radius: 15px;
  background-clip: padding-box;
  margin: 180px auto;
  width: 350px;
  padding: 35px 35px 15px 35px;
  background: #20a0ff;
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
  padding: 2px;
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
