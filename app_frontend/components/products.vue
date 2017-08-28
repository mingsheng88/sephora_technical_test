<template>
  <div>
    <ul>
      <li v-for='product in products'>
        {{ product.attributes.price }}
        {{ product.attributes.categories }}
      </li>
    </ul>
  </div>
</template>

<script>
  export default {
    name: 'products',
    data() {
      return { products: [] }
    },
    created: function() {
      this.$http.
        get('http://localhost:3000/api/v1/products').
        then(function(response) {
          this.products = response.data.data
        })
    }
  }
</script>

<style scoped>
  ul {
    text-align: center;
    font-size: 3em;
  }
</style>
