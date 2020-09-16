import Vue from 'vue/dist/vue.esm';

new Vue({
  el: '#material',
  data: {
    adId: $('#ad').data('id'),
    material: $('#ad').data('material'),
    banner: $('#ad').data('banner'),
    currentImage: '',
    currentImageType: '',
  },
  mounted(){
    this.initDropZone();
  },
  methods:{
    initDropZone(){

      let self = this;
      Dropzone.autoDiscover = false;

      var dz = new Dropzone("#m-dropzone-one", {
        maxFiles: 1,
        url: `/admin/ads/${self.adId}/files?file_type=material`,
        acceptedFiles: ".mp4",
        maxFilesize: 100, // MB
        addRemoveLinks: true,
        createImageThumbnails: true
      });

      dz.on("success", function(file){
        var response  = file.xhr.response;
        self.material = response;
        toastr.info('上傳成功', 'Info');
      });

      dz.on("error", function(file, responseText){
        toastr.error(responseText.errors, 'Error');
      });

      var dz = new Dropzone("#m-dropzone-two", {
        url: `/admin/ads/${self.adId}/files?file_type=banner`,
        acceptedFiles: ".jpg,.png,.jpeg,.gif",
        maxFilesize: 10, // MB
        addRemoveLinks: true,
        createImageThumbnails: true
      });

      dz.on("success", function(file){
        var response  = file.xhr.response;
        self.banner = response;
        toastr.info('上傳成功', 'Info');
      });

      dz.on("error", function(file, responseText){
        toastr.error(responseText.errors, 'Error');
      });
    },
    fillCurrentImage(imageUrl){
      this.currentImage = imageUrl;
      this.currentImageType = this.currentImage.split('.').pop();
    }

  }
})
