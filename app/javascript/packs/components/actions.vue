<template>
  <span style="overflow:visible; width: 110px;">
    <div class="dropdow show" v-if="actions.length > 0">
      <a href="#" class="btn m-btn m-btn--hover-accent m-btn--icon m-btn--icon-only m-btn--pill" data-toggle="dropdown">
        <i class="la la-gear"></i>
      </a>
      <div class="dropdown-menu dropdown-menu-left">
        <template v-for="action in actions">
          <a :href="linkTranslation(action)"
             class="dropdown-item"
             v-bind="htmlAttributes(action)"
             :target="action.target"
             v-if="!isComponent(action) && isShow(action) ">
            <i v-bind:class="action.icon">
              {{nameTranslation(action)}}
            </i>
          </a>

          <component :is="action.component" :source="source" v-if="isComponent(action)"></component>
        </template>
      </div>
    </div>
  </span>
</template>

<script>
  export default {
    props: {
      id: Number,
      source: Object,
      enableEdit: Boolean,
      enableDelete: Boolean,
      sourceName: String,
      extraActions: Array,
      locale: String,
    },
    data: () => {
      return {
        actions:[],
        actionStructure: {
          name: null,
          nameZhTW: null,
          path: null,
          link: null,
          icon: '',
          attributes: {},
          target: '_self'
        },
        editAction: {
          name: '編輯',
          nameZhTW: '編輯',
          link: ':sourceName/:id/edit',
          icon: 'la la-edit m--font-accent'
        },
        deleteAction: {
          name: '刪除',
          nameZhTW: '刪除',
          link: ':sourceName/:id',
          icon: 'la la-trash',
          attributes: {
            "data-method": "delete",
            "data-confirm-swal": "確定刪除這筆紀錄嗎 ?",
          },
        }
      }

    },
    created() {
      this.initActions();
    },
    methods: {
      linkTranslation(action){
        if(action.path) {
          return this.source[action.path];
        }
        if(action.link) {
          var link = action.link;
          link = link.replace(":id", this.id);
          link = link.replace(":sourceName", this.sourceName);
          return link;
        }
      },
      nameTranslation(action) {
        if(this.locale == 'zh-TW') {
          return action.nameZhTW ? action.nameZhTW : action.name;
        } else {
          return action.name
        }
      },
      htmlAttributes(action) {
        if(action.attributes == undefined) {
          return {}
        } else {
          return action.attributes
        }
      },
      isComponent(action) {
        return !(action['link'] || action['path'])
      },
      isShow(action) {
        if(action['checker']) {
          return this.source[action['checker']];
        }

       if(action['enable'] != undefined) {
         return this.source[action['enable']];
       }

       if(this.source["enable_" + action.name.toLowerCase()] == undefined) {
         return true;
       }
       return this.source["enable_" + action.name.toLowerCase()]
      },
      initActions(){
        this.actions = this.extraActions.map( action => {
          return Object.assign({}, this.actionStructure, action)
        })
        if(this.enableEdit) {
          this.actions.push(this.editAction);
        }
        if(this.enableDelete) {
          this.actions.push(this.deleteAction);
        }
      }
    }
  }
</script>
