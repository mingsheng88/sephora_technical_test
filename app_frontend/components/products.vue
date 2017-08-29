<template>
  <div class='container'>
    <div class='row' v-for='i in Math.ceil(products.length / 3)'>
      <li class='list-unstyled col-xs-4' v-for='product in products.slice((i - 1) * 3, i * 3)'>
        <product :product='product'/>
      </li>
    </div>
  </div>
</template>

<script>
  import Product from '../components/product.vue'

  export default {
    name: 'products',
    components: {
      'product': Product
    },
    data() {
      return {
        products: []
      }
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
</style>
