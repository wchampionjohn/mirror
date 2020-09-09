import Vue            from 'vue/dist/vue.esm';
import mainMixin      from '../../mixins/main';

new Vue({
  el: '[data-behavior="app"]',
  mixins: [mainMixin],
  data: {
    sourceName: 'stores',
    columns: ['id', 'name:名稱', 'user:使用者', 'full_area:地區', 'devices:設備', 'is_installed:已安裝'],
    sortingColumns: ['id', 'name'],
    selector: { user_id: '' },
    searchPlaceholder: ['name'],
    ajaxUrl: '',
    cellHelperDecorators:{ is_installed: 'checker' },
  }
});
