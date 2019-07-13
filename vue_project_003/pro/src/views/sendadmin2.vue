<template>
<el-card>
  <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: 'sendadmin1' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>创建项目</el-breadcrumb-item>
    </el-breadcrumb>
      <el-form ref="form" :model="form" label-width="80px">    
      <el-form-item label="">
          <el-col :span="14" :offset="4" class="middle">
            <h2>项目创建</h2>
          </el-col>
      </el-form-item>

      <!-- <el-form-item label="">
            <el-col :span="4"> &nbsp; </el-col>
            <el-col :span="2"> 创&nbsp;&nbsp;&nbsp;&nbsp;建&nbsp;&nbsp;&nbsp;&nbsp;人 ： </el-col>
            <el-col :span="4"> 
                <el-input v-model="form.sendname" disabled autocomplete="off" placeholder="创建人"> </el-input>
            </el-col>
    </el-form-item> -->
    <br>
    <el-form-item label="">
            <el-col :span="4"> &nbsp; </el-col>
            <el-col :span="2"> &nbsp;项&nbsp; 目&nbsp; 名&nbsp; 称 ： </el-col>
            <el-col :span="4"> 
                <el-input v-model="form.proname" autocomplete="off" placeholder="项目名称"> </el-input>
            </el-col>
        <el-col :span="1"> &nbsp; </el-col>
            <el-col :span="2"> &nbsp;期望完成时间： </el-col>
            <el-col :span="2"> 
                <el-date-picker size="medium"
            style="width:255px"
            v-model="form.expecttime" 
            type="datetime" 
            value-format="yyyy-MM-dd HH:mm:ss"
            format="yyyy-MM-dd HH:mm:ss"
            placeholder="选择日期时间"></el-date-picker>
          </el-col>
    </el-form-item>

    <el-form-item label="">
        <!-- <el-col :span="4"> &nbsp; </el-col>
            <el-col :span="2"> 上传需求文档： </el-col>
            <el-col :span="11"> 
                <el-input v-model="form.prodocument" autocomplete="off" placeholder="上传需求文档"> </el-input>
            </el-col> -->
    </el-form-item>

        <el-form-item label="">
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
            <el-col>
            </el-col>
    </el-form-item>
      <br><br>
    <el-form-item label="">
      <el-row>
          <el-col :span="4"> &nbsp; </el-col>
          <el-col :span="2"> &nbsp;项&nbsp; 目&nbsp; 说&nbsp; 明 ： </el-col>
          <el-col :span="11"> 
              <el-input
              type="textarea"
              :rows="3"
              autocomplete="off"
              placeholder="请填写项目说明"
              v-model="form.proexplain">
              </el-input>
          </el-col>
      </el-row>
    </el-form-item>

    <el-form-item label="">
      <el-row>
          <el-col :span="8"> &nbsp; </el-col>
          <el-col :span="2"> 
              <el-button @click="Establish()" type="primary" round>确 认</el-button>
          </el-col>
          <el-col :span="2"> &nbsp; </el-col>
          <el-col :span="2"> 
              <el-button @click="cancel()" type="info"  round>取 消</el-button>
          </el-col>
      </el-row>
      <br>
    </el-form-item>
  </el-form>
</el-card>
</template>

<script>
  export default {
    data() {
      return {
        fileList: [
          ],
        form: {
          sendname:'',
          proname: '',
          expecttime: '',
          prodocument:'',
          proexplain:'',
        },
      }
    },

    methods: {
      handleFileUploaded(response,file, fileList){
        this.form.prodocument = response
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
      //创建项目
      Establish(){
        this.$http.post('http://localhost:8081/projects/createprojects',this.form)
        .then((res)=>{
            console.log(res)
            const {
                code,
                msg
            } =res.data
            if(code === 200){ 
              //提示成功
              this.$message.success({
                    message: msg,
                    center: true
                    });
              this.form={}
            }else{
              this.$message.error({
                  message: msg,
                  center: true
                  });
            }
        }).catch(e=>{
            this.$message.error({
                  message: "请输入项目信息",
                  center: true
                  });
          })
      },
      cancel(){
        this.form={}
      },
    },
  }
</script>

