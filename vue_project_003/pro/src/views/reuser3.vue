<template>
  <el-card class="bod-card">
    <!-- 面包屑 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: 'reuser1' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>需要开发任务目列表</el-breadcrumb-item>
    </el-breadcrumb>
    <!-- 搜索 -->
    <!-- <el-row class="searchRow">
      <el-col  align="left">
        <el-input 
          @clear="loadLeaveList()"
          clearable
          placeholder="输入任务名（支持模糊查询）"
          v-model="query"
          class="inputSearch">
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
      <el-table-column prop="rname" label="管理员" width="180" align="center"></el-table-column>
      <el-table-column prop="proname" label="项目名称" align="center" width="180"></el-table-column> 
      <el-table-column prop="taskname" label="任务名称" align="center" width="200"></el-table-column> 
      <el-table-column prop="starttime" label="开始时间" width="200" align="center"></el-table-column>
      <el-table-column prop="expectdays" label="预计人天" width="180" align="center"></el-table-column>
      <el-table-column prop="tstate" label="状态" width="180" align="center"></el-table-column>
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
      <el-table-column prop="address" label="任务详情"  fixed="right" align="center">
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
      <el-table-column prop="address" label="完成任务"  fixed="right" align="center">
        <template slot-scope="scope">
            <el-button
              size="mini"
              plain
              type="success"
              icon="el-icon-check"
              @click="showEditLeaveDia1(scope.row)"
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
    <el-dialog title="任 务 详 情" :visible.sync="dialogFormVisibleEdit">
      <el-form :model="form">

        <el-form-item  label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp;项&nbsp; 目&nbsp; 名&nbsp; 称 ： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.proname" autocomplete="off" placeholder="项目名称"></el-input>
            </el-col>
        </el-row>
        </el-form-item> 
        <el-form-item label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3"> 任&nbsp; 务&nbsp; 名&nbsp; 称 ： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.taskname" autocomplete="off" placeholder="任务名称"></el-input>
            </el-col>

            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp; 任 务 状 态 ： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.tstate"  autocomplete="off" placeholder="任务状态"> </el-input>
            </el-col>

            
        </el-row>
        </el-form-item>

        <el-form-item  label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp;开&nbsp; 始&nbsp; 时&nbsp; 间 ： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.starttime"  autocomplete="off" placeholder="任务开始时间"> </el-input>
            </el-col>
            
            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="3">   &nbsp; 预 计 人 天 ：</el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.expectdays" autocomplete="off" placeholder="预计人天"></el-input>
            </el-col>
        </el-row>
        </el-form-item>

        <el-form-item  label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3"> 管&nbsp;&nbsp;&nbsp;&nbsp;理&nbsp;&nbsp;&nbsp;&nbsp;员 ： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.rname" autocomplete="off" placeholder="项目管理员"></el-input>
            </el-col>
            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp; 开 发 人 员 ： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.username"  autocomplete="off" placeholder="开发人员"> </el-input>
            </el-col>
        </el-row>
        </el-form-item>

          <el-form-item label="" label-width="100px">
               <el-col :span="0"> &nbsp; </el-col>
                <el-col :span="3"> &nbsp;任&nbsp; 务&nbsp; 说&nbsp; 明 ： </el-col>
                <el-col :span="18"> 
                    <el-input
                    type="textarea"
                    :rows="2"
                    disabled
                    autocomplete="off"
                    placeholder="任务说明"
                    v-model="form.taskexplain">
                    </el-input>
                </el-col>
        </el-form-item>
      </el-form>

      <div slot="footer" class="dialog-footer" align="center"> 
        <!-- <el-button type="primary" @click="editLeave()">完 成</el-button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <el-button type="primary" @click="editLeave()">继 续</el-button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
        <el-button  type="primary" @click="dialogFormVisibleEdit = false" >返 回</el-button>
        
      </div>
    </el-dialog>

    <el-dialog title="完 成 任 务" :visible.sync="dialogFormVisibleEdit1">
      <el-form :model="form">

        <el-form-item  label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp;项&nbsp; 目&nbsp; 名&nbsp; 称 ： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.proname" autocomplete="off" placeholder="项目名称"></el-input>
            </el-col>
            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp; 项 目 状 态 ： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.tstate"  autocomplete="off" placeholder="任务状态"> </el-input>
            </el-col>
        </el-row>
        </el-form-item> 
        <el-form-item label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3"> 任&nbsp; 务&nbsp; 名&nbsp; 称 ： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.taskname" autocomplete="off" placeholder="任务名称"></el-input>
            </el-col>

            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp; 预 计 人 天 ： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.expectdays"  autocomplete="off" placeholder="预计人天"> </el-input>
            </el-col>
        </el-row>
        </el-form-item>

        <el-form-item  label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3"> 管&nbsp;&nbsp;&nbsp;&nbsp;理&nbsp;&nbsp;&nbsp;&nbsp;员 ： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.rname" autocomplete="off" placeholder="项目管理员"></el-input>
            </el-col>
            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp; 开 发 人 员 ： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.username"  autocomplete="off" placeholder="开发人员"> </el-input>
            </el-col>
        </el-row>
        </el-form-item>

        <el-form-item  label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp;开&nbsp; 始&nbsp; 时&nbsp;间  ： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.starttime" autocomplete="off" placeholder="开始时间"></el-input>
            </el-col>

            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp;完 成 时 间 ： </el-col>
            <el-col :span="3"> 
                <el-date-picker size="medium"
            style="width:240px"
            v-model="form.endtime" 
            type="datetime" 
            value-format="yyyy-MM-dd HH:mm:ss"
            format="yyyy-MM-dd HH:mm:ss"
            placeholder="选择日期时间"></el-date-picker>
          </el-col>
        </el-row>
        </el-form-item>

          <el-form-item label="" label-width="100px">
            <!-- <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp;任&nbsp; 务&nbsp; 上&nbsp;传  ： </el-col>
            <el-col :span="7"> 
                <el-input  v-model="form.taskupload" autocomplete="off" placeholder="任务上传"></el-input>
            </el-col> -->
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
                  <el-button size="small" type="primary">上传任务工程</el-button>
                  <!-- <div slot="tip" class="el-upload__tip">只能上传jpg/png文件，且不超过500kb</div> -->
              </el-upload>
            </el-col>
        </el-form-item>
      </el-form>

      <div slot="footer" class="dialog-footer" align="center"> 
        <el-button type="primary" @click="Submission()">完 成</el-button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <!-- <el-button type="primary" @click="editLeave()">继 续</el-button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
        <el-button  type="primary" @click="dialogFormVisibleEdit1 = false" >返 回</el-button>
        
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
      dialogFormVisibleEdit1:false,
      fileList: [
          ],
      form: {
        peonam:'',
        pstate:'',
        taskname:'',
        expectdays:'',
        rname:'',
        username:'',
        starttime:'',
        endtime:'',
        taskupload:'',
      }
    };
  },
  created() {
    this.getLeaveList();
  },
  methods: {
      handleFileUploaded(response,file, fileList){
        this.form.taskupload = response
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
      //审核请假单 打开视图
      showEditLeaveDia(projects){
          this.form = projects
          this.dialogFormVisibleEdit = true
      },
      showEditLeaveDia1(projects){
          this.form = projects
          this.dialogFormVisibleEdit1 = true
      },

      Submission(){
        this.$http.post('http://localhost:8081/tasks/finishtasks',this.form)
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
              this.dialogFormVisibleEdit1 = false
              this.getLeaveList()
            }else{                   
             this.$message.error({          //否则提示失败
                  message: msg,
                  center: true
                  });
             }
          })
      },
    
      //下载
      download(val){
        this.$http.get(`http://localhost:8081/filemanages/downloadfile/${val.taskdocument}`)
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
      this.$http.post('http://localhost:8081/tasks/developingtasks')
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
              this.$message.error({          //否则提示失败
                  message: msg,
                  center: true
                  });
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
