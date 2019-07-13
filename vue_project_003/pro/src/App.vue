<template>
  <div id="app">

    <div id="nav">

      <!-- <router-link to="/login">Login</router-link>|
      <router-link to="/user1">user1</router-link>|
      <router-link to="/user2">user2</router-link>|
      <router-link to="/user3">user3</router-link>|
      <router-link to="/user4">user4</router-link>|
      <router-link to="/admin1">admin1</router-link>|
      <router-link to="/admin2">admin2</router-link>|
      <router-link to="/admin3">admin3</router-link>|
      <router-link to="/T">T</router-link>|
      <router-link to="/reuser1">reuser1</router-link>|
      <router-link to="/public">public</router-link>|
      <router-link to="/readmin1">readmin1</router-link>|
      <router-link to="/sendadmin1">sendadmin1</router-link>| -->

    </div>
    <router-view/>
  </div>
</template>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>

<style>
  .el-row {
    margin-bottom: 20px;
    /* &:last-child {
      margin-bottom: 0;
    } */
  }
  .el-col {
    border-radius: 4px;
  }
  .bg-purple-dark {
    background: #99a9bf;
  }
  .bg-purple {
    background: #d3dce6;
  }
  .bg-purple-light {
    background: #e5e9f2;
  }
  .grid-content {
    border-radius: 4px;
    min-height: 36px;
  }
  .row-bg {
    padding: 10px 0;
    background-color: #f9fafc;
  }
</style>