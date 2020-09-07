import Vue            from 'vue/dist/vue.esm';
import mainMixin      from '../../mixins/main';
import VModal from 'vue-js-modal'
import materialsButton from '../../components/news_materials_button';

Vue.use(VModal, { dynamic: true, injectModalsContainer: true })

new Vue({
  el: '[data-behavior="app"]',
  mixins: [mainMixin],
  data: {
    sourceName: 'news',
    columns: [
      'id:ID',
      'name:名稱',
      'materials:素材更新數',
      //'download:下載進度',
      'updated_at:最後更新時間',
    ],
    sortingColumns: ['id', 'name', ],
    searchPlaceholder: ['name'],
    cellComponentDecorators: { materials: materialsButton },
    ajaxUrl: '',
    enableDelete: false,
    importModal: true,
  }
});
