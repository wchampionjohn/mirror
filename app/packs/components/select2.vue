<template>
  <select class="form-control m-select2" >
  </select>
</template>

<script>
export default {
  props: ['options', 'value'],
  mounted: function () {
    var options = this.options.map(function(obj) {
      return { id: obj.id, text: obj.name } ;
    });

    var vm = this
    $(this.$el)
      // init select2
      .select2({
        data: options,
        placeholder: "Select one",
      })
      .val(this.value)
      .trigger('change')
      // emit event on change.
      .on('change', function () {
        vm.$emit('input', this.value)
      })
  },
  watch: {
    value: function (value) {
      // update value
      $(this.$el)
      	.val(value)
      	.trigger('change')
    },
    options: function (options) {
      var options = options.map(function(obj) {
        return { id: obj.id, text: obj.name } ;
      });
      // update options
      $(this.$el).empty().select2({ data: options })
    }
  },
  destroyed: function () {
    $(this.$el).off().select2('destroy')
  }
}
</script>
