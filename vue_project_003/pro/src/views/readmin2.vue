<template>
  <el-card class="bod-card">
    <!-- 面包屑 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: 'readmin1' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>待开发项目列表</el-breadcrumb-item>
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
      <el-table-column prop="proname" label="项目名称" align="center" width="200"></el-table-column> 
      <el-table-column prop="pstarttime" label="项目开始时间" width="260" align="center"></el-table-column>
      <el-table-column prop="expecttime" label="期望完成时间" width="260" align="center"></el-table-column>
      <el-table-column prop="sendname" label="发包方" width="260" align="center"></el-table-column>
      <el-table-column prop="address" label="任务分配"  fixed="right" align="center">
        <template slot-scope="scope">
            <el-button
              size="mini"
              plain
              type="primary"
              icon="el-icon-scissors"
              @click="showEditLeaveDia(scope.row)"
              circle
            ></el-button>
        </template>
      </el-table-column>
      <el-table-column prop="address" label="分配完成"  fixed="right" align="center">
        <template slot-scope="scope">
            <el-button
              size="mini"
              plain
              type="success"
              icon="el-icon-check"
              @click="finish(scope.row)"
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
      <el-form :model="form">

        <el-form-item  label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp;项&nbsp; 目&nbsp; 名&nbsp; 称： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.proname" autocomplete="off" placeholder="项目名称"></el-input>
            </el-col>

            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="3"> 项目状态： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.pstate"  autocomplete="off" placeholder="项目状态"> </el-input>
            </el-col>
        </el-row>
        </el-form-item>
        
        <el-col :span="24"> &nbsp; 创 建 任 务 </el-col>
        <br><br>
        
        <el-form-item label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3"> 任&nbsp; 务&nbsp; 名&nbsp; 称： </el-col>
            <el-col :span="7"> 
                <el-input v-model="form.taskname" autocomplete="off" placeholder="任务名称"></el-input>
            </el-col>
        </el-row>
        </el-form-item>

        <el-form-item  label="" label-width="100px">
            <el-row>
            <!-- <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3">&nbsp;任&nbsp; 务&nbsp; 文&nbsp; 档 ： </el-col>
            <el-col :span="7"> 
                <el-input v-model="form.taskdocument"  autocomplete="off" placeholder="上传任务文档"> </el-input>
            </el-col> -->
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3"> 开&nbsp; 始&nbsp; 时&nbsp; 间： </el-col>
            <el-col :span="3"> 
                <el-date-picker size="medium"
            style="width:240px"
            v-model="form.starttime" 
            type="datetime" 
            value-format="yyyy-MM-dd HH:mm:ss"
            format="yyyy-MM-dd HH:mm:ss"
            placeholder="选择开始时间"></el-date-picker>
          </el-col>

            <el-col :span="5"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp;截 止 时 间： </el-col>
            <el-col :span="3"> 
                <el-date-picker size="medium"
            style="width:240px"
            v-model="form.texpecttime" 
            type="datetime" 
            value-format="yyyy-MM-dd HH:mm:ss"
            format="yyyy-MM-dd HH:mm:ss"
            placeholder="选择任务期望完成时间"></el-date-picker>
          </el-col>
        </el-row>
        </el-form-item>

        <el-form-item label="" label-width="100px">
            <el-col :span="0"> &nbsp; </el-col>
              <el-col :span="3"> &nbsp;任&nbsp; 务&nbsp; 说&nbsp; 明： </el-col>
              <el-col :span="18"> 
                  <el-input
                  type="textarea"
                  :rows="2"
                  autocomplete="off"
                  placeholder="任务说明"
                  v-model="form.taskexplain">
                  </el-input>
              </el-col>
        </el-form-item>

        <el-form-item label="" label-width="100px">
            <el-col :span="5"> &nbsp; </el-col>
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
                  <el-button size="small" type="primary">上传项目需求文档</el-button>
                  <!-- <div slot="tip" class="el-upload__tip">只能上传jpg/png文件，且不超过500kb</div> -->
              </el-upload>
            </el-col>
        </el-form-item>

        <el-col :span="24"> &nbsp; 设 置 开 发 人 员 </el-col>
        <br><br>
        
        <el-form-item label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3"> 用&nbsp;&nbsp; &nbsp;户&nbsp; &nbsp; &nbsp;名： </el-col>
            <el-col :span="7"> 
                <el-input v-model="form.username" autocomplete="off" placeholder="设置用户名"></el-input>
            </el-col>

            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp; 密&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;  码 ： </el-col>
            <el-col :span="7"> 
                <el-input v-model="form.upassword"  autocomplete="off" placeholder="设置密码"> </el-input>
            </el-col>
        </el-row>
        </el-form-item>
      </el-form>

      <div slot="footer" class="dialog-footer" align="center"> 
        <!-- <el-button type="primary" @click="finish()">完 成</el-button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
        <el-button type="primary" @click="continues()">继 续</el-button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <el-button  type="primary" @click="cancel()" >返 回</el-button>
        
      </div>
    </el-dialog>

      <el-dialog
          width="30%"
          title="提示"
          :visible.sync="centerDialogVisible"
          center
          append-to-body>
          <span style="width:100%;text-align:center;display:block;">确定任务分配完毕吗？</span>
          <span slot="footer" class="dialog-footer">
             <el-button type="primary" @click="distribution(form)">确 定</el-button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
      total: 20,
      centerDialogVisible:false,
      dialogFormVisibleEdit:false,
      fileList: [
          ],
      form: {
        proname:'',
        pstate:'',
        taskname:'',
        startime:'',
        expectdays:'',
        taskdocument:'',
        taskexplain:'',
        username:'',
        upassword:'',
      }
    };
  },
  created() {
    this.getLeaveList();
  },
  methods: {
      handleFileUploaded(response,file, fileList){
        this.form.taskdocument = response
        console.log(response);
      },
      handleRemove(file, fileList) {
        console.log(file, fileList);
      },
      handlePreview(file) {
        console.log(file);
      },
      handleExceed(files, fileList) {
        this.$message.warning(`当前限制选择 3 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`);
      },
      beforeRemove(file, fileList) {
        return this.$confirm(`确定移除 ${ file.name }？`);
      },
      //分配任务
      showEditLeaveDia(projects){
          this.form = projects
          this.dialogFormVisibleEdit = true
      },

      finish(projects){
        this.form = projects
        this.centerDialogVisible = true
      },
      distribution(form){
        this.$http.post('http://localhost:8081/projects/projectstarts',this.form)
        .then((res)=>{
          const {
              code,
              msg,
              data
          } =res.data
          if(code === 200){
            
            // getLeaveList()
            this.$message.success({
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
        }).catch(e=>{
        this.$message.error({
                    message: "分配失败",
                    center: true
                    });
                this.centerDialogVisible = false
        }) 
      },

      continues(){
        this.$http.post('http://localhost:8081/tasks/createtasks',this.form)
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
                });
          }else{                   
              this.$message.error({
                    message: msg,
                    center: true
                    });//否则提示失败
          }
        })
      },

      cancel(){
        
        this.dialogFormVisibleEdit = false
        // this.form.taskname = {};
        // this.form.startime = {};
        // this.form.expectdays = {};
        // this.form.taskdocument = {};
        // this.form.taskexplain = {};
        // this.form.username = {};
        // this.form.upassword = {};
      },

    //搜索功能
    async searchLeave() {
    this.$http.get(`http://localhost:8081/projects/getreProoneList/${this.query}`)
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
      this.$http.post('http://localhost:8081/projects/waitdevprojects')
      .then((res)=>{
          console.log(res)
          const {
              code,
              msg,
              data
          } =res.data
          if(code === 200){
            this.leaveList=data
            // this.$message.success(msg)//提示成功
          }else{                   
              this.$message.error(msg)//否则提示失败
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
