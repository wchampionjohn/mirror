<template>
  <button type="button"
          class="btn btn-outline-accent m-btn"
          data-toggle="m-tooltip"
          v-on:click="show()"
          v-html="source.programs_size"
          ></button>
</template>

<script>
  import { event } from '../../shared/event_hub';

  export default {
    props: {
      source: Object
    },
    data: () => {
      return {
        sessions:[]
      }
    },
    methods: {
      show() {
        this.fetchPrograms();
      },
      fetchPrograms(){
        let self = this
        let url = `/admin/platform_schedules/${this.source.id}/sessions`;

        fetch(url, {
          method: 'get',
          headers: {
            'content-type': 'application/json'
          }
        })
        .then(res => res.json())
        .then(res => {
          console.log(res);
          self.sessions = res;
        }).then(() => {
          self.openModal();
        })
      },
      formatedPrograms(){
        let result = '<div class="modal-content">';
        result += this.header();
        result += '<div class="modal-body">';
        result += '<div class="m-section__content">';

        for (const [startAt, programs] of Object.entries(this.sessions)) {
          result += `<div class="alert alert-success">${startAt}</div>`;
          result += '<table class="table table-striped m-table">';
          result += '<thead><tr><th>類型</th><th>編號</th><th>名稱</th><th>秒數</th></tr></thead>';
          result += '<tbody>';
          programs.forEach((program, key) => {
            result += this.rowOf(program);
          })
          result += `</tbody></table>`;
          result += `<BR />`;
        }

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
        result += ' 節目列表' ;
        result += '</h5> '
        result += `<button type="button" @click="$emit('close')"class="close" data-dismiss="modal" aria-label="Close">`;
        result += '<span aria-hidden="true">×</span>';
        result += '</button></div>';

        return result;
      },
      rowOf(program) {
        let result = '';
        result += `<tr>`;
        result += `<td>${program.kind}</td>`;
        result += `<td>${program.sn}</td>`;
        result += `<td>${program.name}</td>`;
        result += `<td>${program.seconds}</td>`;
        result += `</tr>`;

        return result;
      },
      openModal(){
        this.$modal.show(
          {
            template: this.formatedPrograms(),
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
    },
  }
</script>
