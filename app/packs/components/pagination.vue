<template>
<ul class="pagination m-datatable__pager-nav" v-if="pages.length > 0">
  <li v-if="!isFirst()">
    <a href="javascript:;" class="m-datatable__pager-link m-datatable__pager-link--first" v-on:click.prevent="firstPage()">&laquo;</a>
  </li>
  <li v-if="!isFirst()">
    <a href="javascript:;" class="m-datatable__pager-link m-datatable__pager-link--first" v-on:click.prevent="prevPage()">&lsaquo;</a>
  </li>
  <template v-for="page of pages">
  <li v-if="isCurrent(page)">
    <a href="javascript:;" class="m-datatable__pager-link m-datatable__pager-link-number m-datatable__pager-link--active">{{page}}</a>
  </li>
  <li v-else class="m-datatable__pager-link m-datatable__pager-link-number">
    <a href="javascript:;" class="m-datatable__pager-link m-datatable__pager-link-number" v-on:click.prevent="goPage(page)">{{page}}</a>
  </li>
  </template>
  <li class="paginate_button next" v-if="!isLast()">
    <a href="javascript:;" class="m-datatable__pager-link m-datatable__pager-link--next" v-on:click.prevent="nextPage()">&rsaquo;</a>
  </li>
  <li class="paginate_button next" v-if="!isLast()">
    <a href="javascript:;" class="m-datatable__pager-link m-datatable__pager-link--last" v-on:click.prevent="lastPage()">&raquo;</a>
  </li>
</ul>
</template>

<script>
  import { event } from '../shared/event_hub';

  export default {
    template: '',
    props: {
      pagination: {
        type: Object,
        default: function() {
          return {
            currentPage: 1,
            totalPage: 1,
          }
        }
      },
    },
    data: function() {
      return {
        pages: []
      }
    },
    created: function() {
    },
    mounted: function() {
      this.calculate();
    },
    methods: {
      isFirst: function() {
        return this.pagination.currentPage === 1;
      },
      isLast: function() {
        return this.pagination.currentPage === this.pagination.totalPages
      },
      isCurrent: function(page) {
        return this.pagination.currentPage === page;
      },
      firstPage: function() {
        this.goPage(1);
      },
      prevPage: function() {
        var prev_page = this.pagination.currentPage - 1;
        this.goPage(prev_page);
      },
      goPage: function(page) {
        event.$emit('go-page', page);
      },
      filterKeyword: function(keyword) {
        event.$emit('filter-keyword', keyword);
      },
      nextPage: function() {
        var next_page = this.pagination.currentPage + 1;
        this.goPage(next_page);
      },
      lastPage: function() {
        this.goPage(this.pagination.totalPages);
      },
      calculate: function() {
        var page = this.pagination.currentPage;
        var total = this.pagination.totalPages;
        var min = 1;
        var max = total;
        var pageWindow = 4;
        if ((page - pageWindow) > 1) {
          min = page - pageWindow;
        }

        if ((page + pageWindow) < total) {
          max =  page + pageWindow;
        }
        this.pages = _.range(min, max + 1);
      },
    },
    watch: {
      pagination: function (newPagination) {
        this.calculate();
      }
    }
  };
</script>

<style scoped>

</style>
