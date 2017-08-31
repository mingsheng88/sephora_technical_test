<template>
  <div class='container'>
    <app-header></app-header>
    <router-view></router-view>
  </div>
</template>

<script>
  import Products from '../components/products.vue'
  import Header from '../components/header.vue'

  export default {
    name: 'root',
    components: {
      'product': Products,
      'app-header': Header
    }
  }
</script>

<style scoped>
</style>
