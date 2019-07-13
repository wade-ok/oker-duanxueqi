import Vue from 'vue'
import './plugins/axios'
import qs from 'qs'
import App from './App.vue'
// import login from '.views/Login.vue'
import router from './router'
import './plugins/element.js'
import VueResource from '../node_modules/vue-resource'
import store from './store'
Vue.use(VueResource)

Vue.prototype.$qs = qs
Vue.config.productionTip = false
Vue.http.options.crossOrigin = true;
Vue.http.options.emulateHTTP = true;

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')

import {getUser} from '@/auth'
var uid=getUser()

  Vue.http.interceptors.push((request, next)  =>{  
  if(localStorage.getItem('token')){
    request.headers.set('token',localStorage.getItem('token'));
    console.log(request.headers)
  }
  next((response) => {
    return response;
  });
});