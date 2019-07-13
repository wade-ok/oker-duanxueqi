<template>

</template>


<script>
export default {
    created()
    {
        this.change2()
    },

    methods:{
        change2(){
        this.$http.post('http://localhost:8081/users/getrole')
            .then((res)=>{
                console.log(res)
                const {
                    code,
                    msg,
                    data
                } =res.data
                if(code === 200){ 
                    console.log(data)                   
                    if(data === "user"){
                    this.$router.push({name:'reuser1'})
                    }
                    else if(data === "readmin"){
                    this.$router.push({name:'readmin1'})
                    }      
                    else if(data === "sendadmin"){
                    this.$router.push({name:'sendadmin1'})
                    }                        
                    // this.$message.success(msg)//提示成功
                }else{                   
                    this.$message.error(msg)//否则提示失败
                }
            })
        }
    }
}

</script>