<template>
  <div class="login" :model="form">
      <el-row class="row1">
      </el-row>

    <el-row class="login_title">
    <el-col :span="7" :offset="13">
        
    <h1>&nbsp;&nbsp;项目外包信息系统</h1>
    </el-col>
    </el-row>

    <el-row class="row2" :gutter="10">
      
            <el-form  :model="form" status-icon ref="form" label-width="100px" class="demo-ruleForm">
        <el-form-item label="" prop="name" >
            <el-row>
                <!-- <el-col :span="1" :offset="14" > 用 户 名： </el-col> -->
                <el-col :span="4" :offset="14"> 
                    <el-input v-model="form.name" placeholder="请输入用户名" prefix-icon="el-icon-user" style="width:330px" ></el-input>
                </el-col>
            </el-row>
        </el-form-item>
            
        <el-form-item label="" prop="password" >
            <el-row>
                <!-- <el-col :span="1" :offset="14"> 密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码： </el-col> -->
                <el-col :span="4" :offset="14"> 
                    <el-input  v-model="form.password" placeholder="请 输 入 密 码" prefix-icon="el-icon-unlock" style="width:330px" show-password> </el-input>
                </el-col>
                <el-col :span="1" :offset="13"> &nbsp; </el-col>
                <el-col :span="1"> 
                    <el-link  @click.prevent="register('form1')" type="primary" >用 户 注 册</el-link>
                </el-col>
                <el-col :span="2">
                     &nbsp; 
                </el-col>
                <el-col :span="2"> 
                    <el-link @click.prevent="changepassword1('form2')" type="primary" >忘记密码？</el-link>
                </el-col>
            </el-row>
        </el-form-item>

        <el-form-item label="">
            <el-row>
                <el-col :span="1" :offset="13"> &nbsp;
                </el-col>
                <el-col :span="4"> 
                    <el-button @click.prevent ="handleLogin()"  type="primary" round> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        登&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;陆 
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</el-button>
                </el-col>
            </el-row>
        </el-form-item>
    </el-form>

    <!-- ------------------------------------用 户 注 册-------------------------------- -->
<el-dialog title="用 户 注 册 " :visible.sync="dialogFormVisibleEdit" width="35%">
      <el-form :model="form1" status-icon  ref="form1" label-width="100px" class="form1" >
        <el-form-item  label="" label-width="100px" prop="name">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="4"> 用&nbsp;&nbsp;户&nbsp;&nbsp;名： </el-col>
            <el-col :span="13"> 
                <el-input  v-model="form1.name" autocomplete="off" placeholder="请输入用户名"></el-input>
            </el-col>
        </el-row>
        </el-form-item>
        <el-form-item  label="" label-width="100px" prop="password" >
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="4"> 密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码： </el-col>
            <el-col :span="13"> 
                <el-input  v-model="form1.password"  autocomplete="off" placeholder="请输入密码" show-password> </el-input>
            </el-col>
        </el-row>
        </el-form-item>
        <el-form-item label="" label-width="100px" prop="repassword">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="4"> 确认密码： </el-col>
            <el-col :span="13"> 
                <el-input   v-model="form1.repassword" autocomplete="off" placeholder="请确认密码" show-password></el-input>
            </el-col>
        </el-row>
        </el-form-item>
        <el-form-item  label="" label-width="100px" prop="cardid">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="4"> 身份证号： </el-col>
            <el-col :span="13"> 
                <el-input  v-model="form1.cardid"  autocomplete="off" placeholder="请输入身份证号"> </el-input>
            </el-col>
        </el-row>
        </el-form-item>
        <el-form-item label="" label-width="100px" prop="role">
          <el-row>
          <el-col :span="0"> &nbsp; </el-col>
          <el-col :span="4"> 用户类型： </el-col>
          <el-col :span="9"> 
          <el-select v-model="form1.role" placeholder="请选择用户类型">
          <el-option label="发包方" value="sendadmin"></el-option>
          <el-option label="承包方" value="readmin"></el-option>
          </el-select>
          </el-col>
        </el-row>
        </el-form-item>
        <el-form-item label="" label-width="100px">
            <el-col :span="3"> &nbsp; </el-col>
            <el-col :span="5"> 
            <el-button type="primary" @click="submitForm('form1')" round>确 认</el-button>
            </el-col>

            <el-col :span="4"> &nbsp; </el-col>
            <el-col :span="5"> 
            <el-button  type="primary" @click="resetForm('form1')" round>返 回</el-button>
            </el-col>
        </el-form-item>
      </el-form>
    </el-dialog>
