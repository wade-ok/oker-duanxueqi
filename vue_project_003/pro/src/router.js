import Vue from 'vue'
import Router from 'vue-router'
import Home from './views/Home.vue'
// import user2 from './views/user2'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Login',
      component: () => import( './views/Login.vue')
    },
    // {
    //   path: '/login',
    //   name: 'login',
    //   component: () => import( './views/Login.vue')
    // },
    {
      path: '/user1',
      name: 'user1',
      component: () => import( './views/user1.vue'),
      children:[
        {
          path: '/user2',
          name: 'user2',
          component: () => import( './views/user2.vue')
        },
        {
          path: '/user3',
          name: 'user3',
          component: () => import( './views/user3.vue')
        },
        {
          path: '/user4',
          name: 'user4',
          component: () => import( './views/user4.vue')
        },
      ]
    },
    {
      path: '/admin1',
      name: 'admin1',
      component: () => import( './views/admin1.vue'),
      children:[
        {
          path: '/admin2',
          name: 'admin2',
          component: () => import( './views/admin2.vue')
        },
        {
          path: '/admin3',
          name: 'admin3',
          component: () => import( './views/admin3.vue')
          },
        {
          path: '/admin4',
          name: 'admin4',
          component: () => import( './views/admin4.vue')
        },
        {
          path: '/admin5',
          name: 'admin5',
          component: () => import( './views/admin5.vue')
        },
      ]
    },
    {
      path: '/test',
      name: 'test',
      component: () => import( './views/test.vue'),
    },
    {
      path: '/test2',
      name: 'test2',
      component: () => import( './views/test2.vue'),
    },
    {
      path: '/test3',
      name: 'test3',
      component: () => import( './views/test3.vue'),
    },
    {
      path: '/test4',
      name: 'test4',
      component: () => import( './views/test4.vue'),
    },
    {
      path: '/public',
      name: 'public',
      component: () => import( './views/public.vue'),
    },
    {
      path: '/repassword',
      name: 'register',
      component: () => import( './views/repassword.vue'),
    },
    {
      path: '/sendadmin1',
      name: 'sendadmin1',
      component: () => import( './views/sendadmin1.vue'),
      children:[
        {
          path: '/sendadmin2',
          name: 'sendadmin2',
          component: () => import( './views/sendadmin2.vue')
        },
        {
          path: '/sendadmin3',
          name: 'sendadmin3',
          component: () => import( './views/sendadmin3.vue')
        },
        {
          path: '/sendadmin4',
          name: 'sendadmin4',
          component: () => import( './views/sendadmin4.vue')
        },
        {
          path: '/sendadmin5',
          name: 'sendadmin5',
          component: () => import( './views/sendadmin5.vue')
        },
        {
          path: '/sendadmin6',
          name: 'sendadmin6',
          component: () => import( './views/sendadmin6.vue')
        },
        {
          path: '/sendadmin7',
          name: 'sendadmin7',
          component: () => import( './views/sendadmin7.vue')
        },
      ]
    },
    {
      path: '/readmin1',
      name: 'readmin1',
      component: () => import( './views/readmin1.vue'),
      children:[
        // {
        //   path: '/sendadmin2',
        //   name: 'sendadmin2',
        //   component: () => import( './views/sendadmin2.vue')
        // },
        {
          path: '/readmin2',
          name: 'readmin2',
          component: () => import( './views/readmin2.vue')
        },
        {
          path: '/readmin3',
          name: 'readmin3',
          component: () => import( './views/readmin3.vue')
        },
        {
          path: '/readmin4',
          name: 'readmin4',
          component: () => import( './views/readmin4.vue')
        },
        {
          path: '/readmin5',
          name: 'readmin5',
          component: () => import( './views/readmin5.vue')
        },
        {
          path: '/readmin6',
          name: 'readmin6',
          component: () => import( './views/readmin6.vue')
        },
      ]
    },
    {
      path: '/reuser1',
      name: 'reuser1',
      component: () => import( './views/reuser1.vue'),
      children:[
        {
          path: '/reuser2',
          name: 'reuser2',
          component: () => import( './views/reuser2.vue')
        },
        {
          path: '/reuser3',
          name: 'reuser3',
          component: () => import( './views/reuser3.vue')
        },
        {
          path: '/reuser4',
          name: 'reuser4',
          component: () => import( './views/reuser4.vue')
        },
      ]
    },
    {
      path: '/T',
      name: 'T',
      component: () => import( './views/T.vue')
    },
    {
      path: '/T2',
      name: 'T2',
      component: () => import( './views/T2.vue')
    },
  ]
})
