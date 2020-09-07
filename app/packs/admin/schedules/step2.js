import Vue            from 'vue/dist/vue.esm';
import queueEditor    from '../../components/schedule/queue_editor.vue'

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
    sessions: $('#current-schedule').data('sessions')
  },
  components: {
    'queue-editor-vue': queueEditor
  }
});
