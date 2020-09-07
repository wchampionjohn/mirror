import Vue            from 'vue/dist/vue.esm';
import mainMixin      from '../../mixins/main';
import programsButton from '../../components/platform_schedule/programs_button';
import VModal from 'vue-js-modal'

Vue.use(VModal, { dynamic: true, injectModalsContainer: true })
new Vue({
  el: '[data-behavior="app"]',
  mixins: [mainMixin],
  data: {
    sourceName: 'platform_schedules',
    columns: [
      'id:ID',
      'name:名稱',
      'sessions:節目數量',
      'created_at:建立時間',
    ],
    sortingColumns: ['id', 'name', ],
    searchPlaceholder: ['name'],
    cellComponentDecorators: { sessions: programsButton },
    ajaxUrl: '',
    extraActions: [
      {
        link: 'platform_schedules/:id/copy',
        name: '複製',
        icon: 'la la-copy m--font-info',
        attributes: {
          "data-confirm-swal": "確定複製此播放清單嗎 ?",
          "data-method": "post"
        }
      },
      {
        link: 'platform_schedules/:id/export.xlsx',
        name: '匯出',
        icon: 'la la-cloud-download m--font-warning'
      }
    ]
  },
});
