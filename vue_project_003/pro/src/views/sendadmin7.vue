<template>
  <el-card class="bod-card">
    <!-- 面包屑 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: 'sendadmin1' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>已验收项目列表</el-breadcrumb-item>
    </el-breadcrumb>
    <!-- 搜索 -->
    <el-row class="searchRow">
      <el-col  align="left">
        <el-input 
          @clear="loadLeaveList()"
          clearable
          placeholder="输入项目名称（支持模糊查询）"
          v-model="query"
          class="inputSearch"
        >
        <!-- <el-button  type="primary" @click="searchLeave()" slot="append" icon="el-icon-search">搜索</el-button> -->
        </el-input>
        <el-button type="primary" @click="searchLeave()" icon="el-icon-search">搜索</el-button>
      </el-col>
    </el-row>
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
      <el-table-column prop="proname" label="项目名称" align="center"></el-table-column> 
      <el-table-column prop="rname" label="承包方" align="center"></el-table-column>
      <el-table-column prop="pstarttime" label="项目开始时间"  width="180" align="center"></el-table-column>
      <el-table-column prop="pendtime" label="项目完成时间"  width="180" align="center"></el-table-column>
      <el-table-column prop="expecttime" label="期望完成时间" width="180" align="center"></el-table-column>
      <el-table-column prop="pexpectdays" label="预计人天" align="center"></el-table-column>
      <el-table-column prop="pfactdays" label="实际人天" align="center"></el-table-column>
      <el-table-column prop="devnumbers" label="开发人数" align="center"></el-table-column>
      <el-table-column prop="pstate" label="状态" align="center"></el-table-column>
      <!-- <el-table-column prop="pstate" label="下载" align="center"></el-table-column> -->
      
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
    <el-table-column prop="address" label="查看"  fixed="right" align="center">
        <template slot-scope="scope">
            <el-button
              size="mini"
              plain
              type="primary"
              icon="el-icon-view"
              @click="showEditLeaveDia(scope.row)"
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
  
    <!-- 审核请假单的对话框 -->
    <el-dialog title="开 发 人 员 列 表" :visible.sync="dialogFormVisibleEdit" width="60%">
      <el-table class="table1"
    :header-cell-style="{'text-align':'center'}"
    :data="taskList" 
    style="width: 95%"
    height="400">
      <el-table-column
      fixed 
      type="index" 
      label="序号" 
      align="center"
      width="50"></el-table-column>
      <!-- <el-table-column prop="pid" label="项目ID" align="center" ></el-table-column> -->
      <el-table-column prop="taskname" label="任务名称" align="center"></el-table-column> 
      <el-table-column prop="rname" label="承包方" align="center"></el-table-column>
      <el-table-column prop="username" label="开发人" align="center"></el-table-column>
       <el-table-column prop="starttime" label="开始时间" width="180" align="center"></el-table-column>
       <el-table-column prop="endtime" label="结束时间" width="180" align="center"></el-table-column>
      <el-table-column prop="expectdays" label="预计人天" align="center"></el-table-column>
      <el-table-column prop="factdays" label="实际人天" align="center"></el-table-column>
    </el-table>
      <div slot="footer" class="dialog-footer" align="center"> 
        <el-button  type="primary" @click="dialogFormVisibleEdit = false" >返回</el-button>
        
      </div>
    </el-dialog>
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
      dialogFormVisibleAdd: false,
      dialogFormVisibleEdit:false,
      form: {
      }
    };
  },
  created() {
    this.getLeaveList();
  },
  methods: {
      //审核请假单 打开视图
      showEditLeaveDia(val){
          // this.form = Leave
          // this.dialogFormVisibleEdit = true
          this.$http.get(`http://localhost:8081/tasks/devpersonlist/${val.pid}`)
          .then((res)=>{
              console.log(res)
              const {
                  code,
                  msg,
                  data
              } =res.data
              if(code === 200){
                this.taskList = data
                this.dialogFormVisibleEdit = true
                //this.form.id=leaveList.id
                // this.$message.success(msg)//提示成功
              }else{                   
                  this.$message.error(msg)//否则提示失败
              }
          })
      },

    //下载
    download(val){
        this.$http.get(`http://localhost:8081/filemanages/downloadfile/${val.finalpro}`)
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

    //搜索功能
    async searchLeave() {
    this.$http.get(`http://localhost:8081/projects/getProfiveList/${this.query}`)
    .then((res)=>{
        console.log(res)
        const {
            code,
            msg,
            data
        } =res.data
        if(code === 200){
          this.leaveList = data
        }else{
          this.$message.error({
                    message: msg,
                    center: true
                    });
        }
    }).catch(e=>{
      // this.$message.error({
      //               message: "",
      //               center: true
      //               });
      this.getLeaveList()
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
      this.$http.post('http://localhost:8081/projects/alreadycheckprojects')
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
