import Vue            from 'vue/dist/vue.esm';
import mainMixin      from '../../mixins/main';
import more from '../../components/ad/more';
import VModal from 'vue-js-modal'

Vue.use(VModal, { dynamic: true, injectModalsContainer: true })

new Vue({
  el: '[data-behavior="app"]',
  mixins: [mainMixin],
  data: {
    sourceName: 'ads',
    columns: [
      'id:ID',
      'material_url:素材圖',
      'name:廣告名稱',
      'sn:廣告編號',
      'customer_name:客戶名稱',
      'seconds:秒數',
      'category:產業類別',
      'guarantee:保證人流',
      'more:查看細節'
    ],
    sortingColumns: ['id', 'name', 'sn', 'start_at' ],
    searchPlaceholder: ['name', 'sn'],
    cellComponentDecorators: { more: more },
    selector: { category_id: '', customer_id: '' },
    ajaxUrl: '',
    cellHelperDecorators:{
      material_url: 'materialFileDisplayer' ,
      guarantee: 'formatNumberForTable'
    },
  },
});
