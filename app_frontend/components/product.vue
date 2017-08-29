<template>
  <div class='product'
    @mouseenter='mouseover_active = true'
    @mouseleave='mouseover_active = false'
    :class='{ available: !is_out_of_stock(), out_of_stock: is_out_of_stock() }'
    >

    <div class='product-image'>
      <img src='http://via.placeholder.com/225x225'/>
      <span class='add_to_wishlist'></span>

      <template v-if='!is_out_of_stock()'>
        <div class='add_to_cart image-overlay-btn' :class='{ hidden: !mouseover_active }'>
          ADD TO CART
        </div>
      </template>
      <template v-else>
        <div class='add_to_waitlist image-overlay-btn' :class='{ hidden: !mouseover_active }'>
          WAITLIST ME
        </div>
        <div class='product_out_of_stock'>OUT OF STOCK</div>
      </template>
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
    methods: {
      is_out_of_stock() { return this.stock_status == 'out_of_stock' },
      is_on_sale() { return this.sale_status == 'on_sale' }
    },
    computed: {
      brand_name() { return this.product.attributes['brand-name'] },
      name() { return this.product.attributes.name },
      price() { return this.product.attributes.price },
      stock_status() { return this.product.attributes['stock-status'] },
      sale_status() { return this.product.attributes['sale-status'] },
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

  .product-image {
    position: relative;
  }

  .product_out_of_stock {
    position: absolute;
    font-size: 2.2vmin;
    text-align: center;
    margin-top: -55%;
    line-height: 30px;
    width: 100%;
    opacity: 0.5;
    background: white;
  }

  .image-overlay-btn {
    position: relative;
    bottom: 30px;
    line-height: 30px;
    text-align: center;
    font-size: 2.5vmin;
    margin-bottom: -30px;
  }

  .add_to_cart {
    background: #e6001c;
    color: white;
  }
  .add_to_cart:hover {
    background: black;
    opacity: 0.65;
  }

  .add_to_waitlist {
    background: black;
    color: white;
  }
  .add_to_waitlist:hover {
    background: black;
    opacity: 0.2;
  }
  .waitlisted {
    background: #f1f1f1;
    color: #a9a9a9;
  }

  .add_to_wishlist {
    font-family: 'entypo';
    font-size: 4vmin;
    position: absolute;
    right: 13px;
    top: 0px;
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
