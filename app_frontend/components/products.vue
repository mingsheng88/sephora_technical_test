<template>
  <div>

    <!-- Filter Nav -->
    <div id='filter-bar' class='row mt-3 mb-3' @keyup.enter='fetch_products()'>
      <div class='col-xs-3'>
        <b-form-input type='text' placeholder='Category' v-model='categories' />
      </div>
      <div class='col-xs-2'>
        <b-form-input type='text' placeholder='Min Price' v-model='price_from' />
      </div>
      <div class='col-xs-2'>
        <b-form-input type='text' placeholder='Max Price' v-model='price_to' />
      </div>
      <div class='col-xs-3'>
        <b-form-select v-model='sort_sequence' :options='sort_sequence_options' />
      </div>
      <div class='col-xs-2'>
        <a class='btn btn-primary' @click='fetch_products()'>Submit</a>
      </div>
    </div>

    <!-- Product List -->
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
        page_size: 20,
        page_number: 1,
        sort_sequence: '-price',
        sort_sequence_options: [
          { value: null, text: 'Sort Sequence' },
          { value: 'price', text: 'Ascending Price' },
          { value: '-price', text: 'Descending Price' },
        ],
      }
    },
    watch: {
      sort_sequence: function(value) {
        this.fetch_products();
      }
    },
    computed: {
      product_width() { return Math.floor(12 / this.products_per_row) }
    },
    methods: {
      fetch_products: function() {
        console.log("fetching products!")
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
    },
    created: function() { this.fetch_products(); }
  }
</script>

<style scoped>
  #filter-bar {
  }
</style>
