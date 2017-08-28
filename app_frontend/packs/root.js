import Vue from 'vue'
import VueResource from 'vue-resource'
import Root from '../components/root.vue'

Vue.use(VueResource)

document.addEventListener('DOMContentLoaded', () => {
  document.body.appendChild(document.createElement('root'))
  new Vue(Root).$mount('root')
})
