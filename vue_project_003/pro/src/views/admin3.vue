<template>
  <el-card class="bod-card">
    <!-- 面包屑 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: 'admin1' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>查看记录</el-breadcrumb-item>
      <el-breadcrumb-item>待审记录</el-breadcrumb-item>
    </el-breadcrumb>
    <!-- 搜索 -->
    <el-form 
      :model="form">
      <el-row class="searchRow">
        <el-col  align="left">
          <el-input 
            @clear="loadLeaveList()"
            clearable
            placeholder="请输入姓名查询（可模糊查询）"
            v-model="query"
            class="inputSearch"
          >
          <!-- <el-button  type="primary" @click="searchLeave()" slot="append" icon="el-icon-search">搜索</el-button> -->
          </el-input>
          <el-button type="primary" @click="searchLeave()" icon="el-icon-search">搜索</el-button>
        </el-col>
      </el-row>
    </el-form>
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
      <el-table-column prop="lid" label="请假单ID" align="center" ></el-table-column>
      <el-table-column prop="id" label="请假人ID" align="center" ></el-table-column>
      <el-table-column prop="username" label="请假人" align="center"></el-table-column> 
      <el-table-column prop="start_time" label="开始时间" width="180" align="center"></el-table-column>
      <el-table-column prop="end_time" label="结束时间" width="180" align="center"></el-table-column>
      <!-- <el-table-column prop="offreason" label="请假理由"></el-table-column> -->
      <el-table-column prop="days" label="请假天数" align="center"></el-table-column>
      <el-table-column prop="kind" label="请假类型" align="center"></el-table-column>
      <el-table-column prop="state" label="审核状态" align="center"></el-table-column>
      <!-- <el-table-column prop="approver" label="审批人"></el-table-column>
      <el-table-column prop="comments" label="批语" ></el-table-column> -->
      <el-table-column prop="address" label="审核"  fixed="right" align="center">
        <template slot-scope="scope">
          <el-row>
            <el-button
              size="mini"
              plain
              type="primary"
              icon="el-icon-edit"
              @click="showEditLeaveDia(scope.row)"
              circle
            ></el-button>
          </el-row>
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
    <el-dialog title="待审请假单" :visible.sync="dialogFormVisibleEdit">
      <el-form :model="form">
        <el-form-item  label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp;请假人： </el-col>
            <el-col :span="7"> 
                <el-input disabled v-model="form.username" autocomplete="off" placeholder="请假人姓名"></el-input>
            </el-col>

            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp; I D： </el-col>
            <el-col :span="7"> 
                <el-input v-model="form.id" disabled autocomplete="off" placeholder="请假人ID"> </el-input>
            </el-col>
        </el-row>
        </el-form-item>

        <el-form-item label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp;开始时间： </el-col>
            <el-col :span="7"> 
                <el-input  disabled v-model="form.start_time" autocomplete="off" placeholder="请假开始时间"></el-input>
            </el-col>

            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp; 结束时间： </el-col>
            <el-col :span="7"> 
                <el-input  disabled v-model="form.end_time" autocomplete="off" placeholder="请假结束时间"></el-input>
            </el-col>
        </el-row>
        </el-form-item>

        <el-form-item label="" label-width="100px">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp;请假类型： </el-col>
            <el-col :span="7"> 
                <el-input  disabled v-model="form.kind" autocomplete="off"  placeholder="请假类型"></el-input>
            </el-col>

            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp; 请假天数： </el-col>
            <el-col :span="7"> 
                <el-input   disabled v-model="form.days" autocomplete="off" placeholder="请假天数"></el-input>
            </el-col>
        </el-row>
        </el-form-item>
          <el-form-item label="" label-width="100px">
               <el-col :span="0"> &nbsp; </el-col>
                <el-col :span="3"> &nbsp;请假理由： </el-col>
                <el-col :span="18"> 
                    <el-input
                    type="textarea"
                    :rows="2"
                    disabled
                    autocomplete="off"
                    placeholder="请假理由"
                    v-model="form.reason">
                    </el-input>
                </el-col>
        </el-form-item>
          <el-form-item label="" label-width="100px">
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp; 审核： </el-col>
            <el-col :span="7"> 
              <el-select v-model="form.state" placeholder="请选择活动区域">
              <el-option label="同意" value="同意"></el-option>
              <el-option label="不同意" value="不同意"></el-option>
            </el-select>
            </el-col>
             <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp; 请假单ID： </el-col>
            <el-col :span="7"> 
                <el-input   disabled v-model="form.lid" autocomplete="off" placeholder="请假单ID"></el-input>
            </el-col>
        </el-form-item>
        <el-form-item label="" label-width="100px">
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="3"> &nbsp; 批语： </el-col>
            <el-col :span="18"> 
                <el-input
                type="textarea"
                :rows="1"
                autocomplete="off"
                placeholder="批语"
                v-model="form.remark">
                </el-input>
            </el-col>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer" align="center"> 
        <el-button type="primary" @click="Startcheck()">确 定</el-button> &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;
        <el-button  type="info" @click="dialogFormVisibleEdit = false" >取 消</el-button>
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
      leaveList: [],
      total: 20,
      // dialogFormVisibleAdd: false,
      dialogFormVisibleEdit:false,
      form: {
        lid:"",
        id: "",
        username: "",
        start_time: "",
        end_time: "",
        days: "",
        kind: "",
        reason:"",
        remark:"",
        state:''
      }
    }
  },

  created() {
    this.getLeaveList();
  },
  
  methods: {
      //审核请假单 打开视图
      showEditLeaveDia(Leave){
          this.form = Leave
          this.dialogFormVisibleEdit = true
      },
     //审核请假单 发送请求
    Startcheck()
      {
        //  this.$router.push({path:'/user1'})//登陆成功跳转首页   
        this.$http.put('http://localhost:8081/leaves/startcheck',this.form)
        .then((res)=>{
            console.log(res)
            const {
                code,
                msg
            } =res.data
            if(code === 200){ 
              this.$router.push({path:'test'})
              //提示成功
              this.$message.success(msg);
              this.dialogFormVisibleEdit = false
            }else{                   
                this.$message.warning(msg);
            }
        })
      },

    async searchLeave() {
    this.$http.get(`http://localhost:8081/leaves/findbynamestartstate/${this.query}`)
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
          this.$message.success(msg)//提示成功
        }else{
          this.$message.error(msg)//否则提示失败
        }
    }).catch(e=>{
      this.$message.warning("搜索信息不能为空")
      this.$router.push({path:'test'})
    })
  },

    // //搜索请假消息
    // async searchLeave() {
    //   const res = await this.$http.get('http://localhost:8080/leaves/findbyendstate/${this.query}');
    //   //console.log(res.data)
    //   const { msg, code, data } = res.data;
    //   if (code === 200) {
    //     //给表格数据赋值
    //     this.leaveList = data;
    //     //提示
    //     this.$message.success(msg);
    //     this.pagenum = 1;
    //   } else {
    //     //失败提示
    //     this.$message.warning(msg);
    //   }
    // },

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
      this.$http.get('http://localhost:8081/leaves/start')
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
