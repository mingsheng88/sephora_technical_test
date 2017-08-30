<template>
  <div>
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
  * {
    font-family: Ubuntu, Arial, sans-serif;
    letter-spacing: 0.02em;
  }
</style>
