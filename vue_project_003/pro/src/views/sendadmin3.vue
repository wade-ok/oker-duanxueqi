<template>
  <el-card class="bod-card">
    <!-- 面包屑 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: 'sendadmin1' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>未发布项目列表</el-breadcrumb-item>
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
      <el-table-column prop="proname" label="项目名称" align="center" width="300"></el-table-column> 
      <el-table-column prop="expecttime" label="期望完成时间" width="400" align="center"></el-table-column>
      <el-table-column prop="address" label="修改"  fixed="right" align="center" width="200">
        <template slot-scope="scope">
            <el-button
              size="mini"
              plain
              type="primary"
              icon="el-icon-edit"
              @click="showEditLeaveDia(scope.row)"
              circle
            ></el-button>
        </template>
      </el-table-column>
      <el-table-column prop="address" label="下载"  fixed="right" align="center" width="200">
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
      <el-table-column prop="address" label="发布"  fixed="right" align="center" width="200">
        <template slot-scope="scope">
            <el-button
              size="mini"
              plain
              type="success"
              icon="el-icon-check"
              @click="publics(scope.row)"
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

    <!-- 未 发 布 项 目 -->
    <el-dialog title="未 发 布 项 目" :visible.sync="dialogFormVisibleEdit">
      <el-form 
      :v-model="form">
        <el-form-item  label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp;项&nbsp; 目&nbsp; 名&nbsp; 称 ： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.proname" autocomplete="off" placeholder="项目名称"></el-input>
            </el-col>
            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="3">创 &nbsp;建&nbsp; 人： </el-col>
            <el-col :span="7"> 
                <el-input  disabled v-model="form.sendname" autocomplete="off" placeholder="创建人"></el-input>
            </el-col>
        </el-row>
        </el-form-item>

        <el-form-item label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp;期望完成时间： </el-col>
            <el-col :span="7"> 
                <el-input  disabled v-model="form.expecttime" autocomplete="off" placeholder="期望完成时间"></el-input>
            </el-col>

            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="3"> 项目状态： </el-col>
            <el-col :span="7"> 
                <el-input  disabled v-model="form.pstate" autocomplete="off" placeholder="项目状态"></el-input>
            </el-col>
        </el-row>
        </el-form-item>

        <el-form-item label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp;项目需求文档： </el-col>
            <el-col :span="18"> 
                <el-input  disabled v-model="form.prodocument" autocomplete="off"  placeholder="项目需求文档"></el-input>
            </el-col>
        </el-row>
        </el-form-item>
          <el-form-item label="" label-width="100px">
               <el-col :span="0"> &nbsp; </el-col>
                <el-col :span="3"> &nbsp;项&nbsp; 目&nbsp; 说&nbsp; 明 ： </el-col>
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

        <el-dialog
          width="30%"
          title="提示"
          :visible.sync="centerDialogVisible"
          center
          append-to-body>
          <span style="width:100%;text-align:center;display:block;">确定要删除吗？</span>
          <span slot="footer" class="dialog-footer">
             <el-button type="primary" @click="deleteproject()">确 定</el-button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <el-button @click="centerDialogVisible = false">取 消</el-button>
          </span>
        </el-dialog>

      <div slot="footer" class="dialog-footer" align="center"> 
        <el-button type="primary" @click="showDetermine()" >删 除</el-button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <el-button  type="primary" @click="dialogFormVisibleEdit = false" >返 回</el-button>
      </div>

    </el-dialog>
  </el-card>
</template>


<script>
// import { truncate } from 'fs';
export default {
  data() {
    return {
      query: "",
      total: 20,
      pagenum: 1,
      pagesize: 2,
      leaveList: [],
      total: 20,
      // dialogFormVisibleAdd: false,
      centerDialogVisible:false,
      dialogFormVisibleEdit:false,
      form: {
        proname:'',
        pid:'',
        sendname:'',
        expecttime:'',
        prodocument:'',
        proexplain:'',
        pstate:''
      },
    };
  },

  created() {
    this.getLeaveList();
  },
  
  methods: {
      //项目详情 打开视图

      showEditLeaveDia(projects){
        this.form = projects
        this.dialogFormVisibleEdit = true
      },

      // showEditLeaveDia(projects){
      //   this.form = projects
      //     this.dialogFormVisibleEdit = true
      //     this.$http.post('http://localhost:8081/users/getname')
      //       .then((res)=>{
      //           console.log(res)
      //           const {
      //               code,
      //               msg,
      //               data
      //           } =res.data
      //           if(code === 200){
      //             this.form = projects
      //             this.form.name=data         //单独赋值                不能删我！！！！！！！！！！！！！！！！！！
      //           }else{                   
      //               this.$message.error({
      //                   message: msg,
      //                   center: true
      //               })//否则提示失败
      //           }
      //       }) 
      // },

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

      //发布项目
      publics(val){
          // this.dialogFormVisibleEdit = false
          console.log(val.pid)
          this.$http.get(`http://localhost:8081/projects/publishprojects/${val.pid}`)
        .then((res)=>{
            console.log(res)
            const {
                code,
                msg,
                data
            } =res.data
            if(code === 200){
              this.$message.success({    //提示成功
                    message: msg,
                    center: true
                    });
              this.getLeaveList()
            }else{                   
                this.$message.error({   //否则提示失败
                    message: msg,
                    center: true
                    });
            }
        }).catch(e=>{
        this.$message.error({   //否则提示失败
                    message: "发送请求失败",
                    center: true
                    });
        })   
      },
      showDetermine(){
          this.centerDialogVisible = true
      },
      

    //删除未发布项目 
     async deleteproject(){
       this.$http.post('http://localhost:8081/projects/deleteprojects',this.form)
        .then((res)=>{
            console.log(res)
            const {
                code,
                msg,
                data
            } =res.data
            if(code === 200){
              this.centerDialogVisible = false
              this.dialogFormVisibleEdit = false
              this.$message.success({
                    message: msg,
                    center: true
                    });
              this.getLeaveList()
            }else{                   
                this.$message.error({
                    message: msg,
                    center: true
                    });
                this.centerDialogVisible = false
                this.dialogFormVisibleEdit = false
            }
        })
      },

    //搜索功能
    async searchLeave() {
    this.$http.get(`http://localhost:8081/projects/getProoneList/${this.query}`)
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


    //分页方法
    handleSizeChange(val) {
      console.log(`每页 ${val} 条`);
      (this.pagesize = val), this.getUserList();
    },
    handleCurrentChange(val) {
      console.log(`当前页: ${val}`);
      (this.pagenum = val), this.getUserList();
    },

    // 未发布项目列表
    async getLeaveList() {
      this.$http.post('http://localhost:8081/projects/unpublishprojects')
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
