import Vue from 'vue/dist/vue.esm';

new Vue({
  el: '#menu',
  data: {
    serviceImages: [],
    informationImages: [],
    storeId: $('#store_id').val(),
    currentImage: '',
  },
  mounted(){
    this.initDropZone();
  },
  created() {
    this.fetchImages();
  },
  methods:{
    fetchImages(){
      let self = this;
      $.ajax({
        url: `/admin/stores/${self.storeId}/introductions`,
        dataType: 'json'
      }).done(function(response){
        response.data.forEach((image) => {
          self.pushImages(image);
        });
      })
    },
    initDropZone(){

      let self = this;
      Dropzone.autoDiscover = false;

      var dz = new Dropzone("#m-dropzone-one", {
        maxFiles: 1,
        url: `/admin/stores/${self.storeId}/introductions?type=information`,
        acceptedFiles: ".jpg,.png,.jpeg,.gif",
        maxFilesize: 10, // MB
        addRemoveLinks: true,
        createImageThumbnails: true
      });

      dz.on("success", function(file){
        var response  = $.parseJSON(file.xhr.response);
        self.pushImages(response)
        this.removeFile(file);
        toastr.info('上傳成功', 'Info');
      });

      dz.on("error", function(file, responseText){
        toastr.error(responseText.errors, 'Error');
      });

      var dz = new Dropzone("#m-dropzone-two", {
        url: `/admin/stores/${self.storeId}/introductions?type=service`,
        acceptedFiles: ".jpg,.png,.jpeg,.gif",
        maxFilesize: 10, // MB
        addRemoveLinks: false,
        createImageThumbnails: false
      });

      dz.on("success", function(file){
        var response  = $.parseJSON(file.xhr.response);
        self.pushImages(response)
        this.removeFile(file);
        toastr.info('上傳成功', 'Info');
      });

      dz.on("error", function(file, responseText){
        toastr.error(responseText.errors, 'Error');
      });
    },
    removeImage(image) {
      let self = this;

      swal({
        title: '確定要刪除此檔案嗎?',
        type: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Yes',
        cancelButtonText: 'No'
      }).then(function (isConfirm) {

        if (isConfirm.value) {
          $.ajax({
            type: "DELETE",
            url: `/admin/stores/${self.storeId}/introductions/${image.id}`,
          }).done(function() {

            self.removeImages(image);
            toastr.info('刪除成功', 'Info');
          })
        }
      })

    },
    pushImages(image){
      if(image.menu_type == 'information') {
        this.informationImages.push(image);
      } else {
        this.serviceImages.push(image);
      }
    },
    removeImages(image) {
      if(image.menu_type == 'information'){
        this.informationImages = this.informationImages.filter(imagre => imagre.id !== image.id)
      } else {
        this.serviceImages = this.serviceImages.filter(imagre => imagre.id !== image.id)
      }
    },
    fillCurrentImage(imageUrl){
      this.currentImage = imageUrl
    }

  }
})
