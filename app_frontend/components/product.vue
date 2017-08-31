<template>
  <div class='product'
    @click='open_product_page()'
    :class='{ available: !is_out_of_stock, out_of_stock: is_out_of_stock }'
    >

    <div class='product-image'>
      <img src='http://via.placeholder.com/225x225'/>

      <template v-if='is_out_of_stock'>
        <div class='product_out_of_stock'>
          <span>OUT OF STOCK</span>
        </div>
        <div class='add_to_waitlist image-overlay-btn'>
          WAITLIST ME
        </div>
      </template>
      <template v-else>
        <div class='add_to_cart image-overlay-btn'>
          ADD TO CART
        </div>
      </template>

      <span class='add_to_wishlist'></span>
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
    methods: {
      open_product_page() { this.$router.push({ path: `/products/${this.product.id}` }) }
    },
    computed: {
      brand_name() { return this.product.attributes.brand_name },
      name() { return this.product.attributes.name },
      price() { return this.product.attributes.price },
      stock_status() { return this.product.attributes.stock_status },
      sale_status() { return this.product.attributes.sale_status },
      is_out_of_stock() { return this.stock_status == 'out_of_stock' },
      is_on_sale() { return this.sale_status == 'on_sale' },
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
    &:hover {
      .image-overlay-btn {
        display: block;
      }
    }
  }

  .product-image {
    position: relative;
  }

  .product_out_of_stock {
    position: absolute;
    display: flex;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    flex-direction: column;
    justify-content: center;

    span {
      font-size: 2.2vw;
      line-height: 30px;
      text-align: center;
      opacity: 0.5;
      background: white;
    }
  }

  .image-overlay-btn {
    display: none;
    position: absolute;
    bottom: 0px;
    left: 0px;
    right: 0px;
    line-height: 30px;
    text-align: center;

    @media (min-width: 1024px) {
      font-weight: bold;
    }
    @media (max-width: 1024px) {
      display: none !important;
      font-size: 2.5vw;
    }
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
    position: absolute;
    right: 5%;

    @media (min-width: 1024px) {
      top: 0px;
      font-size: 24px;
    }
    @media (max-width: 1024px) {
      bottom: 0px;
      font-size: 2vw;
    }
  }
  .add_to_wishlist:before {
    content: "\2661";
  }
  .add_to_wishlist:hover:before {
    content: "\2665";
    color: red;
  }
</style>
