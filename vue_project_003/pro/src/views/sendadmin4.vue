<template>
  <el-card class="bod-card">
    <!-- 面包屑 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: 'sendadmin1' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>待接项目列表</el-breadcrumb-item>
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
      <el-table-column prop="proname" label="项目名称" align="center" width="400"></el-table-column> 
      <el-table-column prop="expecttime" label="期望完成时间" width="300" align="center"></el-table-column>
      <el-table-column prop="pstate" label="状态" width="300" align="center"></el-table-column>
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
    <el-dialog title="待 承 包 项 目" :visible.sync="dialogFormVisibleEdit">
      <el-form :model="form">

        <el-form-item  label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp;项&nbsp; 目&nbsp; 名&nbsp; 称 ： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.proname" autocomplete="off" placeholder="项目名称"></el-input>
            </el-col>

            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="3"> 创&nbsp; 建&nbsp; 人： </el-col>
            <el-col :span="7"> 
                <el-input  disabled v-model="form.name" autocomplete="off" placeholder="创 建 人"></el-input>
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
      <div slot="footer" class="dialog-footer" align="center"> 
        <el-button type="primary" @click="withdrawproject()">撤 回</el-button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
      dialogFormVisibleEdit:false,
      form: {
        proname:'',
        pid:'',
        name:'',
        expecttime:'',
        prodocument:'',
        proexplain:'',
        pstate:''
      }
    };
  },
  created() {
    this.getLeaveList();
  },
  methods: {
      //审核请假单 打开视图
      showEditLeaveDia(projects){
          this.dialogFormVisibleEdit = true
          this.$http.post('http://localhost:8081/users/getname')
            .then((res)=>{
                console.log(res)
                const {
                    code,
                    msg,
                    data
                } =res.data
                if(code === 200){
                  this.form = projects
                  this.form.name=data  
                  // console.log(data)
                }else{                   
                    this.$message.error({
                        message: msg,
                        center: true
                    })//否则提示失败
                }
            })
      },
      //撤回已发布的项目
      withdrawproject(){
        this.$http.post('http://localhost:8081/projects/withdrawprojects',this.form)
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
                    })
                    this.dialogFormVisibleEdit = false
                    this.getLeaveList()
                }else{                   
                    this.$message.error({
                        message: msg,
                        center: true
                    })//否则提示失败
                }
            })
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

    //搜索功能
    async searchLeave() {
    this.$http.get(`http://localhost:8081/projects/getProtwoList/${this.query}`)
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
      this.$http.post('http://localhost:8081/projects/waitreceiveprojects')
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
