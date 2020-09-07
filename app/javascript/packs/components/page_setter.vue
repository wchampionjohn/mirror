<template>
<div class="m-datatable__pager-info">
  <div class="btn-group bootstrap-select m-datatable__pager-size" style="width: 70px;">
    <button type="button" class="btn dropdown-toggle btn-default" data-toggle="dropdown" role="button" title="Select page size"><span class="filter-option pull-left">{{currentPerPage}}</span>&nbsp;<span class="bs-caret"><span class="caret"></span></span></button>
    <div class="dropdown-menu open" role="combobox">

      <ul class="dropdown-menu inner" role="listbox" aria-expanded="false" v-for="option of perPageOptions">
        <li data-original-index="1"  v-bind:class="{'selected': option == currentPerPage}">
          <a tabindex="0" class="" data-tokens="null" role="option" aria-disabled="false" aria-selected="true" v-on:click.prevent="switchPerPage(option)">
            <span class="text">{{option}}</span>
            <span class="glyphicon glyphicon-ok check-mark" v-if="option == currentPerPage">
            </span>
          </a>
        </li>
      </ul>
    </div>
  </div>
  <span class="m-datatable__pager-detail">
    顯示 {{startRecordsNumber()}} - {{endRecordsNumber()}} 共 {{pagination.totalRows}} 筆資料
  </span>
</div>
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
            totalRows: 1,
            totalPages: 1,
          }
        }
      },
    },
    data: function() {
      return {
        currentPerPage: 10, // 目前設定每頁幾筆
        perPageOptions:[10 ,20, 30, 50, 100] // 每頁幾筆的設定選項
      }
    },
    methods: {
      switchPerPage: function(perPage) {
        this.currentPerPage = perPage;
        event.$emit('switch-per-page', perPage);
      },
      startRecordsNumber: function() {
        return this.currentPerPage * (this.pagination.currentPage - 1) + 1;
      },
      endRecordsNumber: function() {
        if (this.pagination.currentPage !== this.pagination.totalPages) {
          return this.currentPerPage * (this.pagination.currentPage - 1) + this.currentPerPage;
        } else {
          return this.pagination.totalRows;
        }
      }
    }
  }
</script>
