import Vue            from 'vue/dist/vue.esm';
import mainMixin      from '../../mixins/main';
import devicesButton from '../../components/devices_button';
import VModal from 'vue-js-modal'

Vue.use(VModal, { dynamic: true, injectModalsContainer: true })
new Vue({
  el: '[data-behavior="app"]',
  mixins: [mainMixin],
  data: {
    sourceName: 'locations',
    columns: [
      'id:ID',
      'name:捷運站名',
      'guarantee:保證人流',
      'area_name:地區',
      'devices:設備'
    ],
    cellHelperDecorators:{
      guarantee: 'formatNumberForTable'
    },
    cellComponentDecorators: { devices: devicesButton },
    sortingColumns: ['id', 'name', ],
    searchPlaceholder: ['name', 'area', 'address'],
    ajaxUrl: '',
  },
});
