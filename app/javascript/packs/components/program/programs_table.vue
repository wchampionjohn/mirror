<template>
  <div>

  <table class="table table-striped m-table">
    <thead>
      <tr>
        <th width="35%">
          名稱
        </th>
        <th width="15%">
          長度(秒)
        </th>
        <th width="20%">
          預覽圖
        </th>
        <th width="15%">
          操作
        </th>
      </tr>
    </thead>
    <draggable
            tag="tbody"
            :list="activePrograms"
            @end="rearrange">
    <tr v-for="program in activePrograms" v-if="program.is_active">
      <td>
        <a :href="program.video_url" target="_blank">
          {{program.name}}
        </a>
      </td>
      <td v-html="program.seconds">
      </td>
      <td>
        <img :src="program.current_screenshot.url" alt="100%x200" style="width: 96px; height: 54px;" v-if="program.current_screenshot" />
      </td>
      <td>
        <template>
          <a href="javascript:void(0)" class="btn btn-secondary m-btn btn-sm m-btn--icon m-btn--icon-only mt-2" @click="edit(program)">
            <i class="la la-pencil"  data-placement="left" data-toggle="modal" data-target="#m_modal" ></i>
          </a>
          <a href="javascript:void(0)" class="btn btn-secondary m-btn btn-sm m-btn--icon m-btn--icon-only mt-2" @click="suspend(program.id)">
            <i class="la la-pause"></i>
          </a>
        </template>
      </td>
    </tr>
    <tr v-if="activePrograms.length == 0">
      <td colspan="5">未任何節目</td>
    </tr>
    </draggable>
    <tr v-if="activePrograms.length > 0">
      <td><b>總秒數</b></td>
      <td colspan="5" v-html="totalSeconds()"></td>
    </tr>
  </table>

  <div class="modal fade" id="m_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" v-show="editingProgram">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header"><h5 id="exampleModalLabel" class="modal-title" >
            <span class="m--font-focus" v-html="editingProgram.name">
            </span>
            <!----></h5> <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true">
              ×
            </span></button></div>
            <div class="modal-body">
              <div class="modal-file" >
                <div class="form-group m-form__group row" align="center">
                  <div class="col-lg-12">影片</div>
                  <div class="col-lg-12 mb-2">
                    <video controls muted="muted" width="400" height="250" :src="editingProgram.video_url" >
                    </video>
                  </div>
                </div>
              </div>
              <div class="form-group m-form__group row">
                <div class="col-lg-1 ">
                </div>
                <div class="col-lg-10">
                  <label class="form-control-label"><i class="flaticon-laptop"></i>
                    名稱:
                  </label>
                  <input type="text" name="product['name']" class="form-control" v-model="editingProgram.name" required>
                </div>
                <div class="col-lg-1">
                </div>
              </div>
              <div class="form-group m-form__group row">
                <div class="col-lg-1 ">
                </div>
                <div class="col-lg-10">
                  <label class="form-control-label"><i class="flaticon-time-1"></i>
                    影片長度(秒):
                  </label>
                  <input type="number" name="product['seconds']" class="form-control" v-model="editingProgram.seconds" required>
                </div>
                <div class="col-lg-1">
                </div>
              </div>

              <div class="form-group m-form__group row">
                <div class="col-lg-1 ">
                </div>
                <div class="col-lg-10">
                  <label class="form-control-label"><i class="flaticon-time-1"></i>
                    上傳預覽圖:
                  </label>
                  <br />

                  <div id="screenshot" class="m-dropzone dropzone dz-clickable">
                    <div class="m-dropzone__msg dz-message needsclick" >
                      <h5 style="display:inline-block;">
                        請拖曳檔案或點擊上傳
                      </h5>
                      <p>允許格式: JPEG、JPG、PNG、GIF <br />檔案大小限制: 10MB</p>
                    </div>
                  </div>
                </div>
              </div>
              <div class="form-group m-form__group row">
                <div class="col-lg-1 ">
                </div>
                <div class="col-lg-10">
                  <label class="form-control-label"><i class="flaticon-imac"></i>
                    預覽圖:
                  </label>
                  <div class="row">
                  <div class="col-md-4 px-1 pb-2 pt-2 border" style="border-width:2px !important;"  v-for="screenshot in editingProgram.screenshots" v-bind:class="{ 'border-danger border-5': screenshot.id == editingProgram.current_screenshot.id}">
                    <img :src="screenshot.url" alt="100%x200" class="md-2" style="width: 98%; height: 120px; display: block;">
                    <a :href="screenshot.url" target="_blank" class="btn btn-outline-brand m-btn btn-sm m-btn--icon m-btn--icon-only mt-2">
                      <i class="la la-external-link"></i>
                    </a>
                    <button @click="changeCurrentScreenshot(screenshot)" class="btn btn-outline-brand m-btn btn-sm m-btn--icon m-btn--icon-only mt-2"><i class="la la-cog"></i></button>
                    <button @click="removeScreenshot(screenshot)" class="btn btn-outline-brand m-btn btn-sm m-btn--icon m-btn--icon-only mt-2"><i class="la la-trash"></i></button>
                  </div>
                  </div>
                </div>
                <div class="col-lg-1">
                </div>
              </div>
              <div class="form-group m-form__group row">
                <div class="col-lg-1 ">
                </div>
                <div class="col-lg-10">
                  <label class="form-control-label"><i class="flaticon-edit-1"></i>
                    最後更新時間:
                  </label> <div class="m--font-bolder form-control" style="border:0px" v-html="editingProgram.updated_at">2020-10-10</div>
                </div>
                <div class="col-lg-1">
                </div>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-dismiss="modal">
                關閉
              </button>
              <button type="button" value="送出" class="btn btn-danger" @click="save()">
                儲存
              </button>
            </div>
      </div>
    </div>
  </div>
  </div>
