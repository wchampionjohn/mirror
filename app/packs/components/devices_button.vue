<template>
  <button type="button"
          class="btn btn-outline-accent m-btn"
          data-toggle="m-tooltip"
          v-on:click="show()"
          v-html="source.devices"
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
        devices:[]
      }
    },
    methods: {
      show() {
        this.fetchDevices();
      },
      fetchDevices(){
        let self = this
        let url = `/admin/locations/${this.source.id}/devices`;

        fetch(url, {
          method: 'get',
          headers: {
            'content-type': 'application/json'
          }
        })
        .then(res => res.json())
        .then(res => {
          self.devices = res.data;
        }).then(() => {
          self.openModal();
        })
      },
      formatedDevices(){
        let result = '<div class="modal-content">';
        result += this.header();
        result += '<div class="modal-body">';
        result += '<div class="m-section__content">';
        result += '<table class="table table-striped m-table">';
        result += '<thead><tr><th>id</th><th>場域名稱</th><th>設備屬性</th><th>MAC</th></tr></thead>';
        result += '<tbody>';
        this.devices.forEach((device) => {
          result += this.rowOf(device);
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
        result += ' 設備列表' ;
        result += `<span class="m--font-danger"> (${this.source.devices})</span>`;;
        result += '</h5> '
        result += `<button type="button" @click="$emit('close')"class="close" data-dismiss="modal" aria-label="Close">`;
        result += '<span aria-hidden="true">×</span>';
        result += '</button></div>';

        return result;
      },
      rowOf(device) {
        let result = '';
        result += `<tr>`;
        result += `<td>${device.id}</td>`;
        result += `<td>${device.name}</td>`;
        result += `<td>${device.device_type}</td>`;
        result += `<td>${device.mac}</td>`;
        result += `</tr>`;

        return result;
      },
      openModal(){
        this.$modal.show(
          {
            template: this.formatedDevices(),
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
