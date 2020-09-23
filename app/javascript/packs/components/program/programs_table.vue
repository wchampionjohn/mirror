<template>
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
        更新時間
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
  <tr v-for="program in activePrograms" @dblclick="edit(program)" v-if="program.is_active">
    <td>
      <a :href="program.display_file_url" target="_blank" v-if="!isEditing(program)">
        {{program.name}}
      </a>
      <input type="text" name="program['name']" class="form-control" v-model="editingProgram.name" @keyup.enter="save" @keyup.esc="cancel" v-else />
    </td>
    <td>
      <template v-if="!isEditing(program)">{{program.seconds}}</template>
      <input type="number" name="program['seconds']" class="form-control" @keyup.enter="save" @keyup.esc="cancel" v-model="editingProgram.seconds" v-else />
    </td>
    <td v-html="program.updated_at"></td>
    <td>
      <template v-if="!isEditing(program)">
        <a href="javascript:void(0)" @click="suspend(program.id)"><i class="la la-pause m--font-info"></i></a>
      </template>
      <template v-if="isEditing(program)">
        <a href="javascript:void(0)" @click="cancel()"><i class="la la-refresh m--font-info"></i></a>
        <a href="javascript:void(0)" @click="save()"><i class="la la-save m--font-info"></i></a>
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
</template>

<script>
import draggable from "vuedraggable";

let idGlobal = 8;
export default {
  name: "programs-table",
  display: "Programs table",
  order: 3,
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
  },
  methods:{
    isEditing(program) {
      return this.editingProgram.id == program.id;
    },
    edit(program) {
      if(this.editingProgram.id != program.id) {
        this.editingProgram = Object.assign({}, program);
      }
    },
    save() {
      let self = this;
      let updatedData = JSON.stringify({ name: self.editingProgram.name, seconds: self.editingProgram.seconds })

      $.ajax({
        type: "PUT",
        dataType: "json",
        contentType: "application/json;charset=utf-8",
        url: "/admin/channels/" + self.channel + "/programs/" + self.editingProgram.id,
        data: updatedData
      }).done(function() {

        self.activePrograms = self.activePrograms.map(program => {
          if(program.id == self.editingProgram.id) {
            return self.editingProgram;
          } else {
            return program;
          }
        })

        toastr.info('saved', 'Info');
        self.editingProgram = {};
      }).fail(function(message) {
        console.log(message)
      })

    },
    cancel() {
      this.editingProgram = {};
    },
    suspend(programId) {
      let self = this;

      swal({
        title: 'Are you sure suspend this program?',
        type: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Yes',
        cancelButtonText: 'No'
      }).then(function (isConfirm) {
        if (isConfirm.value) {
          $.ajax({
            type: "PUT",
            url: "/admin/channels/" + self.channel + "/programs/" + programId + '/suspend'
          }).done(function() {

            self.activePrograms = self.activePrograms.map(program => {
              if(programId == program.id) {
                program.is_active = false;
              }

              return program;
            })
            toastr.info('deleted', 'Info');
          }).fail(function(message) {
            console.log(message)
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
      }).fail(function(message) {
        console.log(message)
      })
    },
    totalSeconds() {
      return this.activePrograms.reduce((accumulator, program) => {
        if(program.is_active) {
          return  accumulator += parseInt(program.seconds);
        } else {
          return accumulator
        }
      },0)
    }
  }
};
</script>
