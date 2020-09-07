<template>
  <button type="button"
          class="btn btn-outline-accent m-btn"
          data-toggle="m-tooltip"
          v-on:click="show()"
          >查看細節</button>
</template>

<script>
  import { event } from '../../shared/event_hub';

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
          this.openModal();
      },
      moreInfo(){
        let result = '<div class="modal-content">';
        result += this.header();
        result += `<div class="modal-body">
        <form class="m-form--label-align-right">
          <div class="form-group m-form__group row">
            <div class="col-lg-9 ml-4">
              <label class="form-control-label">
                <i class="la la-play"></i>
                <b>廣告類型:</b>
              </label>
            <span class="m--font-bolder">${this.source.property}</span>
            </div>
          <div class="col-lg-9 ml-4">
          </div>
          <div class="col-lg-9 ml-4">
            <label class="form-control-label">
              <i class="la la-play"></i>
              <b>有效日期:</b>
            </label>
            <span class="m--font-bolder">${this.source.start_at}</span>
          </div>
          <div class="col-lg-9 ml-4">
            <label class="form-control-label">
              <i class="la la-play"></i>
              <b>素材尺寸:</b>
            </label>
          <span class="m--font-bolder">${this.source.resolutions}</span>
          </div>
          <div class="col-lg-9 ml-4">
            <label class="form-control-label">
              <i class="la la-play"></i>
              <b>跑馬燈訊息:</b>
            </label>
          <span class="m--font-bolder">${this.source.scrolling_text}</span>
          </div>
        </div>
        </form>
        </div>`
        result += `<div class="modal-footer">
                        <button type="button" @click="$emit('close')" class="btn btn-secondary">
                          關閉
                        </button>
                          </div>`;
        result += `</div>`;
        result += `</div>`;

        return result;
      },
      header(){

        let result = '<div class="modal-header">';
        result += '<h5 class="modal-title">';
        result += `<span class="m--font-info">${this.source.name}</span>`;
        result += ' 廣告細節' ;
        result += '</h5> '
        result += `<button type="button" @click="$emit('close')"class="close" data-dismiss="modal" aria-label="Close">`;
        result += '<span aria-hidden="true">×</span>';
        result += '</button></div>';

        return result;
      },
      openModal(){
        this.$modal.show(
          {
            template: this.moreInfo(),
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
