<template>
  <modal
  name="list"
  :adaptive="true"
  :scrollable="true"
  :reset="true"
  height="auto"
  width="99%" />
  </div>
  </modal>
</template>

<script>
  import Vue            from 'vue/dist/vue.esm';
  import VModal from 'vue-js-modal'
  Vue.use(VModal, { dynamic: true, injectModalsContainer: true })

  export default {
  }
</script>
