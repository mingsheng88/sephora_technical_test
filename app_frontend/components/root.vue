<template>
  <div class='container'>
    <app-header></app-header>
    <router-view></router-view>
  </div>
</template>

<script>
  import Header from '../components/header.vue'

  export default {
    name: 'root',
    components: {
      'app-header': Header
    }
  }
</script>

<style scoped>
</style>
