import Vue            from 'vue/dist/vue.esm';
import mainMixin      from '../../mixins/main';

new Vue({
  el: '[data-behavior="app"]',
  mixins: [mainMixin],
  data: {
    sourceName: 'devices',
    columns: [
      'id:ID',
      'name:設備名稱',
      'device_type:設備屬性 ',
      'location_name:場域',
      'last_report_time:狀態',
      'current_schedule:目前排程',
      'resolution:解析度',
      'floor:樓層',
      'mac:MAC',
    ],
    cellHelperDecorators:{
      last_report_time: 'service_light',
      current_schedule: 'currentScheduleRender'
    },
    sortingColumns: ['id', 'name', 'last_report_time' ],
    searchPlaceholder: ['name'],
    ajaxUrl: '',
    extraActions: [
      {
        link: 'devices/:id/reboot',
        name: '重新開機',
        icon: 'fa fa-power-off m--font-warning',
        attributes: {
          "data-confirm-swal": "確定重開機嗎?",
        }
      },
      {
        link: 'devices/:id/reset',
        name: '更新廣告',
        icon: 'fa fa-refresh m--font-info',
        attributes: {
          "data-confirm-swal": "確定更新廣告嗎?",
        }
      }
    ]
  },
});
