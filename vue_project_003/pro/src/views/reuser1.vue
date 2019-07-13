<template>
  <el-container class="container">
    <el-header class="header">
      <el-row>
        <el-col :span="18" :offset="4" class="middle" >
          <h2 >开 发 人 员 项 目 管 理</h2>
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
      background-color="#edecff"
      text-color="#07090a"
      active-text-color="#ffd04b">

            <!-- <el-menu-item >
              <i class="el-icon-sunny"></i>
              <el-link href="http://localhost:8080/public#/public" target="_blank"><span style="color:#000000;">项目发布网</span></el-link>
            </el-menu-item> -->

      <el-menu-item index="reuser2">
            <i class="el-icon-folder-opened"></i>
            <span>开 发 项 目</span>
      </el-menu-item>

      <el-menu-item index="reuser3">
            <i class="el-icon-loading"></i>
            <span>开 发 任 务</span>
      </el-menu-item>

      <el-menu-item index="reuser4">
            <i class="el-icon-check"></i>
            <span>开  发 完 成</span>
      </el-menu-item>
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
            this.$message.success({              
                    message: "退出成功",
                    center: true
                    });
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
  background-color: #cccbfc;
}
.aside {
  background-color: #edecff;
}
.main {
  background-color: #f1f0ff;
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


