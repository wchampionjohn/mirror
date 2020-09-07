import Vue from 'vue/dist/vue.esm';
import _              from 'lodash';
import VModal from 'vue-js-modal'

Vue.use(VModal);
new Vue({
  el: '#form',
  data: {
    promotionId: $('#promotion').data('id'),
    materials: $("#promotion").data('materials'),
    pdpMaterial: $("#promotion").data('pdp-material'),
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
          timeout: 600000, // 10.mins
          url: `/admin/promotions/${this.promotionId}/materials/${material.id}`,
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
        var pdpDz = new Dropzone("#pdpMaterial", {
          acceptedFiles: ".mepg, .mpg, .mp4",
          method: 'put',
          maxFilesize: 800, // MB
          maxFiles: 1,
          timeout: 600000, // 10.mins
          url: `/admin/promotions/${this.promotionId}/materials/${this.pdpMaterial.id}`,
          addRemoveLinks: true,
          createImageThumbnails: true
        });

        pdpDz.on("success", function(file){
          var response  = $.parseJSON(file.xhr.response);
          var url       = response.url
          var id       = response.id
          this.removeFile(file);
          toastr.info('上傳成功', 'Info');
          self.updateMaterialPiture(id, url);
            self.checkMaterialsUploaded();
        });

        pdpDz.on("error", function(file, responseText){
          toastr.error(responseText.errors, 'Error');
        });
    },
    updateMaterialPiture(id, url) {
      var currentMaterial = this.materials.find( material => material.id == id)
      console.log(currentMaterial.id)
      currentMaterial.url = url;
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
  }
})
