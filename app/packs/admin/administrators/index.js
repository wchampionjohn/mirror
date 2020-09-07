import Vue            from 'vue/dist/vue.esm';
import mainMixin      from '../../mixins/main';

new Vue({
  el: '[data-behavior="app"]',
  mixins: [mainMixin],
  data: {
    sourceName: 'administrators',
    columns: [
      'id:ID',
      'name:名稱',
      'email',
      'identity:身份',
    ],
    sortingColumns: ['id'],
    searchPlaceholder: ['name']
  },
});