</template>

<script>
import draggable from "vuedraggable";

let idGlobal = 8;
export default {
  name: "programs-table",
  display: "Programs table",
  components: {
    draggable
  },
    props: {
    rows: Array,
    channel: Number,
  },
  data() {
    return {
      activePrograms: [],
      editingProgram: {}
    };
  },
  created() {
    this.activePrograms = this.rows;
    Dropzone.autoDiscover = false;
    var self = this;

    Dropzone.options.screenshot = {
      init: function() {
        this.on("processing", (file) => {
          this.options.url = `/admin/channels/${self.channel}/programs/${self.editingProgram.id}/screenshot`;
        });
        this.on("success", (file) => {
          var createdScreenshot  = JSON.parse(file.xhr.response);
          self.appendScreenshot(createdScreenshot);
          this.removeFile(file);
          toastr.info('上傳成功', 'Info');
        });
      }
    }
  },
  mounted() {
    let self = this;

    $('#screenshot').dropzone({
      url: '/',
      acceptedFiles: ".jpg,.png,.jpeg,.gif",
      maxFilesize: 10, // MB
      addRemoveLinks: true,
      createImageThumbnails: true
    });
  },
  methods:{
    isEditing(program) {
      return this.editingProgram.id == program.id;
    },
    edit(program) {
      this.editingProgram = Object.assign({}, program);
    },
    save() {
      let self = this;
      let updatedData = {
        name: self.editingProgram.name,
        seconds: self.editingProgram.seconds,
        screenshot_id: self.editingProgram.current_screenshot.id,
        screenshot_ids:  this.editingProgram.screenshots.map(screenshot => screenshot.id)
      }

      $.ajax({
        type: "PUT",
        dataType: "json",
        contentType: "application/json;charset=utf-8",
        processData: false,
        data: JSON.stringify(updatedData),
        url: "/admin/channels/" + self.channel + "/programs/" + self.editingProgram.id,
      }).done(() => {

        $('#m_modal').modal('hide');

        toastr.info('已儲存', 'Info');
        self.syncAppendedScreenshotToActivePrograms();
        self.editingProgram = {}
      })

    },
    cancel() {
      this.editingProgram = {};
    },
    suspend(programId) {
      let self = this;

      swal({
        title: '確定下架此節目嗎?',
        type: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Yes',
        cancelButtonText: 'No'
      }).then((isConfirm) => {
        if (isConfirm.value) {
          $.ajax({
            type: "PUT",
            url: "/admin/channels/" + self.channel + "/programs/" + programId + '/suspend'
          }).done(() => {

            self.activePrograms = self.activePrograms.map(program => {
              if(programId == program.id) {
                program.is_active = false;
                program.updated_at = moment().format('YYYY-MM-DD hh:mm:ss');
              }

              return program;
            })
            toastr.info('節目已下架', 'Info');
          })
        }
      })
    },
    rearrange() {
      let ids = this.activePrograms.map(program => program.id);
      let rearrandedData = JSON.stringify({ ids: ids});

      $.ajax({
        type: "PUT",
        url: `/admin/channels/${this.channel}/programs/rearrange`,
        dataType: "json",
        contentType: "application/json;charset=utf-8",
        data: rearrandedData
      })
    },
    totalSeconds() {
      return this.activePrograms.reduce((accumulator, program) => {
        if(program.is_active) {
          accumulator += parseInt(program.seconds);
        }

        return accumulator;
      },0)
    },
    removeScreenshot(wiilRemovedScreenshot) {
      this.editingProgram.screenshots = this.editingProgram.screenshots.filter(
        screenshot => screenshot != wiilRemovedScreenshot
      )
    },
    changeCurrentScreenshot(willChangedScreenshot) {
      this.editingProgram.current_screenshot = willChangedScreenshot;
    },
    syncEditingProgramToActivePrograms() {
      this.activePrograms = this.activePrograms.map(program => {
        if(program.id == this.editingProgram.id) {
          return this.editingProgram;
        } else {
          return program;
        }
      })
    },
    syncAppendedScreenshotToActivePrograms() {
      this.activePrograms = this.activePrograms.map(program => {
        if(program.id == this.editingProgram.id) {
          return this.editingProgram;
        } else {
          return program;
        }
      })
    },
    appendScreenshot(newScreenshot) {
      this.editingProgram.screenshots.push(newScreenshot);
      this.editingProgram.current_screenshot = newScreenshot;

      this.activePrograms = this.activePrograms.map(program => {
        if(this.editingProgram.id == program.id) {
          program.current_screenshot = newScreenshot;
        }
        return program;
      })
    }

  }
};
</script>
