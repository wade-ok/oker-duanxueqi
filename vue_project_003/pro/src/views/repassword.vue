<template>
  <el-container class="container">
    <el-header class="header">
      <el-row>
        <el-col :span="18" :offset="4" class="middle" >
          <h2 >发 包 方 项 目 管 理</h2>
        </el-col>
        <el-col :span="2">
          <div >
             <el-button 
             class="loginout"
              @click.prevent="handleSignout()" 
              size="small"
              type="info" plain style="color:#000000;">退 出</el-button>
            <!-- <a class="loginout" @click.prevent="handleSignout" href="#">退出</a> -->
          </div>
        </el-col>
      </el-row>
    </el-header>
    <el-container  :style="height">
      <el-aside class="aside" width="200px">
          <!-- router:true 开启路由模式 -->
        <el-menu 
        :router="true"
        default-active="2"
      class="el-menu-vertical-demo"
      @open="handleOpen"
      @close="handleClose"
      background-color="#d4e8ff"
      text-color="#07090a"
      active-text-color="#ffd04b">

      <!-- <el-menu-item index="public">
            <i class="el-icon-sunny"></i>
            <span>项目发布网</span>
      </el-menu-item> -->

            <el-menu-item >
              <i class="el-icon-sunny"></i>
              <el-link href="http://localhost:8080/public#/public" target="_blank"><span style="color:#000000;">项目发布网</span></el-link>
            </el-menu-item>

      <el-menu-item index="user3">
            <i class="el-icon-circle-plus-outline"></i>
            <span>创 建 项 目</span>
      </el-menu-item>

      <el-menu-item index="user4">
            <i class="el-icon-question"></i>
            <span>未&nbsp;&nbsp;&nbsp;发&nbsp;&nbsp;&nbsp;布</span>
      </el-menu-item>

      <el-menu-item index="user5">
            <i class="el-icon-loading"></i>
            <span>待&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;接</span>
      </el-menu-item>

      <el-menu-item index="user6">
            <i class="el-icon-view"></i>
            <span>验 收 项 目</span>
      </el-menu-item>

      <el-menu-item index="user7">
            <i class="el-icon-circle-check"></i>
            <span>已&nbsp;&nbsp;&nbsp;&nbsp;验&nbsp;&nbsp;&nbsp;收</span>
      </el-menu-item>

          <!-- <el-submenu index="">
            <template slot="title">
              <i class="el-icon-position"></i>
              <span style="font-weight: bold;">申请请假</span>
            </template>
            <el-menu-item index="user2">
              <i class="el-icon-user-solid"></i>
              <span>开始请假</span>
            </el-menu-item>
          </el-submenu>

          <el-submenu index="2">
            <template slot="title">
              <i class="el-icon-folder-opened"></i>
              <span style="font-weight: bold;">查看记录</span>
            </template>
            <el-menu-item index="user3">
              <i class="el-icon-loading"></i>
              <span>待审记录</span>
            </el-menu-item>
            <el-menu-item index="user4">
              <i class="el-icon-edit"></i>
              <span>已审记录</span>
            </el-menu-item>
          </el-submenu> -->
        </el-menu>
      </el-aside>
      <el-main class="main">
        <router-view></router-view>
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
export default {
  data () {
    return {
      height: {
        height: window.innerHeight - 240 + 'px'
      }
    }
  },

    // beforeCreate(){
    //     //获取token
    //     const token = localStorage.getItem("token")
        
    //     if(!token){
    //         //不存在返回login
    //         this.$router.push({name:'Login'})

    //     }
    //     //存在继续渲染
        
    // },


    methods:{
        handleSignout(){
            //清楚token
            localStorage.clear()
            //提示
            this.$message.success('退出成功')
            //返回login
            this.$router.push({name:'Login'})
        },
        handleOpen(key, keyPath) {
        console.log(key, keyPath);
      },
      handleClose(key, keyPath) {
        console.log(key, keyPath);
      },
      show(){
        this.$router.push({name:'public'})
      }
    }
}
</script>

<style>
.container {
  height: 100%;
}
.header {
  background-color: #aed6ff;
}
.aside {
  background-color: #d4e8ff;
}
.main {
  background-color: #e0effd;
  height: 100%;
}
.middle {
  text-align: center;
}
.loginout {
  line-height: 40px;
  text-decoration: none;
  float: right;
}
</style>


