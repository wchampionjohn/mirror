export default {
  methods:{
    columnRender: function(text, keyword){ // for hightlight
      if(text && text != '') {
        return text.replace(new RegExp(keyword, 'gi'), '<span class="text-danger">$&</span>');
      } else {
        return '';
      }
    }
  }
}
