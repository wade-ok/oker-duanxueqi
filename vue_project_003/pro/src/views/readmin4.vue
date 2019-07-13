<template>
  <el-card class="bod-card">
    <!-- 面包屑 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: 'readmin1' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>待检查项目列表</el-breadcrumb-item>
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
      <el-table-column prop="rname" label="发包方" width="100" align="center"></el-table-column>
      <el-table-column prop="proname" label="项目名称" align="center" width="150"></el-table-column> 
      <el-table-column prop="pstarttime" label="开始时间" width="180" align="center"></el-table-column>
      <el-table-column prop="expecttime" label="期望完成时间" width="180" align="center"></el-table-column>
      <el-table-column prop="pfactdays" label="实际人天" width="150" align="center"></el-table-column>
      <el-table-column prop="pexpectdays" label="预计人天" width="150" align="center"></el-table-column>
      <el-table-column prop="devnumbers" label="开发人数" width="150" align="center"></el-table-column>
      <el-table-column prop="pstate" label="状态" width="150" align="center"></el-table-column>
      <el-table-column prop="address" label="开发详情"  fixed="right" align="center">
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
      <el-table-column prop="address" label="发起验收"  fixed="right" align="center">
        <template slot-scope="scope">
            <el-button
              size="mini"
              plain
              type="success"
              icon="el-icon-check"
              @click="check(scope.row)"
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
    <el-dialog title="任 务 分 配" :visible.sync="dialogFormVisibleEdit">
      <el-table class="table1"
    :header-cell-style="{'text-align':'center'}"
    :data="leaveList1" 
    style="width: 100%"
    height="400">
      <el-table-column
      fixed 
      type="index" 
      label="序号" 
      align="center"
      width="30"></el-table-column>
      <!-- <el-table-column prop="pid" label="项目ID" align="center" ></el-table-column> -->
      <el-table-column prop="taskname" label="任务名称" width="130" align="center"></el-table-column> 
      <el-table-column prop="username" label="开发人员" align="center"></el-table-column>
       <el-table-column prop="starttime" label="开始时间" width="155" align="center"></el-table-column>
       <el-table-column prop="endtime" label="结束时间"  width="155" align="center"></el-table-column>
       <el-table-column prop="factdays" label="实际人天" align="center"></el-table-column>
      <el-table-column prop="expectdays" label="预计人天" align="center"></el-table-column>
      <el-table-column prop="tstate" label="状态" align="center"></el-table-column>
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

      <div slot="footer" class="dialog-footer" align="center"> 
        <!-- <el-button type="primary" @click="editLeave()">完 成</el-button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <el-button type="primary" @click="editLeave()">继 续</el-button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
        <el-button  type="primary" @click="dialogFormVisibleEdit = false" >返 回</el-button>
        
      </div>
    </el-dialog>
        <el-dialog
          width="30%"
          title="提示"
          :visible.sync="centerDialogVisible"
          center
          append-to-body>
          <span style="width:100%;text-align:center;display:block;">请上传最终项目工程后点击确定发起验收</span>
          <br><br><br>
          <el-form ref="form" :model="form" label-width="80px">  
          <el-form-item label="">
                <el-col :span="6"> &nbsp; </el-col>
              <el-col :span="11"> 
                <el-upload
                  :on-success="handleFileUploaded"
                  class="upload-demo"
                  action='http://localhost:8081/filemanages/uploadfile'
                  :on-preview="handlePreview"
                  :on-remove="handleRemove"
                  :before-remove="beforeRemove"
                  multiple
                  :limit="3"
                  :on-exceed="handleExceed"
                  :file-list="fileList">
                  <el-button size="medium" type="primary">上传最终项目工程</el-button>
                  <!-- <div slot="tip" class="el-upload__tip">只能上传jpg/png文件，且不超过500kb</div> -->
              </el-upload>
            </el-col>
          </el-form-item>
      </el-form>
      <br><br>
          <span slot="footer" class="dialog-footer">
             <el-button type="primary" @click="startacceptance(form)">确 定</el-button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <el-button @click="centerDialogVisible = false">取 消</el-button>
          </span>
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
      leaveList1:[1],
      total: 20,
      centerDialogVisible:false,
      dialogFormVisibleEdit:false,
      form: {
      },
      fileList: [
          ],
    };
  },
  created() {
    this.getLeaveList();
  },
  methods: {
      handleFileUploaded(response,file, fileList){
        this.form.finalpro = response
        console.log(response);
      },
      handleRemove(response,file, fileList) {
        console.log(file, fileList);
      },
      handlePreview(file) {
        console.log(file.name);
      },
      handleExceed(files, fileList) {
        this.$message.warning(`当前限制选择 3 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`);
      },
      beforeRemove(file, fileList) {
        return this.$confirm(`确定移除 ${ file.name }？`);
      },

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

      //审核请假单 打开视图
      showEditLeaveDia(val){
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
                this.leaveList1=data
                this.dialogFormVisibleEdit = true
                //this.form.id=leaveList.id
                // this.$message.success(msg)//提示成功
              }else{                   
                  this.$message.error({              
                    message: msg,
                    center: true
                    });//否则提示失败
              }
          })
      },
      check(val){
        this.form = val
        this.centerDialogVisible = true
      },

      startacceptance(form){
        this.$http.post('http://localhost:8081/projects/ctartcheckprojects',this.form)
        .then((res)=>{
            console.log(res)
            const {
                code,
                msg,
                data
            } =res.data
            if(code === 200){
              this.$message.success({              //提示成功
                      message: msg,
                      center: true
                      });
                    this.centerDialogVisible = false
                    this.getLeaveList()
            }else{                   
                this.$message.error({              
                      message: msg,
                      center: true
                      });//否则提示失败
                      this.centerDialogVisible = false
            }
          })
      },

    //搜索功能
    async searchLeave() {
    this.$http.get(`http://localhost:8081/projects/getreProthreeList/${this.query}`)
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
      this.$http.post('http://localhost:8081/projects/waitchecks')
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
              this.$message.error({              
                    message: msg,
                    center: true
                    });//否则提示失败
          }
      })
    },
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
