<template>
  <div>
    <ul>
      <li class='product' v-for='product in products'>
        <img src='http://via.placeholder.com/225x225' />
        <div class='brand_name'>{{ product.attributes['brand-name'] }}</div>
        <div class='name'>{{ product.attributes.name }}</div>
        <div class='price'>{{ product.attributes.price }}</div>
        <div class='categories'>{{ product.attributes.categories }}</div>
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
  .product {
    list-style-image: none;
    list-style-position: outside;
    list-style-type: none;
    margin: 10px 5%;
    float: left;
  }

  .brand_name {
    font-weight: 600;
    font-size: 13px;
    margin-top: 2px;
  }

  .name {
    font-family: "Avalon", CenturyGothic, Helvetica, Arial;
  }

  .price {
    font-weight: 600;
  }
</style>
