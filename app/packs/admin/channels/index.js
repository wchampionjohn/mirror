import Vue            from 'vue/dist/vue.esm';
import mainMixin      from '../../mixins/main';
import devicesButton from '../../components/channel/devices_button';
import VModal from 'vue-js-modal'

Vue.use(VModal, { dynamic: true, injectModalsContainer: true })

new Vue({
  el: '[data-behavior="app"]',
  mixins: [mainMixin],
  data: {
    sourceName: 'channels',
    columns: [
      'id:ID',
      'name:名稱',
      'devices:設備',
      'note:備註',
    ],
    cellComponentDecorators: { devices: devicesButton },
    sortingColumns: ['id'],
    searchPlaceholder: ['name'],
    ajaxUrl: ''
  },
});
