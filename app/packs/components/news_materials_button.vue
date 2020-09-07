<template>
  <button type="button"
          class="btn btn-outline-accent m-btn"
          data-toggle="m-tooltip"
          data-original-title="今日更新數 / 總數"
          v-on:click="show()"
          v-html="source.materials"
          ></button>
</template>

<script>
  import { event } from '../shared/event_hub';

  export default {
    props: {
      source: Object
    },
    data: () => {
      return {
        materials:[]
      }
    },
    methods: {
      show() {
        this.fetchMaterials();
      },
      fetchMaterials(){
        let self = this
        let url = `/admin/news/${this.source.id}/materials`;

        fetch(url, {
          method: 'get',
          headers: {
            'content-type': 'application/json'
          }
        })
        .then(res => res.json())
        .then(res => {
          self.materials = res
        }).then(() => {
          self.openModal();
        })
      },
      formatedMaterials(){
        let result = '<div class="modal-content">';
        result += this.header();
        result += '<div class="modal-body">';
        result += '<div class="m-section__content">';
        result += '<table class="table table-striped m-table">';
        result += '<thead><tr>';
        result += '<th>預覽</th>';
        result += '<th>檔案大小</th>';
        result += '<th>解析度</th>';
        result += '<th>尺寸</th>';
        result += '<th>最後更新時間</th>';
        result += '</tr></thead>';
        result += '<tbody>';
        this.materials.forEach((material) => {
          result += this.rowOf(material);
        })

        result += `</tbody></table>`;
        result += `</div>`;
        result += `</div>`;
        result += `<div class="modal-footer">
                        <button type="button" @click="$emit('close')" class="btn btn-secondary">
                          關閉
                        </button>
                          </div>`;
        result += `</div>`;

        return result;
      },
      header(){
        let result = '<div class="modal-header">';
        result += '<h5 class="modal-title">';
        result += `<span class="m--font-info">${this.source.name}</span>`;
        result += ' 素材更新數' ;
        result += `<span class="m--font-danger"> (${this.source.materials})</span>`;;
        result += '</h5> '
        result += `<button type="button" @click="$emit('close')"class="close" data-dismiss="modal" aria-label="Close">`;
        result += '<span aria-hidden="true">×</span>';
        result += '</button></div>';

        return result;
      },
      rowOf(material) {
        let result = '';
        result += `<tr>`;
        result += `<td>${this.materialDemo(material.url, material.is_image)}</td>`;
        result += `<td>${material.file_size}</td>`;
        result += `<td>${material.ratio}`;

        if(material.is_pdp_material) {
          result += '<font class="text-warning"> [PDP]</font>';
        }
        result += '</td>';
        result += `<td>${material.resolutions.join('、')}</td>`;
        if(material.is_updated) {
          result += `<td>${material.updated_at}</td>`;
        } else {
          result += `<td class="text-danger">${material.updated_at}</td>`;
        }
        result += `</tr>`;

        return result;
      },
      openModal(){
        this.$modal.show(
          {
            template: this.formatedMaterials(),
            props: ['text']
          }, {
            text: 'This text is passed as a property'
          }, {
            height: 'auto',
            width: "60%",
            adaptive: true,
            scrollable: true,
          }
        )
      },
      materialDemo(url, isImage) {
        if(isImage) {
          return `<a href="${url}" target="_blank">
            <img src="${url}" width="96" height="54" />
          </a>`;
        } else {
          return `<a href="${url}" target="_blank">
            <video src="${url}" width="96" height="54" />
            </a>`;
        }
      },
    },
  }
</script>
