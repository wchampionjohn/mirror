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
      'name:名稱',
      'status:狀態',
      'period:走期',
      'material:影音素材',
      'unit_price:計價',
      'ad_type:播放方式',
      'more:更多資訊'
    ],
    sortingColumns: ['id', 'name'],
    searchPlaceholder: ['name'],
    cellComponentDecorators: { more: more },
    ajaxUrl: '',
    cellHelperDecorators:{ status: 'adState', material: 'adMaterialiDsplayer' },
  },
});
