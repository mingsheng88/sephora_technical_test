<template>
  <div>
    <div class='row form-group'>
      <div class='col-xs-3'>
        <input type='text' placeholder='Category' v-model='categories' />
      </div>
      <div class='col-xs-3'>
        <input type='text' placeholder='Min Price' v-model='price_from' />
      </div>
      <div class='col-xs-3'>
        <input type='text' placeholder='Max Price' v-model='price_to' />
      </div>
      <div class='col-xs-3'>
        <select>
          <option>Ascending Price</option>
          <option>Descending Price</option>
        </select>
      </div>
    </div>
    <div class='row' v-for='i in Math.ceil(products.length / products_per_row)'>
      <li
        class="list-unstyled"
        :class='`col-xs-${product_width}`'
        v-for='product in products.slice((i - 1) * products_per_row, i * products_per_row)'
        >
        <product :product='product'/>
      </li>
    </div>
  </div>
</template>

<script>
  import Product from '../components/product.vue'

  export default {
    name: 'products',
    props: {
      products_per_row: {
        type: Number,
        default: 3
      }
    },
    components: {
      'product': Product
    },
    data() {
      return {
        products: [],
        categories: '',
        price_from: '',
        price_to: '',
        sort_sequence: '-price',
        page_size: 20,
        page_number: 1
      }
    },
    computed: {
      product_width() { return Math.floor(12 / this.products_per_row) }
    },
    created: function() {
      this.$http.get('http://localhost:3000/api/v1/products', {
          params: {
            filter: {
              price_to: this.price_to,
              price_from: this.price_from,
              categories: this.categories
            },
            sort: this.sort_sequence,
            page: {
              size: this.page_size,
              page_number: this.page_number
            }
          }
        }).then(function(response) {
          this.products = response.data.data
        })
    }
  }
</script>

<style scoped>
</style>
