<template>
  <el-card class="bod-card">
    <!-- 面包屑 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: 'reuser1' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>已完成任务列表</el-breadcrumb-item>
    </el-breadcrumb>
    <!-- 搜索 -->
    <!-- <el-row class="searchRow">
      <el-col  align="left">
        <el-input 
          @clear="loadLeaveList()"
          clearable
          placeholder="输入任务名称（支持模糊查询）"
          v-model="query"
          class="inputSearch"
        >
        </el-input>
        <el-button type="primary" @click="showAddLeaveDia()" icon="el-icon-search">搜索</el-button>
      </el-col>
    </el-row> -->
    <!-- 表格 -->
    <el-table class="table1"
    :header-cell-style="{'text-align':'center'}"
    :data="leaveList" 
    style="width: 95%"
    height="400">
      <el-table-column
      fixed 
      type="index" 
      label="序号" 
      align="center"
      width="100"></el-table-column>
      <!-- <el-table-column prop="pid" label="项目ID" align="center" ></el-table-column> -->
      <el-table-column prop="rname" label="管理员" width="150" align="center"></el-table-column>
      <el-table-column prop="proname" label="项目名称" align="center" width="160"></el-table-column> 
      <el-table-column prop="taskname" label="任务名称" align="center" width="160"></el-table-column> 
      <el-table-column prop="starttime" label="开始时间" width="180" align="center"></el-table-column>
      <el-table-column prop="endtime" label="结束时间" width="180" align="center"></el-table-column>
      <el-table-column prop="expectdays" label="预计人天" width="150" align="center"></el-table-column>
      <el-table-column prop="factdays" label="实际人天" width="150" align="center"></el-table-column>
      <el-table-column prop="tstate" label="状态" width="120" align="center"></el-table-column>
      <el-table-column prop="address" label="下载"  fixed="right" align="center">
        <template slot-scope="scope">
            <el-button
              size="mini"
              plain
              type="primary"
              icon="el-icon-download"
              @click="download(scope.row)"
              circle
            ></el-button>
        </template>
      </el-table-column>
    </el-table>
    <!-- 分页 -->
    <el-pagination
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      :current-page="pagenum"
      :page-sizes="[2, 4, 6, 8]"
      :page-size="6"
      layout="total, sizes, prev, pager, next, jumper"
      :total="total"
    ></el-pagination>
  </el-card>
</template>


<script>
export default {
  data() {
    return {
      query: "",
      total: 20,
      pagenum: 1,
      pagesize: 2,
      leaveList: [1],
      total: 20,
      form: {

      }
    };
  },
  created() {
    this.getLeaveList();
  },
  methods: {
    //下载
    download(val){
        this.$http.get(`http://localhost:8081/filemanages/downloadfile/${val.taskupload}`)
          .then((res)=>{
            console.log(res)
            const {
                code,
                msg,
                data
            } =res.data
            if(code === 200){
              this.$message.success({
                    message: msg,
                    center: true
                    });//提示成功
            }else{                   
                // this.$message.error({
                //     message: msg,
                //     center: true
                //     });//否则提示失败
            }
        }).catch(e=>{
                this.$message.error({
                    message: "请求发送失败",
                    center: true
                    });//否则提示失败
        })  
      },

    // //分页方法
    handleSizeChange(val) {
      console.log(`每页 ${val} 条`);
      (this.pagesize = val), this.getUserList();
    },
    handleCurrentChange(val) {
      console.log(`当前页: ${val}`);
      (this.pagenum = val), this.getUserList();
    },
    //获取请假数据
    async getLeaveList() {
      this.$http.post('http://localhost:8081/tasks/finishtasklist')
      .then((res)=>{
          console.log(res)
          const {
              code,
              msg,
              data
          } =res.data
          if(code === 200){
            this.leaveList=data
            //this.form.id=leaveList.id
            // this.$message.success(msg)//提示成功
          }else{                   
              this.$message.error(msg)//否则提示失败
          }
      })
    }
  }
};
</script>

<style>
.bod-card {
  height: 100%;
}
.searchRow {
  margin-top: 30px;
}
.inputSearch {
  width: 300px;
}
.table1{
    color: #008acd
    
}
</style>
