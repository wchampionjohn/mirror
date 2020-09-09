import Vue from 'vue/dist/vue.esm';

new Vue({
  el: '#submitting',
  data: {
    services:[],
    discount_card: '',
    storeId: $('#store_id').val(),
    currentImage: '',
  },
  mounted(){
    this.initDropZone();
  },
  created() {
    this.fetchContracts();
  },
  methods:{
    fetchContracts(){
      let self = this;
      $.ajax({
        url: '/stores/' + self.storeId,
        dataType: 'json'
      }).done(function(result){
        self.discount_card = result.discount_card
        self.services = result.services
      })
    },
    initDropZone(){

      let self = this;
      Dropzone.autoDiscover = false;

      var dz = new Dropzone("#m-dropzone-one", {
        maxFiles: 1,
        url: "/stores/" + self.storeId + "/discounts",
        addRemoveLinks: true,
        createImageThumbnails: true
      });

      dz.on("success", function(file){
        var response  = $.parseJSON(file.xhr.response);
        var url      = $.parseJSON(response.discount_card_url);

        this.removeFile(file);

        toastr.info('uploaded successfully', 'Info');
        self.discount_card = url
      });

      dz.on("error", function(file, responseText){
        toastr.error(responseText.errors, 'Error');
      });

      var dz = new Dropzone("#m-dropzone-two", {
        url: "/stores/" + this.storeId + "/services",
        addRemoveLinks: false,
        createImageThumbnails: false
      });

      dz.on("success", function(file){
        var response  = $.parseJSON(file.xhr.response);
        var data      = $.parseJSON(response.service);

        this.removeFile(file);

        toastr.info('uploaded successfully', 'Info');
        self.services.push(data);
      });

      dz.on("error", function(file, responseText){
        toastr.error(responseText.errors, 'Error');
      });
    },
    removeAttachment(id) {
      let self = this;

      swal({
        title: 'Are you sure delete this file?',
        type: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Yes',
        cancelButtonText: 'No'
      }).then(function (isConfirm) {

        if (isConfirm.value) {
          $.ajax({
            type: "DELETE",
            url: "/stores/" + self.storeId + "/services/" + id
          }).done(function() {

            self.services = self.services.filter(service => service.id !== id)
            toastr.info('deleted successfully', 'Info');
          })
        }

      })

    },
    removeDiscountCard(){
      let self = this;

      swal({
        title: 'Are you sure delete this file?',
        type: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Yes',
        cancelButtonText: 'No'
      }).then(function (isConfirm) {

        if (isConfirm.value) {
          $.ajax({
            type: "DELETE",
            url: "/stores/" + self.storeId + "/discounts/" + self.storeId
          }).done(function() {
            self.discount_card = ""
            toastr.info('deleted successfully', 'Info');
          })
        }

      })
    },
    fillCurrentImage(imageUrl){
      this.currentImage = imageUrl
    }

  }
})
