import _              from 'lodash';
import BasicTableVue       from '../components/basic_table.vue';
import PaginationVue  from '../components/pagination.vue';
import PageSetterVue  from '../components/page_setter.vue';
import { event } from '../shared/event_hub';

export default {
  components: {
    PaginationVue, BasicTableVue, PageSetterVue
  },
  data: {
    sources: [],
    keyword: '',
    sortingColumns: [],
    sort: { name: '', taxis: '' },
    pagination: {},
    tableComponents: {},
    tableComponentProperties: {},
    cellHelperDecorators: {},
    cellComponentDecorators: {},
    summary: [],
    summaryColspan: 0,
  },
  created () {
    event.$on('go-page', this.goPage);
    event.$on('switch-per-page', this.switchPerPage);
    event.$on('sort-by', this.sortBy);
    event.$on('toggleSelection', this.toggleSelection);
  },
  mounted () {
    this.fetchSources();
  },
  methods: {

    fetchSources (options= {}) {

      let defaultOptions = {
        pagination: {
          currentPage: '',
          perPage: '',
        },
        keyword: '',
        sort: {
          name: '',
          taxis: ''
        }
      }

      options = Object.assign({}, defaultOptions, options);

      let self = this;
      let page = options.pagination.currentPage || this.pagination.currentPage
      let per = options.pagination.perPage || this.pagination.perPage
      let sortName = options.sort.name || this.sort.name
      let sortTaxis = options.sort.taxis || this.sort.taxis
      let selector = options.selector || this.selector
      let sort = options.sort
      let keyword = ''

      if(options.keyword) {
        keyword = options.keyword
        page = 1 // 切回第一頁，避免沒有資料可顯示
      } else {
        keyword = this.keyword
      }

      let requestParams = {
        page: page,
        per_page: per,
        q: keyword,
        selector: selector,
        sorting_name: sortName,
        sorting_taxis: sortTaxis,
      };

      $.ajax({
        url: self.ajaxUrl || document.URL,
        method: 'GET',
        dataType: 'json',
        data: requestParams,
      }).done(function(result){

        self.sources = result.data;
        if (result.summary) {
          self.summary = result.summary;
        }

        self.pagination = {}
        self.pagination.currentPage = result.pagination.current_page;
        self.pagination.perPage = result.pagination.per_page;
        self.pagination.totalPages = result.pagination.total_pages; // 總頁數
        self.pagination.totalRows = result.pagination.total_count; // 總筆數
        self.$nextTick(function () {
          $('[data-toggle="m-tooltip"]').tooltip()
        })
      })
    },
    goPage (page) {
      let options = { pagination: {} }
      options.pagination.currentPage = page

      this.fetchSources(options);
    },
    switchPerPage (per) {
      let options = { pagination: {} }
      options.pagination.perPage = per
      options.pagination.currentPage = 1 // 換每頁顯示比數一律切回第一頁，避免沒有資料可顯示

      this.fetchSources(options);
    },
    sortBy(sort) {
      let options = { sort: {} }
      if(!sort.taxis) {
        options.sort = {}
      } else {
        options.sort = sort
      }

      this.sort = options.sort

      this.fetchSources(options)
    }
  },
  watch: {
    keyword: _.debounce(function (keyword) {
      this.fetchSources({keyword: keyword})
    }, 500),
    selector: {
      handler: _.debounce(function (selector) {
        this.fetchSources({selector: selector})
      }),
      deep: true
    }
  }
}

$.ajaxSetup({
  headers: {
    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
  }
});
