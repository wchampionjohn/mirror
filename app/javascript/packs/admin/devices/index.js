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
      'mac:MAC',
      'last_report_time:狀態',
    ],
    cellHelperDecorators:{
      last_report_time: 'serviceLight',
    },
    sortingColumns: ['id', 'name', 'last_report_time' ],
    searchPlaceholder: ['name'],
    ajaxUrl: '',
  },
});
