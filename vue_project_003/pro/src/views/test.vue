<template>

</template>


<script>
export default {
    created()
    {
        this.change1()
    },

    methods:{
        change1(){
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
                    this.$router.push({name:'user3'})
                    }
                    else{
                    this.$router.push({name:'admin3'})
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