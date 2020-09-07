<template>
  <table class="table table-striped m-table">
    <thead>
    <tr>
    <th title="Check All" class="m-datatable__cell--center m-datatable__cell m-datatable__cell--check">
      <label class="m-checkbox m-checkbox--single m-checkbox--all m-checkbox--solid m-checkbox--brand">
        <input
          :checked="toggleAllIsCheck()"
          type="checkbox" v-on:click="toggleAll()">
        <span></span>
      </label>
    </th>
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
    <th class="m-widget11__store" v-html="locale == 'zh-TW' ? '動作' : '設定'">
    </th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="(source, source_index) in sources" :key="source_index">
        <td>
          <label class="m-checkbox m-checkbox--solid m-checkbox--single m-checkbox--brand">
            <input
            type="checkbox"
            class="checkboxes"
            :checked="selectedIds.indexOf(source.id) > -1"
            v-on:click="toggle(source.id)"><span></span>
          </label>
        </td>

        <td v-for="column in originalColumns" :name="column+'_'+source['id']" >
          <span v-if="isNeedDecorateByComponent(column)">
            <component :is="renderCellComponent(column)" :source="source" v-bind="cellProperties(column, source)"></component>
          </span>
          <span v-else v-html="renderCell(column, source)"></span>
        </td>
        <td>
          <actions-vue
            :id="source.id"
            :source="source"
            :source-name="sourceName"
            :extra-actions="extraActions"
            :enable-edit="enableEditOf(source)"
            :locale="locale"
            :enable-delete="enableDeleteOf(source)">
          </actions-vue>
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
  import ClipboardJS from 'clipboard';
  import { event } from '../shared/event_hub';
  import columnsRender  from '../mixins/columns_render';
  import helpers from '../mixins/helpers';
  import actions from '../components/actions.vue';

  export default {
    components: {
      'actions-vue': actions,
    },
    mixins:[columnsRender, helpers],
    props: {
      sources: Array,
      enableEdit: Boolean,
      enableDelete: Boolean,
      columns: Array,
      sortingColumns: Array,
      sourceName: String,
      keyword: String,
      searchPlaceholder: Array,
      extraActions: Array,
      cellHelperDecorators: Object,
      cellComponentDecorators: Object,
      cellComponentProperties: Object,
      tableComponents: Object,
      tableComponentProperties: Object,
      locale: String,
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
      this.initClipboard();
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
      toggleAll(){
        const currentIds = this.sources.map(function(source){
          return source.id;
        })

        if (this.toggleAllIsCheck()){
          this.selectedIds = []
        } else {
          this.selectedIds = currentIds
        }

        event.$emit('toggleSelection', this.selectedIds);
      },
      toggleAllIsCheck(){

        if (this.sources.length == 0) {
          return false
        }
        const currentIds = this.sources.map(function(source){
          return source.id;
        })

        return JSON.stringify(this.selectedIds) == JSON.stringify(currentIds)

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
      cellProperties(column, source) {
        if (this.cellComponentProperties[column]) {
          var properties = this.cellComponentProperties[column];

          var obj = new Object();
          Object.keys(properties).forEach(function(column) {
            obj[column] = source[properties[column]];
          });

          return obj;
        } else {
          return {}
        }
      },
      enableEditOf(source){
        return source.enable_edit !== undefined ? source.enable_edit : this.enableEdit;
      },
      enableDeleteOf(source){
        return source.enable_delete !== undefined ? source.enable_delete : this.enableDelete;
      },
      initClipboard() {
        var clipboard = new ClipboardJS('.btn');
        clipboard.on('success', function(e) {
          toastr.info('複製完成', 'Info');
        });
      }

    }
  }
</script>
