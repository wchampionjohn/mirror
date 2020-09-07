import Vue from 'vue/dist/vue.esm';
import _              from 'lodash';

new Vue({
  el: '#form',
  data: {
    adId: $('#ad').data('id'),
    materials: $("#materials").data('attributes'),
    showingMaterail: {
      url: '',
      type: ''
    },
  },
  mounted(){
    this.initDropZone();
  },
  methods:{
    initDropZone(){
      this.materials.forEach(material => {
        let self = this;
        Dropzone.autoDiscover = false;

        var dz = new Dropzone("#material-" + material.id, {
          acceptedFiles: ".mp4,.jpg,.png,.jpeg,.gif",
          method: 'put',
          maxFilesize: 800, // MB
          maxFiles: 1,
          url: `/admin/ads/${this.adId}/materials/${material.id}`,
          addRemoveLinks: true,
          createImageThumbnails: true
        });

        dz.on("success", function(file){
          var response  = $.parseJSON(file.xhr.response);
          var url       = response.url
          var id       = response.id
          this.removeFile(file);
          toastr.info('上傳成功', 'Info');
          self.updateMaterialPiture(id, url);

            self.checkMaterialsUploaded();

        });

        dz.on("error", function(file, responseText){
          toastr.error(responseText.errors, 'Error');
        });
      })
    },
    updateMaterialPiture(id, url) {
      var currentMaterial = this.materials.find( material => material.id == id)
      console.log(currentMaterial.id)
      currentMaterial.url = url;
    },
    setShowingMaterial(material) {
      this.showingMaterail.url = material.url;
      this.showingMaterail.isImage = material.is_image;
    },
    checkMaterialsUploaded(){
      location.reload();
    },
    isMaterialsAllUploaded() {
      return this.materials.every((material) => {
        return !!material.url })
    }
  }
})
