import Vue from 'vue'
import VueResource from 'vue-resource'
import VueRouter from 'vue-router'
import Root from '../components/root.vue'
import BootstrapVue from 'bootstrap-vue'
import Routes from './routes'

import 'bootstrap-vue/dist/bootstrap-vue.css'
import 'bootstrap/dist/css/bootstrap.css'

import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

Vue.use(BootstrapVue);
Vue.use(VueResource);
Vue.use(VueRouter);

const router = new VueRouter({
  routes: Routes,
  mode: 'history'
});

document.addEventListener('DOMContentLoaded', () => {
  document.body.appendChild(document.createElement('root'))
  // new Vue(Root).$mount('root')
  new Vue({
    el: 'root',
    render: h => h(Root),
    router: router
  })
})
