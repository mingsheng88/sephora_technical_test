import Vue from 'vue'
import VueResource from 'vue-resource'
import Root from '../components/root.vue'
import BootstrapVue from 'bootstrap-vue'

import 'bootstrap-vue/dist/bootstrap-vue.css'
import 'bootstrap/dist/css/bootstrap.css'

import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

Vue.use(BootstrapVue);
Vue.use(VueResource)

document.addEventListener('DOMContentLoaded', () => {
  document.body.appendChild(document.createElement('root'))
  new Vue(Root).$mount('root')
})
