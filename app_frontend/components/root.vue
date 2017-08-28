<template>
  <div>
    <products/>
  </div>
</template>

<script>
  import Products from '../components/products.vue'

  export default {
    name: 'root',
    components: {
      Products
    }
  }
</script>

<style scoped>
  * {
    font-family: Ubuntu, Arial, sans-serif;
    letter-spacing: 0.02em;
  }
</style>
