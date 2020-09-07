import Vue            from 'vue/dist/vue.esm';
import mainMixin      from '../../mixins/main';

new Vue({
  el: '[data-behavior="app"]',
  mixins: [mainMixin],
  data: {
    sourceName: 'tags',
    columns: [
      'id:ID',
      'name:標籤名稱',
      'note:備註',
    ],
    sortingColumns: ['id'],
    searchPlaceholder: ['name']
  },
});
