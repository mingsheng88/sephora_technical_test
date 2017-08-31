<template>
  <nav>
    <div>
      <router-link class='btn btn-default' to='/'>Home</router-link>
    </div>
  </nav>
</template>

<script>
  export default {
    name: 'header'
  }
</script>

<style scoped>
  nav {
    width: 100%;
    padding: 20px;
    text-align: center;
    border-bottom: 2px solid #f1f1f1;
  }
</style>
