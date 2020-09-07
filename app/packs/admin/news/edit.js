import Vue from 'vue/dist/vue.esm';
import _              from 'lodash';
import VModal from 'vue-js-modal'

Vue.use(VModal);
new Vue({
  el: '#form',
  data: {
    newsId: $('#news').data('id'),
    materials: $("#news").data('materials'),
    pdpMaterial: $("#news").data('pdp-material'),
    environment: $("#config").data('environment'),
    showingMaterail: {
      url: '',
      type: ''
    },
  },
  mounted(){
    this.initDropZone();
  },
  components: {
    VModal
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
          timeout: 600000,
          url: `/admin/news/${this.newsId}/materials/${material.id}`,
          addRemoveLinks: true,
          createImageThumbnails: true
        });

        dz.on("success", function(file){
          var response  = $.parseJSON(file.xhr.response);
          var url       = response.url
          var id       = response.id
          var isImage       = response.is_image
          this.removeFile(file);
          toastr.info('上傳成功', 'Info');
          self.updateMaterialPiture(response);
        });

        dz.on("error", function(file, responseText){
          toastr.error(responseText.errors, 'Error');
        });

      })

      let self = this;
      var pdpDz = new Dropzone("#pdpMaterial", {
        acceptedFiles: ".mepg, .mpg",
        method: 'put',
        maxFilesize: 800, // MB
        maxFiles: 1,
        timeout: 600000,
        url: `/admin/news/${this.newsId}/materials/${this.pdpMaterial.id}?is_pdp=1`,
        addRemoveLinks: true,
        createImageThumbnails: true
      });

      pdpDz.on("success", function(file){
        var response  = $.parseJSON(file.xhr.response);
        var url       = response.url
        var id       = response.id
        this.removeFile(file);
        toastr.info('上傳成功', 'Info');
        self.updateMaterialPiture(response);
      });

      pdpDz.on("error", function(file, responseText){
        toastr.error(responseText.errors, 'Error');
      });
    },
    updateMaterialPiture(updatedMaterial) {
      var currentMaterial = this.materials.find( material => material.id == updatedMaterial.id)
      currentMaterial.id = updatedMaterial.id;
      currentMaterial.url = updatedMaterial.url;
      currentMaterial.is_image = updatedMaterial.is_image;
      currentMaterial.updated_at = updatedMaterial.updated_at;
      currentMaterial.is_updated = true;
    },
    setShowingMaterial(material) {
      this.showingMaterail.url = material.url;
      this.showingMaterail.isImage = material.is_image;
      this.$modal.show('profile')
    },
    checkMaterialsUploaded(){
      location.reload();
    },
    isMaterialsAllUploaded() {
      return this.materials.every((material) => {
        return !!material.url })
    },
    renderResolution(material) {
      return `<i class="flaticon-app"></i> 素材尺寸：[${material.ratio}] ${material.resolutions.join('、')}`
    },
    uploaderUrl(){
      if(this.environment == 'development') {
        return '/admin/news'
      } else {
        return 'https://metro-files.solmate.cc/admin/news'
      }
    }
  }
})
