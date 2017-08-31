<template>
  <div class='row'>
    <div class='col-xs-3'>
      <img src='http://via.placeholder.com/225x225'/>
    </div>
    <div class='col-xs-9'>
      <h1>{{ name }}</h1>
      <div class='price'>
        <label>Price</label>
        <span>{{ price }}</span>
      </div>
      <div class='stock-status'>
        <label>Stock Status</label>
        <span>{{ stock_status }}</span>
      </div>
      <div class='brand-name'>
        <label>Brand</label>
        <span>{{ brand_name }}</span>
      </div>

      <div class='sale-status'>
        <label>Sale Status</label>
        <span>{{ sale_status }}</span>
      </div>
      <template v-if='is_on_sale'>
        <div class='sale-price'>
          <label>Sale Price</label>
          <span>{{ sale_price }}</span>
        </div>
        <div class='sale-text'>
          <label>Sale Description</label>
          <span>{{ sale_text }}</span>
        </div>
      </template>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'show_product',
    data() {
      return {
        id: this.$route.params.id,
        product: null
      }
    },
    computed: {
      brand_name() { return this.product && this.product.attributes.brand_name },
      name() { return this.product && this.product.attributes.name },
      price() { return this.product && this.product.attributes.price },
      stock_status() { return this.product && this.product.attributes.stock_status },
      sale_status() { return this.product && this.product.attributes.sale_status },
      sale_text() { return this.product && this.product.attributes.sale_text },
      is_out_of_stock() { return this.stock_status == 'out_of_stock' },
      is_on_sale() { return this.sale_status == 'on_sale' },
    },
    methods: {
      fetch_product: function() {
        console.log("fetching product!")
        this.$http.
          get(`http://localhost:3000/api/v1/products/${this.id}`).
          then(function(response) {
            this.product = response.data.data
          });
      }
    },
    created: function() { this.fetch_product(); }
  }
</script>

<style scoped>
</style>
