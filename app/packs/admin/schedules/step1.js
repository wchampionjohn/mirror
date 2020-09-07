import Vue            from 'vue/dist/vue.esm';
import VueTimepicker from 'vue2-timepicker'
import 'vue2-timepicker/dist/VueTimepicker.css'

new Vue({
  el: '#repeater',
  data: {
    sessions: $('#sessions').data('attributes'),
  },
  components: { VueTimepicker },
  mounted(){
    var self = this

    $('.session-start').timepicker({
      timeFormat: 'mm p',
      autoclose: true,
      minuteStep: 30,
    }).on('changeTime.timepicker', function(e) {
      var index = parseInt(e.target.dataset.num);
      self.sessions[index].start_at =  e.time.value;
    });
  },
  methods: {
    addSession(id){
      this.sessions.push(this.sessionStructure());

      this.$nextTick(function () {
        this.initializeTimepicker();
      });
    },
    deleteSession(target) {
      var sessions = this.sessions.map((session, index) => {
        if(index == target) {
          session._destroy = true;
        }
        return session;
      });

      this.sessions = sessions.filter((session) => {
        return !session._destroy || session.id;
      });

      this.$nextTick(function () {
        this.initializeTimepicker();
      });
    },
    sessionStructure() {
      return {
        id: null,
        start_at: '12:00 AM',
        _destroy: null
      }
    },
    visiableSessions(){
      return this.sessions.filter((session) => {
        return !session._destroy || session.id;
      });
    },
    isAvailable(session){
      return !session._destroy;
    },
    initializeTimepicker() {
      var self = this;
      $('.session-start:last').timepicker({
        timeFormat: 'mm p',
        autoclose: true,
        minuteStep: 30,
      }).on('changeTime.timepicker', function(e) {
        var index = parseInt(e.target.dataset.num);
        self.sessions[index].start_at =  e.time.value;
      });
    }

  }
});
