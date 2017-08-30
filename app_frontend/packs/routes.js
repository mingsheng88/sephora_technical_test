import Products from '../components/products.vue'
import ShowProduct from '../components/show_product.vue'

export default [
  { path: '/', component: Products },
  { path: '/products/:id', component: ShowProduct }
]
