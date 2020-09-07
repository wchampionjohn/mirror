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
    ],
    sortingColumns: ['id', 'name'],
    searchPlaceholder: ['name'],
    ajaxUrl: '',
  },
});