<!-- ------------------------------------身 份 认 证-------------------------------- -->
    <el-dialog title="身 份 认 证" :visible.sync="dialogFormVisiblea" width="35%">
      <br><br><br><br><br><br><br><br><br>
      <el-form :model="form2" status-icon ref="form2" label-width="100px" class="form2" >
        <el-form-item  label="" label-width="100px" prop="cardid">
            <el-row>
            <el-col :span="0"> &nbsp; </el-col>
            <el-col :span="4"> 身份证号： </el-col>
            <el-col :span="13"> 
                <el-input  v-model="form2.cardid"  autocomplete="off" placeholder="请输入身份证号"> </el-input>
            </el-col>
        </el-row>
        </el-form-item>
        <br><br><br><br><br><br><br>
        <el-form-item label="" label-width="100px">
            <el-col :span="7"> &nbsp; </el-col>
            <el-col :span="5"> 
            <el-button type="primary" @click="nextstep('form3')" round>下 一 步</el-button>
            </el-col>
        </el-form-item>
        <br><br>
      </el-form>
    </el-dialog>
     <!-- ------------------------------------重置密码-------------------------------- -->
     <el-dialog title="重 置 密 码" :visible.sync="dialogFormVisibleb" width="35%">
      <br><br><br><br><br>
      <el-form :model="form3" status-icon ref="form3" label-width="100px" class="form3" >
          <br><br>
        <el-form-item  label="" label-width="100px" prop="password">
            <el-row>
            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="4"> 重置密码： </el-col>
            <el-col :span="13"> 
                <el-input  v-model="form3.password"  autocomplete="off" placeholder="请输入新密码" show-password> </el-input>
            </el-col>
        </el-row>
        </el-form-item>
        <br><br>
        <el-form-item  label="" label-width="100px" prop="repassword">
            <el-row>
            <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="4"> 确认密码： </el-col>
            <el-col :span="13"> 
                <el-input  v-model="form3.repassword"  autocomplete="off" placeholder="请确认新密码" show-password> </el-input>
            </el-col>
        </el-row>
        </el-form-item>
        <br><br><br><br>
        <el-form-item label="" label-width="100px">
            <el-col :span="4"> &nbsp; </el-col>
            <el-col :span="5"> 
            <el-button type="primary" @click="confirm('form3')" round>确 认</el-button>
            </el-col>
            <el-col :span="4"> &nbsp; </el-col>
            <el-col :span="5"> 
            <el-button  type="primary" @click="cancel('form3')" round>取 消</el-button>
            </el-col>
        </el-form-item>
        <br>
      </el-form>
    </el-dialog>

    </el-row>
    <el-row class="row5">
    </el-row>
  </div>

</template>


<script>
export default {
 
   data(){
      return{
        form:{
                name:'',
                password:''
            },
        dialogFormVisibleEdit:false,
        dialogFormVisiblea:false,
        dialogFormVisibleb:false,
        form1: {
            name: '',
            password: '',
            repassword: '',
            cardid: '',
            role: '',
        },
        form2:{
            cardid: '',
        },
        form3:{
            password: '',
            repassword: '',
        }
      }
    },

    methods:{
        //登陆请求
        handleLogin() {
            this.$http.post('http://localhost:8081/users/login',this.form)
            .then((res)=>{
                console.log(res)
                const {
                    code,
                    msg,
                    data
                } =res.data
                if(code === 200){                    
                    localStorage.setItem('token',data) //保存token数据
                    this.$router.push({path:'test2'})//登陆成功跳转首页                              
                    // this.$message.success(msg)//提示成功
                    this.$message.success({
                        message: msg,
                        center: true
                        });

                }else{                   
                    this.$message.error({
                        message: msg,
                        center: true
                    })//否则提示失败
                }
            })
        },
        refresh(formName) {
            this.$router.push({path:'Login'})
            this.$refs[formName].resetFields();
        },
        register(formName) {
            this.dialogFormVisibleEdit=true
            this.$refs[formName].resetFields();
        },
        changepassword1(formName){
            this.dialogFormVisiblea=true
            this.$refs[formName].resetFields();
        },
        nextstep(formName){
            this.$http.post('http://localhost:8081/users/checkcardids',this.form2)
            .then((res)=>{
                console.log(res)
                const {
                    code,
                    msg,
                    data
                } =res.data
                if(code === 200){  
                    //提示成功
                    this.$message.success({
                        message: msg,
                        center: true
                        });
                    this.dialogFormVisibleb=true;
                    this.dialogFormVisiblea=false;
                    this.$refs[formName].resetFields();
                }else{                   
                    this.$message.error({
                        message: msg,
                        center: true
                    })//否则提示失败
                }
            })
        },
        confirm(formName){
            this.$http.post('http://localhost:8081/users/resetpasswords',this.form3)
            .then((res)=>{
                console.log(res)
                const {
                    code,
                    msg,
                    data
                } =res.data
                if(code === 200){  
                    //提示成功
                    this.$message.success({
                        message: msg,
                        center: true
                        });
                    this.$refs[formName].resetFields();
                    this.dialogFormVisibleb=false;
                }else{                   
                    this.$message.error({
                        message: msg,
                        center: true
                    })//否则提示失败
                }
            })
        },
        cancel(formName){
            this.$refs[formName].resetFields();
            this.dialogFormVisibleb=false
        },
        submitForm(formName) {
        this.$http.post('http://localhost:8081/users/registeradmins',this.form1)
            .then((res)=>{
                console.log(res)
                const {
                    code,
                    msg,
                    data
                } =res.data
                if(code === 200){  
                    // this.$message.success(msg)//提示成功
                    this.$message.success({
                    message: msg,
                    center: true
                    });
                    this.$refs[formName].resetFields();
                }else{                   
                    this.$message.error({
                        message: msg,
                        center: true
                    })//否则提示失败
                }
            })
      },
      resetForm(formName) {
        this.$refs[formName].resetFields();
        this.dialogFormVisibleEdit=false
      },
  }
}
</script>

<style>
  .login{
      height: 800px;
       background-image: url('../assets/loginui.png');  
       background-Repeat: "no-repeat";
      background-size: 100% auto;
  }
   .row1{
      height: 34%;
  }
  .login_title{
      color:rgb(138, 174, 252);
    }
  /* .row2{@click.prevent=
      height: 20%;
  }
  .row3{
      height: 20%;
  }
  .row4{
      height: 20%;
  }
  .row5{
      height:20%;
  }  */
</style>

