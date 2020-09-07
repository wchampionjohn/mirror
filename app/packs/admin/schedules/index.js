import Vue            from 'vue/dist/vue.esm';
import mainMixin      from '../../mixins/main';

new Vue({
  el: '[data-behavior="app"]',
  mixins: [mainMixin],
  data: {
    sourceName: 'schedules',
    columns: [
      'id:ID',
      'name:名稱',
      'include_promotion:好康報報',
      'devices:設備總數',
      'ads:廣告總數',
      'start_at:開始時間',
      'end_at:結束時間',
      'created_at:建立時間',
      'remain_seconds:剩餘時間',
    ],
    sortingColumns: ['id', 'name', ],
    searchPlaceholder: ['name'],
    ajaxUrl: '',
    cellHelperDecorators:{
      include_promotion: 'checker',
      devices: 'linkOfDevicesInSchedule' ,
      ads: 'linkOfAdsInSchedule',
      remain_seconds: 'remainOfSchedule'
    },
    extraActions: [
      {
        link: 'schedules/:id/copy',
        name: '複製',
        icon: 'la la-copy m--font-info',
        attributes: {
          "data-confirm-swal": "確定複製此播放清單嗎 ?",
          "data-method": "post"
        }
      }
    ]
  },
});
