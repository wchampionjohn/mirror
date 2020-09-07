import Vue            from 'vue/dist/vue.esm';
import queueEditor    from '../../components/platform_schedule/queue_editor.vue'

new Vue({
  el: '#schedule',
  data: {
    ads: $('#current-schedule').data('ads'),
    allNews: $('#current-schedule').data('all-news'),
    queue: $('#current-schedule').data('queue'),
    includePromotion: $('#current-schedule').data('include-promotion'),
    promotion: $('#current-schedule').data('promotion'),
    startAt: $('#current-schedule').data('start-at'),
    endAt: $('#current-schedule').data('end-at'),
    sessions: $('#current-schedule').data('sessions'),
    importedSelectors: $('#current-schedule').data('import-options'),
    selectableImportedRecords: [],
    selectedImportType: null,
    selectedImportOption: null,
  },
  components: {
    'queue-editor-vue': queueEditor
  },
  mounted(){

  },
  methods:{
    setOptionsOfImported() {
      if(this.selectedImportType){
        this.selectableImportedRecords = this.importedSelectors['records'][this.selectedImportType];
        this.selectedImportOption = this.selectableImportedRecords[0][1];
      } else {
        this.selectableImportedRecords = [];
        selectedImportOption = null;
      }
    },
    importFromExisted(){
      let self = this;

      swal({
        title: '確定匯入嗎？匯入後覆蓋正在編輯的內容',
        type: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Yes',
        cancelButtonText: 'No'
      }).then(function (isConfirm) {

        if (isConfirm.value) {

          let myHeaders = new Headers();
          myHeaders.append('Content-Type', 'json');

          let resource = self.selectedImportType == 'regular' ? 'schedules' : 'platform_schedules';
          let url = `/admin/${resource}/${self.selectedImportOption}`

          fetch(url).then((response) => {
            return response.json();
          }).then((sourceSchedule) => {
            self.replaceCurrentScheduleFrom(sourceSchedule)
            toastr.info('匯入完成', 'Info');
          })
        }
      });
    },
    replaceCurrentScheduleFrom(schedule){
      this.sessions = schedule.sessions;
      $("#platform_schedule_name").val(schedule.name);
      $("#platform_schedule_include_promotion").prop('checked', schedule.include_promotion);
    }
  },
  watch: {
    selectedImportType: 'setOptionsOfImported'
  }
});
