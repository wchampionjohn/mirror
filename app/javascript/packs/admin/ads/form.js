import Vue from 'vue/dist/vue.esm';

new Vue({
  el: '#material',
  data: {
    adId: null,
    materialUrl: null,
    materialSize: null,
    bannerUrl:null,
    bannerSize:null,
    currentImage: '',
    currentImageType: '',
  },
  mounted(){
    this.initData();
    this.initDropZone();
  },
  methods:{
    initDropZone(){

      let self = this;
      Dropzone.autoDiscover = false;

      var dz = new Dropzone("#m-dropzone-one", {
        maxFiles: 1,
        url: self.uploadUrlOf('material'),
        acceptedFiles: ".mp4",
        maxFilesize: 100, // MB
        addRemoveLinks: true,
        createImageThumbnails: true
      });

      dz.on("success", function(file){
        var response  = file.xhr.response;
        self.material = response;
        this.removeFile(file);
        toastr.info('上傳成功', 'Info');
      });

      dz.on("error", function(file, responseText){
        toastr.error(responseText.errors, 'Error');
      });

      var dz = new Dropzone("#m-dropzone-two", {
        url: self.uploadUrlOf('banner'),
        acceptedFiles: ".mp4",
        acceptedFiles: ".jpg,.png,.jpeg,.gif",
        maxFilesize: 10, // MB
        addRemoveLinks: true,
        createImageThumbnails: true
      });

      dz.on("success", function(file){
        var response  = file.xhr.response;
        self.banner = response;
        this.removeFile(file);
        toastr.info('上傳成功', 'Info');
      });

      dz.on("error", function(file, responseText){
        toastr.error(responseText.errors, 'Error');
      });
    },
    initData(){
      this.adId = $('#ad').data('id');
      this.fileCode = $('#ad').data('file-code');
      this.materialUrl = $('#ad').data('material-url');
      this.materialSize = $('#ad').data('material-size');
      this.bannerUrl = $('#ad').data('banner-url');
      this.bannerSize = $('#ad').data('banner-size');
    },
    fillCurrentImage(imageUrl){
      this.currentImage = imageUrl;
      this.currentImageType = this.currentImage.split('.').pop();
    },

    uploadUrlOf(fileType) {
      if(this.isNewRecord()) {
        return this.fileCreateUrlOf(fileType);
      } else {
        return this.fileUpdateUrlOf(fileType);
      }
    },
    fileCreateUrlOf(fileType) {
      return `/admin/tmp_files?code=${this.fileCode}&file_type=${fileType}`;
    },
    fileUpdateUrlOf(fileType) {
      return `/admin/ads/${this.adId}/files?file_type=${fileType}`;
    },
    isNewRecord() {
      return !this.adId || this.adId == "";
    }

  }
})
