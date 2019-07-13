<template>

</template>


<script>
export default {
    created()
    {
        this.change3()
    },

    methods:{
        change3(){
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
                    this.$router.push({name:'user4'})
                    }
                    else{
                    this.$router.push({name:'admin4'})
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