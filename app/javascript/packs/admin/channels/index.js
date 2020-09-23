import Vue            from 'vue/dist/vue.esm';
import mainMixin      from '../../mixins/main';

new Vue({
  el: '[data-behavior="app"]',
  mixins: [mainMixin],
  data: {
    sourceName: 'channels',
    columns: ['id', 'name:名稱', 'icon', 'is_active:啟用', 'position:位置', 'programs:節目', 'seconds:總長度(秒)', 'last_updated_at:最後更新時間'],
    searchPlaceholder: ['name'],
    sortingColumns: ['id', 'name'],
    cellHelperDecorators:{ icon: 'icon', programs: 'programsLinkOfChannel', is_active: 'checker' },
    ajaxUrl: '',
  }
});
