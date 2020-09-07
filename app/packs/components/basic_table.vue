<template>
  <table class="table table-striped m-table">
    <thead>
      <tr class="table table-striped m-table">
        <th v-for="column in originalColumns" :name="column">
          <span>
            {{ columnName(column) }}
            <i class="la arrow-updown"
               :class="sorttingColumnClass(column)"
               v-if="originalSortingColumns.includes(column)"
               v-on:click="sortBy(column)">
            </i>
          </span>
        </th>
        </th>
      </tr>
    </thead>
    <tbody>
      <tr class="m-table__row--info" v-if="summary.length > 0">
        <td class="m--font-boldest" :colspan="summaryColspan" align="right">
          Total
        </td>
        <td class="m--font-boldest" v-for="amount in summary" v-html="amount">
        </td>
      </tr>
      <tr v-for="(source, source_index) in sources" :key="source_index">
        <td v-for="column in originalColumns" :name="column+'_'+source['id']" >
          <span v-if="isNeedDecorateByComponent(column)">
            <component :is="renderCellComponent(column)" :source="source"></component>
          </span>
          <span v-else v-html="renderCell(column, source)"></span>
        </td>
      </tr>
      <tr v-if="sources.length == 0">
        <td :colspan="originalColumns.length + 2" align="center">no records</td>
      </tr>
    </tbody>
      <component
        :is="component" v-for="(component, componentName) in tableComponents" :key="componentName"
        v-bind="tableProperties(componentName)"></component>
  </table>
</template>

<script>
  import { event } from '../shared/event_hub';
  import columnsRender  from '../mixins/columns_render';
  import helpers from '../mixins/helpers';

  export default {
    mixins:[columnsRender, helpers],
    props: {
      sources: Array,
      columns: Array,
      sortingColumns: Array,
      sourceName: String,
      keyword: String,
      searchPlaceholder: Array,
      cellHelperDecorators: Object,
      cellComponentDecorators: Object,
      tableComponents: Object,
      tableComponentProperties: Object,
      summaryColspan: Number,
      summary: Array
    },
    data() {
      return {
        sorts: {},
        originalColumns: this.columns.map(e => e.split(':')[0]),
        originalSortingColumns: this.sortingColumns.map(e => e.split(':')[0]),
        selectedIds: [],
      }
    },
    mounted: function(){
      $('[data-toggle="m-tooltip"]').tooltip()
    },
    created: function() {
      this.sorts = this.defaultSortingColumns()
    },
    methods: {
      columnName(column){
        const orignalName = this.columns.find(e => e.split(':')[0] === column)
        let name = orignalName.split(':')
        let result

        if(!name[1]) {
          result = name[0].toLowerCase().replace(/\b[a-z]/g, function(letter) {
            return letter.toUpperCase();
          });
        } else {
          result = name[1]
        }

        return result
      },
      defaultSortingColumns(){
        return this.originalSortingColumns.reduce(function(result, column) {
          result[column] = ''
          return result;
        }, {})
      },
      sorttingColumnClass(column){
        let taxis = this.sorts[column]
        if(taxis === '') {
          return 'la-arrows-v'
        } else if(taxis == 'asc') {
          return  'la-arrow-up'
        } else if(taxis == 'desc') {
          return 'la-arrow-down'
        }
      },
      sortBy(column) {
        let taxis = this.sorts[column]
        let sorts = this.defaultSortingColumns()

        if(taxis === '') {
          sorts[column] = 'asc'
        } else if(taxis == 'asc') {
          sorts[column] = 'desc'
        } else if(taxis == 'desc') {
          sorts[column] = ''
        }

        let dbColumnName
        let sortColumn = this.sortingColumns.find(e => e.split(':')[0] === column)
        sortColumn = sortColumn.split(':')
        if(sortColumn[1]) {
          dbColumnName = sortColumn[1]
        } else {
          dbColumnName = sortColumn[0]
        }

        event.$emit('sort-by', { name: dbColumnName, taxis: sorts[column] });
        this.sorts = sorts
      },
      toggle(id) {
        var idx = this.selectedIds.indexOf(id);

        if (idx > -1) {
          this.selectedIds.splice(idx, 1);
          } else {
          this.selectedIds.push(id);
        }

        event.$emit('toggleSelection', this.selectedIds);
      },
      renderCell(column, source){
        let content = source[column]
        if(this.isFilterable(column)){
          content = this.columnRender(content, this.keyword)
        }

        if(this.isNeedDecorateByHelper(column)){
          let helper = this.cellHelperDecorators[column]
          content = this[helper](source, column)
        }
        return content
      },
      isFilterable(column){
        if(!this.keyword) {
          return false;
        }

        return this.searchPlaceholder.indexOf(column) > -1
      },
      isNeedDecorateByHelper(column){
        return Object.keys(this.cellHelperDecorators).indexOf(column) > -1
      },
      isNeedDecorateByComponent(column){
        return Object.keys(this.cellComponentDecorators).indexOf(column) > -1
      },
      renderCellComponent(column){
        return this.cellComponentDecorators[column]
      },
      tableProperties(component){
        if (this.tableComponentProperties[component] !== 'undefined') {
          return this.tableComponentProperties[component]
        } else {
          return {}
        }
      },
    }
  }
</script>
