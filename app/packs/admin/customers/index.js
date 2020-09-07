import Vue            from 'vue/dist/vue.esm';
import mainMixin      from '../../mixins/main';

new Vue({
  el: '[data-behavior="app"]',
  mixins: [mainMixin],
  data: {
    sourceName: 'customers',
    columns: [
      'id:ID',
      'sn:編號',
      'name:客戶名稱',
      'ads:廣告總數',
      'note:備註',
    ],
    sortingColumns: ['id', 'sn'],
    searchPlaceholder: ['sn', 'name'],
    ajaxUrl: ''
  },
});
