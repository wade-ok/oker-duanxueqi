<template>
<el-row>
  <el-header>
    <h1>项 目 外 包 信 息 发 布 网</h1>
  </el-header>
  <el-col :span="2"><div class="grid-content bg-purple-light"></div></el-col>

  <el-col :span="10"><div class="grid-content bg-purple">
    <el-main >
      <el-card>
        <!-- 面包屑 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item >
        <span style="font-weight: bold;">待承接项目列表</span>
        </el-breadcrumb-item>
      <el-breadcrumb-item></el-breadcrumb-item>
    </el-breadcrumb>
    <br>
    <!-- 搜索 -->
    <!-- <el-row class="searchRow">
      <el-col  align="left" :span="12">
        <el-input 
          @clear="loadLeaveList()"
          clearable
          placeholder="输入项目名称（支持模糊查询）"
          v-model="query"
          class="inputSearch"
        >
        </el-input>
        <el-button type="primary" @click="showAddLeaveDia()"  icon="el-icon-search">搜 索</el-button>
      </el-col>
    </el-row> -->

    <!-- 待承包项目包-->
    <el-table class="table1"
    :header-cell-style="{'text-align':'center'}"
    :data="leaveList1" 
    style="width: 100%"
    height="616">
      <el-table-column
      fixed 
      type="index" 
      label="序号" 
      align="center"
      width="50"></el-table-column>
      <el-table-column prop="proname" label="项目名称" align="center" ></el-table-column>
      <el-table-column prop="expecttime" label="期望时间" width="100" align="center"></el-table-column> 
      <el-table-column prop="sendname" label="发出方" align="center"></el-table-column>
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
      <el-table-column prop="address" label="承包"  fixed="right" align="center">
        <template slot-scope="scope">
            <el-button
              size="mini"
              plain
              type="danger"
              icon="el-icon-check"
              @click="contracted(scope.row)"
              circle
            ></el-button>
        </template>
      </el-table-column>
    </el-table>
    </el-card>
    </el-main>
    </div></el-col>

  <el-col :span="10"><div class="grid-content bg-purple">
    <el-main>
    <el-card>
     <!-- 面包屑 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item >
        <span style="font-weight: bold;">已承接项目列表</span>
        </el-breadcrumb-item>
      <el-breadcrumb-item></el-breadcrumb-item>
    </el-breadcrumb>
    <!-- 已承接项目包-->
      <el-table class="table2"
    :header-cell-style="{'text-align':'center'}"
    :data="leaveList2" 
    style="width: 100%"
    height="260">
      <el-table-column
      fixed 
      type="index" 
      label="序号" 
      align="center"
      width="100"></el-table-column>
      <el-table-column prop="proname" label="项目名称" align="center" ></el-table-column>
      <el-table-column prop="sendname" label="发出方" align="center"></el-table-column>
      <el-table-column prop="rname" label="承包方" align="center"></el-table-column>
      <el-table-column prop="address" label="查看"  fixed="right" align="center">
        <template slot-scope="scope">
            <el-button
              size="mini"
              plain
              type="success"
              icon="el-icon-view"
              @click="showEditLeaveDia1(scope.row)"
              circle
            ></el-button>
        </template>
      </el-table-column>
    </el-table>
    </el-card>
    </el-main>

    <el-main>
    <el-card>
      <!-- 面包屑 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item >
        <span style="font-weight: bold;">已完成项目列表</span>
        </el-breadcrumb-item>
      <el-breadcrumb-item></el-breadcrumb-item>
    </el-breadcrumb>
    <!-- 完成项目包-->
      <el-table class="table3"
    :header-cell-style="{'text-align':'center'}"
    :data="leaveList3" 
    style="width: 100%"
    height="260">
      <el-table-column
      fixed 
      type="index" 
      label="序号" 
      align="center"
      width="100"></el-table-column>
      <el-table-column prop="proname" label="项目名称" align="center" ></el-table-column>
      <el-table-column prop="sendname" label="发出方" align="center"></el-table-column>
      <el-table-column prop="rname" label="承包方" align="center"></el-table-column>
      <el-table-column prop="address" label="查看"  fixed="right" align="center">
        <template slot-scope="scope">
            <el-button
              size="mini"
              plain
              type="warning"
              icon="el-icon-view"
              @click="showEditLeaveDia2(scope.row)"
              circle
            ></el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 查看待审请假单 -->
    <el-dialog title="待 承 包 项 目" :visible.sync="dialogFormVisibleEdit">
      <el-form 
      :v-model="form">
        <el-form-item  label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="4"> &nbsp;项&nbsp; 目&nbsp; 名&nbsp; 称 ： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.proname" autocomplete="off" placeholder="项目名称"></el-input>
            </el-col>

            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp;项&nbsp; 目&nbsp; 状&nbsp; 态 ： </el-col>
            <el-col :span="7"> 
                <el-input  disabled v-model="form.pstate" autocomplete="off" placeholder="项目状态"></el-input>
            </el-col>
        </el-row>
        </el-form-item>

        <el-form-item label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="4"> &nbsp;期望完成时间： </el-col>
            <el-col :span="7"> 
                <el-input  disabled v-model="form.expecttime" autocomplete="off" placeholder="期望完成时间"></el-input>
            </el-col>

            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="3"> 发&nbsp;&nbsp;&nbsp;布&nbsp;&nbsp;&nbsp;人&nbsp; ： </el-col>
            <el-col :span="7"> 
                <el-input  disabled v-model="form.sendname" autocomplete="off" placeholder="发 布 方"></el-input>
            </el-col>
        </el-row>
        </el-form-item>

        <el-form-item label="" label-width="100px">
            <!-- <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="4"> &nbsp;项目需求文档： </el-col>
            <el-col :span="18"> 
                <el-input  disabled v-model="form.prodocument" autocomplete="off"  placeholder="项目需求文档"></el-input>
            </el-col>
        </el-row> -->
        </el-form-item>
          <el-form-item label="" label-width="100px">
               <el-col :span="0"> &nbsp; </el-col>
                <el-col :span="4"> &nbsp;项&nbsp; 目&nbsp; 说&nbsp; 明 ： </el-col>
                <el-col :span="18"> 
                    <el-input
                    type="textarea"
                    :rows="2"
                    disabled
                    autocomplete="off"
                    placeholder="项目说明"
                    v-model="form.proexplain">
                    </el-input>
                </el-col>
        </el-form-item>
      </el-form>

        <!-- <el-dialog
          width="30%"
          title="提示"
          :visible.sync="centerDialogVisible"
          center
          append-to-body>
          <span style="width:100%;text-align:center;display:block;">确定要承包该项目吗？</span>
          <span slot="footer" class="dialog-footer">
             <el-button type="primary" @click="definecontract(form)">确 定</el-button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <el-button @click="centerDialogVisible = false">取 消</el-button>
          </span>
        </el-dialog> -->

      <div slot="footer" class="dialog-footer" align="center"> 
        <!-- <el-button type="primary" @click="showDetermine()" >接 受</el-button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
        <el-button  type="primary" @click="dialogFormVisibleEdit = false" >返 回</el-button>
      </div>
    </el-dialog>

    <el-dialog
          width="30%"
          title="提示"
          :visible.sync="centerDialogVisible"
          center
          append-to-body>
          <span style="width:100%;text-align:center;display:block;">确定要承包该项目吗？</span>
          <span slot="footer" class="dialog-footer">
             <el-button type="primary" @click="contract(form)">确 定</el-button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <el-button @click="centerDialogVisible = false">取 消</el-button>
          </span>
        </el-dialog>

    <!-- 审核请假单的对话框 -->
    <el-dialog title="开 发 中 项 目" :visible.sync="dialogFormVisibleEdit1">
      <el-form :model="form">

        <el-form-item  label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp;项&nbsp; 目&nbsp; 名&nbsp; 称 ： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.proname" autocomplete="off" placeholder="项目名称"></el-input>
            </el-col>

            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp;项&nbsp; 目&nbsp; 状&nbsp; 态： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.pstate"  autocomplete="off" placeholder="项目状态"> </el-input>
            </el-col>
        </el-row>
        </el-form-item>

        <el-form-item  label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3"> 发&nbsp;&nbsp;&nbsp;&nbsp; 包&nbsp;&nbsp;&nbsp; 方 ： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.sendname" autocomplete="off" placeholder="发包方"></el-input>
            </el-col>

            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="3"> 承&nbsp;&nbsp;&nbsp;&nbsp; 包&nbsp;&nbsp;&nbsp; 方： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.rname"  autocomplete="off" placeholder="承包方"> </el-input>
            </el-col>
        </el-row>
        </el-form-item>

        <el-form-item label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3">项目开始时间： </el-col>
            <el-col :span="7"> 
                <el-input  disabled v-model="form.pstarttime" autocomplete="off" placeholder="期望完成时间"></el-input>
            </el-col>

            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="3">期望完成时间： </el-col>
            <el-col :span="7"> 
                <el-input  disabled v-model="form.expecttime" autocomplete="off" placeholder="期望完成时间"></el-input>
            </el-col>
        </el-row>
        
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer" align="center"> 
        <!-- <el-button type="primary" @click="editLeave()">撤 回</el-button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
        <el-button  type="primary" @click="dialogFormVisibleEdit1 = false" >返 回</el-button>
      </div>
    </el-dialog>

    <!-- 审核请假单的对话框 -->
    <el-dialog title="开 发 中 项 目" :visible.sync="dialogFormVisibleEdit2">
      <el-form :model="form">

        <el-form-item  label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp;项&nbsp; 目&nbsp; 名&nbsp; 称 ： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.proname" autocomplete="off" placeholder="项目名称"></el-input>
            </el-col>

            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp;项&nbsp; 目&nbsp; 状&nbsp; 态： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.pstate"  autocomplete="off" placeholder="项目状态"> </el-input>
            </el-col>
        </el-row>
        </el-form-item>

        <el-form-item  label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3"> 发&nbsp;&nbsp;&nbsp;&nbsp; 包&nbsp;&nbsp;&nbsp; 方 ： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.name" autocomplete="off" placeholder="发包方"></el-input>
            </el-col>

            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="3"> 承&nbsp;&nbsp;&nbsp;&nbsp; 包&nbsp;&nbsp;&nbsp; 方： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.num"  autocomplete="off" placeholder="承包方"> </el-input>
            </el-col>
        </el-row>
        </el-form-item>

        <el-form-item label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp;预&nbsp; 计&nbsp; 人&nbsp; 天： </el-col>
            <el-col :span="7"> 
                <el-input  disabled v-model="form.pexpectdays" autocomplete="off" placeholder="预计人天"></el-input>
            </el-col>

            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="3">&nbsp;实&nbsp; 际&nbsp; 人&nbsp; 天： </el-col>
            <el-col :span="7"> 
                <el-input  disabled v-model="form.pfactdays" autocomplete="off" placeholder="实际人天"></el-input>
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
            <el-col :span="3"> 实际完成时间： </el-col>
            <el-col :span="7"> 
                <el-input  disabled v-model="form.pendtime" autocomplete="off" placeholder="实际完成时间"></el-input>
            </el-col>
        </el-row>
        </el-form-item>

        <el-form-item label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3">期望完成时间： </el-col>
            <el-col :span="7"> 
                <el-input  disabled v-model="form.expecttime" autocomplete="off" placeholder="期望完成时间"></el-input>
            </el-col>

            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="3">&nbsp;开&nbsp; 发&nbsp; 人&nbsp; 数： </el-col>
            <el-col :span="7"> 
                <el-input  disabled v-model="form.devnumbers" autocomplete="off" placeholder="开发人数"></el-input>
            </el-col>
        </el-row>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer" align="center"> 
        <!-- <el-button type="primary" @click="editLeave()">撤 回</el-button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
        <el-button  type="primary" @click="dialogFormVisibleEdit2 = false" >返 回</el-button>
      </div>
    </el-dialog>

    </el-card>
    </el-main>
    </div></el-col>
  <el-col :span="2"><div class="grid-content bg-purple-light"></div></el-col>
