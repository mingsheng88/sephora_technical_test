<template>
  <div class='product' @mouseenter='mouseover_active = true' @mouseleave='mouseover_active = false'>
    <span class='add_to_wishlist' :class='{ hidden: !mouseover_active }'></span>
    <img src='http://via.placeholder.com/225x225'/>
    <div class='add_to_cart' :class='{ hidden: !mouseover_active }'>
      ADD TO CART
    </div>
    <div class='brand_name font-weight-bold text-uppercase'>{{ brand_name }}</div>
    <div class='name'>{{ name }}</div>
    <div class='price font-weight-bold'>$ {{ price }}</div>
  </div>
</template>

<script>
  export default {
    name: 'product',
    props: [
      'product'
    ],
    data() { return { mouseover_active: false } },
    computed: {
      brand_name() { return this.product.attributes['brand-name'] },
      name() { return this.product.attributes.name },
      price() { return this.product.attributes.price }
    }
  }
</script>

<style scoped>
  .product {
    cursor: pointer;
    width: 100%;
    max-width: 225px;
    margin-bottom: 30px;
    position: relative;
  }

  .add_to_cart {
    background: #d50032;
    position: relative;
    bottom: 30px;
    height: 30px;
    text-align: center;
    font-size: 18px;
    color: white;
    margin-bottom: -30px;
  }
  .add_to_cart:hover {
    background: black;
    opacity: 0.65;
  }

  .add_to_wishlist {
    font-family: 'entypo';
    font-size: 24px;
    position: absolute;
    right: 13px;
  }
  .add_to_wishlist:before {
    content: "\2661";
  }
  .add_to_wishlist:hover:before {
    content: "\2665";
    color: red;
  }

  .brand_name {
    font-size: 13px;
    margin-top: 2px;
  }

  .name {
    font-family: "Avalon", CenturyGothic, Helvetica, Arial;
  }
</style>
