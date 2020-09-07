export default {
  methods: {
    success_notice(msg){
      this.bootstrapGrowl('success', msg)
    },
    error_notice(msg){
      this.bootstrapGrowl('danger', msg)
    },
    info_notice(msg){
      this.bootstrapGrowl('info', msg)
    },
    bootstrapGrowl(type, msg){
      if (Array.isArray(msg)){
        msg.forEach((e) => {
          $.bootstrapGrowl(e, {type: type, align: 'right', offset: {from: 'bottom', amount: 30}})
        })
      }else{
        $.bootstrapGrowl(msg, {type: type, align: 'right', offset: {from: 'bottom', amount: 30}});
      }
    }
  }
}