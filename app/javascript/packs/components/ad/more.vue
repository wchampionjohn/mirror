<template>
  <button type="button"
          class="btn btn-outline-warning m-btn"
          data-toggle="m-tooltip"
          v-on:click="show()"
          >查看</button>
</template>

<script>
  import helpers from '../../mixins/helpers';

  export default {
    props: {
      source: Object
    },
    data: () => {
      return {
        devices:[]
      }
    },
    mixins: [helpers],
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
            <div class="col-lg-12 ml-4">
              <label class="form-control-label">
                <i class="la la-play"></i>
                <b>產品類別:</b>
              </label>
            <span class="help-bolck">${this.source.category}</span>
            </div>
          </div>
          <div class="form-group m-form__group row">
            <div class="col-lg-12 ml-4">
            <label class="form-control-label">
              <i class="la la-play"></i>
              <b>秒數:</b>
            </label>
            <span class="help-bolck">${this.source.seconds}</span>
          </div>
          </div>
          <div class="form-group m-form__group row">
            <div class="col-lg-12 ml-4">
            <label class="form-control-label">
              <i class="la la-play"></i>
              <b>代理商:</b>
            </label>
          <span class="help-bolck">${this.source.advertiser || ''}</span>
          </div>
        </div>
          <div class="form-group m-form__group row">
            <div class="col-lg-12 ml-4">
            <label class="form-control-label">
              <i class="la la-play"></i>
              <b>累計播放次數:</b>
            </label>
          <span class="help-bolck">${this.source.impressions || 0}</span>
          </div>
        </div>
          <div class="form-group m-form__group row">
            <div class="col-lg-12 ml-4">
            <label class="form-control-label">
              <i class="la la-play"></i>
              <b>累計觀看數:</b>
            </label>
          <span class="help-bolck">${this.source.views || 0}</span>
          </div>
        </div>
          <div class="form-group m-form__group row">
          <div class="col-lg-12 ml-4">
            <label class="form-control-label">
              <i class="la la-play"></i>
              <b>連結:</b>
            </label>
          <span class="help-bolck">${this.source.scanning_link}</span>
          </div>
        </div>
          <div class="form-group m-form__group row">
            <div class="col-lg-12 ml-4">
            <label class="form-control-label">
              <i class="la la-play"></i>
              <b>Banner:</b>
            </label>
          <span class="help-bolck">${this.bannerDisplayer(this.source.banner)}</span>
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

        return result;
      },
      header(){

        let result = '<div class="modal-header">';
        result += '<h5 class="modal-title">';
        result += `<span class="m--font-warning">${this.source.name}</span>`;
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
