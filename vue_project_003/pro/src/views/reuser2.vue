<template>
  <el-card class="bod-card">
    <!-- 面包屑 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: 'reuser1' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>需要开发项目列表</el-breadcrumb-item>
    </el-breadcrumb>
    <!-- 搜索 -->
    <!-- <el-row class="searchRow">
      <el-col  align="left">
        <el-input 
          @clear="loadLeaveList()"
          clearable
          placeholder="输入项目名（支持模糊查询）"
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
      <el-table-column prop="proname" label="项目名称" align="center" width="400"></el-table-column> 
      <el-table-column prop="rname" label="管理员" align="center"></el-table-column>
      <el-table-column prop="expecttime" label="期望完成时间" width="300" align="center"></el-table-column>
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
  
    <!-- 审核请假单的对话框 -->
    <el-dialog title="开 发 中 项 目" :visible.sync="dialogFormVisibleEdit">
      <el-form :model="form">

        <el-form-item  label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp;项&nbsp; 目&nbsp; 名&nbsp; 称 ： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.proname" autocomplete="off" placeholder="项目名称"></el-input>
            </el-col>

            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="3"> 项&nbsp; 目&nbsp; 状&nbsp; 态： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.pstate"  autocomplete="off" placeholder="项目状态"> </el-input>
            </el-col>
        </el-row>
        </el-form-item>

        <el-form-item  label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3"> 管&nbsp;&nbsp;&nbsp;&nbsp; 理&nbsp;&nbsp;&nbsp; 员 ： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.rname" autocomplete="off" placeholder="管理员"></el-input>
            </el-col>

            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="3"> 开&nbsp; 发&nbsp; 人&nbsp; 数： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.devnumbers"  autocomplete="off" placeholder="开发人数"> </el-input>
            </el-col>
        </el-row>
        </el-form-item>

        <el-form-item label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3">项目开始时间： </el-col>
            <el-col :span="7"> 
                <el-input  disabled v-model="form.pstarttime" autocomplete="off" placeholder="项目开始时间"></el-input>
            </el-col>

            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="3"> 期望完成时间： </el-col>
            <el-col :span="7"> 
                <el-input  disabled v-model="form.expecttime" autocomplete="off" placeholder="期望完成时间"></el-input>
            </el-col>
        </el-row>
        </el-form-item>

        <el-form-item label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3">&nbsp;预&nbsp; 计&nbsp; 人&nbsp; 天 ： </el-col>
            <el-col :span="7"> 
                <el-input  disabled v-model="form.pexpectdays" autocomplete="off" placeholder="项目开始时间"></el-input>
            </el-col>

            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="3"> 实&nbsp; 际&nbsp; 人&nbsp; 天： </el-col>
            <el-col :span="7"> 
                <el-input  disabled v-model="form.pfactdays" autocomplete="off" placeholder="期望完成时间"></el-input> 
            </el-col>
        </el-row>
        </el-form-item>

        <el-form-item label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3">开 发 任 务 数： </el-col>
            <el-col :span="7"> 
                <el-input  disabled v-model="form.devnumbers" autocomplete="off" placeholder="开发任务书"></el-input>
            </el-col>

            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="3"> 已完成任务数： </el-col>
            <el-col :span="7"> 
                <el-input  disabled v-model="form.comnumbers" autocomplete="off" placeholder="已完成任务数"></el-input>
            </el-col>
        </el-row>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer" align="center"> 
        <!-- <el-button type="primary" @click="editLeave()">撤 回</el-button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
        <el-button  type="primary" @click="dialogFormVisibleEdit = false" >返 回</el-button>
        
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
      showEditLeaveDia(projects){
          this.form = projects
          this.dialogFormVisibleEdit = true
      },
 
    //下载
    download(val){
        this.$http.get(`http://localhost:8081/filemanages/downloadfile/${val.prodocument}`)
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
      this.$http.post('http://localhost:8081/projects/userprojectlist')
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
