<template>
  <div>
    <div>
      <img src='http://via.placeholder.com/225x225'
        @mouseenter='mouseover_active = true'
        @mouseleave='mouseover_active = false'>
      </img>
      <div class='mouseover' v-if='mouseover_active'>
      </div>
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
    data() {
      return { mouseover_active: false }
    },
    computed: {
      brand_name() { return this.product.attributes['brand-name'] },
      name() { return this.product.attributes.name },
      price() { return this.product.attributes.price }
    }
  }
</script>

<style scoped>
  .mouseover {
    width:100%;
    background:red;
  }

  .brand_name {
    font-size: 13px;
    margin-top: 2px;
  }

  .name {
    font-family: "Avalon", CenturyGothic, Helvetica, Arial;
  }
</style>