</el-row>




</template>

<script>
import { Script } from 'vm';
export default {
  data() {
    return {
      query: "",
      total: 20,
      pagenum: 1,
      pagesize: 2,
      leaveList1: [1],
      leaveList2: [1],
      leaveList3: [1],
      total: 20,
      centerDialogVisible:false,
      dialogFormVisibleEdit:false,
      dialogFormVisibleEdit1:false,
      dialogFormVisibleEdit2:false,
      form: {
        proname:'',
        pstate:'',
        expecttime:'',
        sendname:'',
        prodocument:'',
        proexplain:'',
      }
    };
  },
  created() {
    this.getLeaveList1();
    this.getLeaveList2();
    this.getLeaveList3();
  },

  methods:{
     rowClass() {
      return 'background: #fff;color: #909399;font-weight: 600;border-right: 1px solid #ebeef5'
    },
    cellStyle() {
      return 'border-right: 1px solid #ebeef5'
    },
    showEditLeaveDia(projects){
          this.form = projects
          this.dialogFormVisibleEdit = true
      },
      showEditLeaveDia1(projects){
          this.form = projects
          this.dialogFormVisibleEdit1 = true

      },
      showEditLeaveDia2(projects){
          this.form = projects
          this.dialogFormVisibleEdit2 = true
      },

      // 承包项目
      contracted(projects){
          // this.dialogFormVisibleEdit = false
          this.form = projects
          this.centerDialogVisible = true
          // this.definecontract(val)
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
      contract(form){
          // console.log(val.pid)
          this.$http.get(`http://localhost:8081/projects/receiveprojects/${form.pid}`)
          .then((res)=>{
            console.log(res)
            const {
                code,
                msg,
                data
            } =res.data
            if(code === 200){
              this.getLeaveList1()
              this.$message.success({
                    message: msg,
                    center: true
                    });//提示成功
                    this.centerDialogVisible = false
            }else{                   
                this.$message.error({
                    message: msg,
                    center: true
                    });//否则提示失败
                this.centerDialogVisible = false
            }
        }).catch(e=>{
          this.$message.warning("发布失败")
        })  
      },

    // 待承包项目列表
    async getLeaveList1() {
      this.$http.post('http://localhost:8081/projects/pubwaitreceiveprojects')
      .then((res)=>{
          console.log(res)
          const {
              code,
              msg,
              data
          } =res.data
          if(code === 200){
            this.leaveList1=data
          }else{                   
              this.$message.error(msg)//否则提示失败
          }
      })
    },
    // 待承包项目列表
    async getLeaveList2() {
      this.$http.post('http://localhost:8081/projects/pubdevprojects')
      .then((res)=>{
          console.log(res)
          const {
              code,
              msg,
              data
          } =res.data
          if(code === 200){
            this.leaveList2=data
          }else{                   
              this.$message.error(msg)//否则提示失败
          }
      })
    },
    // 待承包项目列表
    async getLeaveList3() {
      this.$http.post('http://localhost:8081/projects/pubendprojects')
      .then((res)=>{
          console.log(res)
          const {
              code,
              msg,
              data
          } =res.data
          if(code === 200){
            this.leaveList3=data
          }else{                   
              this.$message.error(msg)//否则提示失败
          }
      })
    },
  }
}
</Script>

<style>
  .el-row {
    margin-bottom: 20px;  
    /* &:last-child {   grid-main
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
    background: #edf4fd;
  }
  .bg-purple-light {
    background: #e8f2ff;
  }
  .grid-content {
    border-radius: 4px;
    min-height: 750px;
  }
  .row-bg {
    padding: 10px 0;
    background-color: #f9fafc;
  }
  .el-header {
    background-color: rgb(197, 222, 255);
    color: #333;
    text-align: center;
    line-height: 60px;
  }

  .el-main {
    background-color: #edf4fd;
    color: #333;
    text-align: center;
    line-height: 33px;
  }
 
</style>
