<template>
<el-card>
  <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: 'admin1' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>申请请假</el-breadcrumb-item>
      <el-breadcrumb-item>开始请假</el-breadcrumb-item>
    </el-breadcrumb>
      <el-form ref="form" :model="form" label-width="80px">    
      <el-form-item label="">
          <el-col :span="14" :offset="4" class="middle">
            <h2>请假单</h2>
          </el-col>
      </el-form-item>
    <el-form-item label="">
        <el-row>
            <el-col :span="4"> &nbsp; </el-col>
            <el-col :span="2"> &nbsp;用户姓名： </el-col>
            <el-col :span="4"> 
                <el-input v-model="form.username" disabled placeholder="用户姓名"> </el-input>
            </el-col>

            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="2"> &nbsp;用户 I D： </el-col>
            <el-col :span="4"> 
                <el-input v-model="form.id" disabled placeholder="用户ID"> </el-input>
            </el-col>
        </el-row>
    </el-form-item>

    <el-form-item label="">
      <el-row>
        <el-col :span="4"> &nbsp; </el-col>
            <el-col :span="2"> &nbsp;开始时间： </el-col>
            <el-col :span="2"> 
                <el-date-picker size="medium"
            v-model="form.start_time" 
            type="datetime" 
            value-format="yyyy-MM-dd HH:mm:ss"
            format="yyyy-MM-dd HH:mm:ss"
            placeholder="选择日期时间"></el-date-picker>
          </el-col>
            <el-col :span="3"> &nbsp; </el-col>
            <el-col :span="2"> &nbsp;结束时间： </el-col>
            <el-col :span="2"> 
                <el-date-picker 
            v-model="form.end_time" 
            type="datetime"
            value-format="yyyy-MM-dd HH:mm:ss"
            format="yyyy-MM-dd HH:mm:ss" 
            placeholder="选择日期时间"></el-date-picker>
          </el-col>
      </el-row>
    </el-form-item>

    <el-form-item label="">
        <el-row>
            <el-col :span="4"> &nbsp; </el-col>
            <el-col :span="2"> &nbsp;请假类型：</el-col>
            <el-col :span="3">  
              <el-select v-model="form.kind" placeholder="请选择">
                  <el-option
                  v-for="item in form.options"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
                  </el-option>
              </el-select>
            </el-col>
            <el-col :span="2"> &nbsp; </el-col>
            <el-col :span="2"> &nbsp;请假天数： </el-col>
            <el-col :span="3"> 
                <el-input v-model="form.days" disabled placeholder="请假天数"> </el-input>
          </el-col>
        </el-row>
    </el-form-item>

    <el-form-item label="">
      <el-row>
          <el-col :span="4"> &nbsp; </el-col>
          <el-col :span="2"> &nbsp;请假理由： </el-col>
          <el-col :span="11"> 
              <el-input
              type="textarea"
              :rows="3"
              placeholder="请输入请假理由"
              v-model="form.reason">
              </el-input>
          </el-col>
      </el-row>
    </el-form-item>
    <el-form-item label="">
      <el-row>
          <el-col :span="8"> &nbsp; </el-col>
          <el-col :span="2"> 
              <el-button @click.prevent="Startleave()" type="primary" round>确认</el-button>
          </el-col>
          <el-col :span="2"> &nbsp; </el-col>
          <el-col :span="2"> 
              <el-button @click.prevent="cancel()" type="info" round>取消</el-button>
          </el-col>
      </el-row>
    </el-form-item>
  </el-form>
</el-card>
</template>

<script>
  export default {
    data() {
      return {
        form: {
          username: '',
          id: '',
          days:'',
          reason:'',  
          start_time:'',
          end_time:'',
          options: [{
          value: '事假',
          label: '事假'
        }, {
          value: '病假',
          label: '病假'
        }, {
          value: '年休',
          label: '年休'
        }, {
          value: '产假',
          label: '产假'
        }, {
          value: '丧假',
          label: '丧假'
        }, {
          value: '护理假',
          label: '护理假'
        }, {
          value: '其他',
          label: '其他'
        }],
        kind:''
        }
      }
    },
        created()
    {
        this.getid()
        this.getname()
        // this.Startleave()
        // this.getLeaveList();
    },
    
    methods: {
      onSubmit() {
        console.log('submit!');
      },
      Startleave()
      {
        //  this.$router.push({path:'/user1'})//登陆成功跳转首页   
        this.$http.post('http://localhost:8081/leaves/apply',this.form)
        .then((res)=>{
            console.log(res)
            const {
                code,
                msg
            } =res.data
            if(code === 200){ 
              //提示成功
              this.$message.success(msg);
               // //更新视图
              // this.getUserList();
              // 清空文本框
              this.$router.push({path:'/admin5'})
            }else{                   
                this.$message.warning(msg);
            }
        })
      },
      cancel(){
        this.$router.push({path:'/admin1'})
      },
      getid()
      {
        this.$http.post('http://localhost:8081/users/getid')
        .then((res)=>{
            console.log(res)
            const {
                code,
                msg,
                data
            } =res.data
            if(code === 200){ 
              console.log(data)                   
                this.form.id=data                                   
                  // this.$message.success(msg)//提示成功

            }else{                   
                this.$message.error(msg)//否则提示失败
            }
        })
      },
      getname()
      {
        this.$http.post('http://localhost:8081/users/getname')
        .then((res)=>{
            console.log(res)
            const {
                code,
                msg,
                data
            } =res.data
            if(code === 200){ 
              console.log(data)                   
                this.form.username=data                                   
                  this.$message.success(msg)//提示成功

            }else{                   
                this.$message.error(msg)//否则提示失败
            }
        })
      },
    }
  }
</script>