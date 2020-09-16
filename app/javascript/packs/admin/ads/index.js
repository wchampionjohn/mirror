import Vue            from 'vue/dist/vue.esm';
import mainMixin      from '../../mixins/main';

new Vue({
  el: '[data-behavior="app"]',
  mixins: [mainMixin],
  data: {
    sourceName: 'ads',
    columns: [
      'id:ID',
      'name:廣告名稱',
      'status:狀態',
      'period:走期',
      'material:影音素材',
      'unit_price:單價',
      'ad_type:播放方式',
    ],
    sortingColumns: ['id', 'name'],
    searchPlaceholder: ['name'],
    ajaxUrl: '',
    cellHelperDecorators:{ material: 'adMaterialiDsplayer' },
  },
});
