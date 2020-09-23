import Vue from 'vue/dist/vue.esm';
import programsTable from "../../../components/program/programs_table";

new Vue({
  el: '[data-behavior="app"]',
  data: {
    programs: $('#channel').data('programs'),
    channelId: $('#channel').data('id'),
  },
  components: {
    'programs-table-vue': programsTable
  },
  mounted(){
    this.initDropZone();
  },
  methods:{
    initDropZone(){
      let self = this;
      Dropzone.autoDiscover = false;

      var dz = new Dropzone("#m-dropzone-one", {
        url: "/admin/channels/" + this.channelId + "/programs",
        acceptedFiles: ".mp4",
        maxFilesize: 100, // MB
        maxFiles: 5,
        timeout: 600000,
        addRemoveLinks: false,
        createImageThumbnails: false
      });

      dz.on("success", function(file){
        var response  = $.parseJSON(file.xhr.response);
        var uploadedProgram      = $.parseJSON(response.program);

        this.removeFile(file);

        toastr.info('uploaded successfully', 'Info');
        self.programs.push(uploadedProgram);
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
            url: "/admin/channels/" + self.channedId + "/programs/" + id
          }).done(function() {

            self.programs = self.programs.filter(row => row.id !== id)
            toastr.info('deleted successfully', 'Info');
          })
        }

      })
    },
    inactivePrograms(){
      return this.programs.filter(program => !program.is_active);
    },
    destroy(programId){
      let self = this;

      swal({
        title: 'Are you sure delete this program?',
        type: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Yes',
        cancelButtonText: 'No'
      }).then(function (isConfirm) {

        if (isConfirm.value) {

          $.ajax({
            type: "DELETE",
            url: "/admin/channels/" + self.channelId + "/programs/" + programId
          }).done(function() {
            self.programs = self.programs.filter(program => program.id != programId);
            toastr.info('deleted successfully', 'Info');
          }).fail(function(message) {
            console.log(message)
          })

        }
      })
    },
    recover(programId){
      let self = this;

      swal({
        title: 'Are you sure recover this program?',
        type: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Yes',
        cancelButtonText: 'No'
      }).then(function (isConfirm) {

        if (isConfirm.value) {
          $.ajax({
            type: "PUT",
            url: "/admin/channels/" + self.channelId + "/programs/" + programId + '/recover'
          }).done(function() {

            self.programs = self.programs.map(program => {
              if(programId == program.id) {
                program.is_active = true;
              }

              return program;
            })
          }).fail(function(message) {
            console.log(message)
          })
        }
      })
    }
  }
})
