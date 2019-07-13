<template>
  <el-container class="container">
    <el-header class="header">
      <el-row>
        <el-col :span="18" :offset="4" class="middle">
          <h2>请 假 审 核 系 统</h2>
        </el-col>
        <el-col :span="2">
          <div >
             <el-button 
             class="loginout"
              @click.prevent="handleSignout" 
              size="small"
              type="info" plain style="color:#000000;">退 出</el-button>
            <!-- <a class="loginout" @click.prevent="handleSignout" href="#">退出</a> -->
          </div>
        </el-col>
      </el-row>
    </el-header>
    <el-container :style="height">
      <el-aside class="aside" width="200px">
          <!-- router:true 开启路由模式 -->
        <el-menu 
        :router="true">

          <el-submenu index="">
            <template slot="title">
              <i class="el-icon-position"></i>
              <span style="font-weight: bold;">申请请假</span>
            </template>
            <el-menu-item index="admin2">
              <i class="el-icon-user-solid"></i>
              <span>开始请假</span>
            </el-menu-item>
          </el-submenu>

          <el-submenu index="2">
            <template slot="title">
              <i class="el-icon-folder-opened"></i>
              <span style="font-weight: bold;">查看记录</span>
            </template>
            <el-menu-item index="admin5">
              <i class="el-icon-delete"></i>
              <span>删除记录</span>
            </el-menu-item>
            <el-menu-item index="admin3">
              <i class="el-icon-loading"></i>
              <span>待审记录</span>
            </el-menu-item>
            <el-menu-item index="admin4">
              <i class="el-icon-edit"></i>
              <span>已审记录</span>
            </el-menu-item>
          </el-submenu>
          
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
  //       //获取token
  //       const token = localStorage.getItem("token")
        
  //       if(!token){
  //           //不存在返回login
  //           this.$router.push({name:'Login'})

  //       }
  //       //存在继续渲染   
  //   },

    
  methods:{
        handleSignout(){
            //清楚token
            localStorage.clear()
            //提示
            this.$message.success('退出成功')
            //返回login
            this.$router.push({name:'Login'})
        },
    }
}
</script>

<style>
.container {
  height: 100%;
}
.header {
  background-color: #abf2f5;
}
.aside {
  background-color: #d3dce6;
}
.main {
  background-color: #e9eef3;
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


