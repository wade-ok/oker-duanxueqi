module.exports = {
    dev:{
        assetsSubDirectory: 'static',
        assetsPublicPath: '/',
        proxyTable:{
            '/api': {
                target: 'http://localhost:8081',
                ws: true,
                changeOrigin: true,
                pathRewrite: {
                    '^/api': ''
                  }          
            }
        },
    }
}