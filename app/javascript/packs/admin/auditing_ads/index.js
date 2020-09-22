import Vue            from 'vue/dist/vue.esm';
import mainMixin      from '../../mixins/main';
import more from '../../components/ad/more';
import VModal from 'vue-js-modal'

Vue.use(VModal, { dynamic: true, injectModalsContainer: true })

new Vue({
  el: '[data-behavior="app"]',
  mixins: [mainMixin],
  data: {
    sourceName: 'audit_ads',
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
    enableEdit: false,
    enableDelete: false,
    extraActions: [
      {
        link: 'auditing_ads/:id/judgement',
        name: '審核通過',
        icon: 'la la-check-circle-o m--font-success',
        attributes: {
          "data-confirm-swal": "確定通過此廣告審核嗎",
          "data-method": "create"
        }
      },
      {
        link: 'auditing_ads/:id/judgement',
        name: '審核不通過',
        icon: 'la la-ban m--font-danger',
        attributes: {
          "data-confirm-swal": "確定拒絕此廣告的審核嗎?",
          "data-method": "delete"
        }
      }
    ],
  },
});
