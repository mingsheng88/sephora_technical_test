<template>
  <div>

    <!-- Filter Nav -->
    <div class='row mt-3 mb-3' @keyup.enter='filter_products()'>
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
      <div class='col-xs-2 text-right'>
        <a href='#' class='btn btn-primary' @click.prevent='filter_products()'>
          Submit
        </a>
      </div>
    </div>

    <b-alert variant='danger' :show='this.has_error_message'>
      {{ error_message }}
    </b-alert>

    <template v-if='products.length > 0'>
      <!-- Pagination -->
      <div class='row d-block'>
          <b-pagination-nav
            class='col-xs-12'
            align= 'right'
            v-model='currentPage'
            :number-of-pages='page_count'
            :per-page='page_size'
            :link-gen='function() { return "#" }'
            />
      </div>

      <!-- Product List -->
      <!-- FIXME: Simplify / Extract as smaller component -->
      <div class='row' v-for='i in Math.ceil(products.length / products_per_row)'>
        <li
          class="list-unstyled d-flex justify-content-center"
          :class='`col-xs-${product_width}`'
          v-for='product in products.slice((i - 1) * products_per_row, i * products_per_row)'
          >
          <product :product='product'/>
        </li>
      </div>

      <!-- Pagination -->
      <div class='row d-block'>
          <b-pagination-nav
            class='col-xs-12'
            align= 'right'
            v-model='currentPage'
            :number-of-pages='page_count'
            :per-page='page_size'
            :link-gen='function() { return "#" }'
            />
      </div>
    </template>
    <div class='d-flex w-100 h-20 justify-content-center' v-else>
      No products found
    </div>
  </div>
</template>

<script>
  import Product from '../components/product.vue'
  import _ from 'lodash'

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
        sort_sequence_options: [
          { value: null, text: 'Sort Sequence' },
          { value: 'price', text: 'Ascending Price' },
          { value: '-price', text: 'Descending Price' },
        ],
        currentPage: 1,
        page_size: 21,
        page_count: 1,
        error_message: '',
      }
    },
    watch: {
      sort_sequence: function(value) { this.fetch_products(); },
      currentPage: function() {
        if (this.currentPage && this.currentPage > 0) {
          this.fetch_products();
        } else {
          this.currentPage = 1
        }
      },
    },
    computed: {
      product_width() { return Math.floor(12 / this.products_per_row) },
      has_error_message() { return this.error_message.length > 0; },
    },
    methods: {
      filter_products: function() {
        this.currentPage = 1
        this.fetch_products()
      },
      fetch_products: _.debounce(function() {
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
              number: this.currentPage
            }
          }
        }).then(function(response) {
          this.products = response.data.data
          this.page_count = response.data.meta.page_count
          this.page_size = response.data.meta.page_size
        }).catch(function(error) {
          this.error_message = `An '${error.statusText}' has occurred. Please try again shortly.`
        })
      }, 200),
    },
    created: function() { this.fetch_products(); }
  }
</script>

<style scoped>
</style>
