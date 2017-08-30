<template>
  <div>
    <h1>Showed Product!</h1>
  </div>
</template>

<script>
  export default {
    name: 'show_product',
    data() {
      return {
        id: this.$route.params.id,
        product: {}
      }
    },
    created() {
      this.$http.
        get('http://localhost:3000/api/v1/products/' + this.id).
        then(function(response) {
          this.product = response.data.data
        });
    }
  }
</script>

<style scoped>
</style>
