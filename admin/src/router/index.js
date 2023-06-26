import { createRouter, createWebHistory } from 'vue-router'


const routes = [{
    path: '/',
    component: () => import( '../views/main.vue'),
    children: [{
      path:'welcome',
      component: ()=>import('../views/main/welcome.vue'),
    },{
      path:'about',
      component:()=>import('../views/main/about.vue'),
    },{
        path:'station',
        component: ()=>import('../views/main/station.vue'),
    },{
        path:'train',
        component: ()=>import('../views/main/train.vue'),
    },{
        path:'train-station',
        component: ()=>import('../views/main/train-station.vue'),
    }]
  },
  {
    path: '',
    redirect: '/welcome'
  },
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})
export default router
