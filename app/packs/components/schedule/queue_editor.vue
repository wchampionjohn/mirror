<template>
  <div class="row">
    <template v-for="queue in queues">
      <input type="hidden" name="schedule[sessions_attributes][][id]" :value="queue.id">
      <input type="hidden" name="schedule[sessions_attributes][][queue]" :value="idsOf(queue)">
    </template>
    <div class="col-lg-6">
      <!--begin::Portlet-->
      <div class="m-portlet" id="m_portlet">
        <div class="m-portlet__head">
          <div class="m-portlet__head-caption">
            <div class="m-portlet__head-title">
              <span class="m-portlet__head-icon">
                <i class="flaticon-add"></i>
              </span>
              <h3 class="m-portlet__head-text">
                素材清單
              </h3>
            </div>
          </div>
        </div>
        <div class="m-portlet__body">
          <div class="m-form__group ">
            <div class="m-form__control">
              <div class="m-input-icon m-input-icon--left search-center mb-4">
                <input
                   type="text"
                   class="form-control m-input m-input--solid"
                   placeholder="可直接輸入關鍵字搜尋廣告"
                   v-model="keyword"
                   id="generalSearch">
                <span class="m-input-icon__icon m-input-icon__icon--left">
                  <span>
                    <i class="la la-search"></i>
                  </span>
                </span>
              </div>
            </div>
          </div>
          <div id="m_calendar_external_events" class="fc-unthemed">
            <div class="form-group m-form__group m--align-center pb-0">
              <div class="alert m-alert m-alert--default mb-0" role="alert">
                <span class="m--font-primary m--font-boldest">廣告區</span>
              </div>
            </div>
            <div class="fc-event m--margin-bottom-15">
              <div class="fc-title">
                <div class="fc-content">
                  <table class="table table-striped m-table">
                    <thead>
                      <tr class="m-table__row--primary">
                        <th>
                          廣告編號
                        </th>
                        <th>
                          示意圖
                        </th>
                        <th>
                          廣告名稱
                        </th>
                        <th>
                          秒數
                        </th>
                        <th width="80px">
                          操作
                        </th>
                      </tr>
                    </thead>
                    <draggable
                            :group="{ name: 'ads', pull: 'clone', put: false }"
                            :list="ads"
                            tag="tbody"
                            @change="log">
                    <tr v-for="ad in visibleAds" :key="ad.id">
                      <td data-toggle="m-tooltip" data-html="true" :data-original-title="moreInfo(ad)" v-html="ad.sn"></td>
                      <td v-html="preview(ad.material_sample_url)"></td>
                      <td v-html="renderCell(ad, 'name')"></td>
                      <td v-html="ad.seconds"></td>
                      <td>
                        <i data-toggle="m-tooltip" data-original-title="回收" class="la la-arrow-circle-o-left m--font-primary" @click="removeFromQueue(ad.id)"></i>
                        <i data-toggle="m-tooltip" data-original-title="新增" class="la la-arrow-circle-o-right m--font-primary" @click="appendToQueue(ad)"></i>
                      </td>
                    </tr>
                    </draggable>
                  </table>
                </div>
              </div>
            </div>

            <div class="m-separator m-separator--dashed m-separator--space"></div>
          </div>

          <div class="form-group m-form__group m--align-center pb-0">
            <div class="alert m-alert m-alert--default mb-0" role="alert">
              <span class="m--font-danger m--font-boldest">節目新聞區</span>
            </div>
          </div>
            <div class="fc-event m--margin-bottom-15">
              <div class="fc-title">
                <div class="fc-content">
                  <table class="table table-striped m-table">
                    <thead>
                      <tr class="m-table__row--accent">
                        <th>
                          編號
                        </th>
                        <th>
                          示意圖
                        </th>
                        <th>
                          名稱
                        </th>
                        <th>
                          秒數
                        </th>
                        <th width="80px">
                          操作
                        </th>
                      </tr>
                    </thead>
                    <draggable
                            :group="{ name: 'ads', pull: 'clone', put: false }"
                            :list="allNews"
                            tag="tbody"
                            @change="log">
                    <tr v-for="news in allNews" :key="news.id">
                      <td v-html="news.id"></td>
                      <td v-html="preview(news.material_sample_url)"></td>
                      <td v-html="news.name"></td>
                      <td v-html="news.seconds"></td>
                      <td>
                        <i class="la la-arrow-circle-o-left m--font-primary" @click="removeFromQueue(news.id)"></i>
                        <i class="la la-arrow-circle-o-right m--font-primary" @click="appendToQueue(news)"></i>
                      </td>
                    </tr>
                    </draggable>
                  </table>
                </div>
              </div>
            </div>
        </div>
      </div>
      <!--end::Portlet-->
    </div>

    <div class="col-lg-6">
      <!--begin::Portlet-->
      <div class="m-portlet" id="m_portlet">
        <div class="m-portlet__head">
          <div class="m-portlet__head-caption">
            <div class="m-portlet__head-title">
              <span class="m-portlet__head-icon">
                <i class="flaticon-calendar-2"></i>
              </span><br>
              <h3 class="m-portlet__head-text">
                輪播排程表
              </h3>
            </div>
          </div>
        </div>

        <template v-for="(queue, index) in queues">
          <div class="m-portlet m-portlet--head-solid-bg m-portlet--head-sm" :class="(index % 2) == 0 ? 'm-portlet--primary' : 'm-portlet--success'">
            <div class="m-portlet__head">
              <div class="m-portlet__head-caption">
                <div class="m-portlet__head-title">
                  <span class="m-portlet__head-icon">
                    <i class="flaticon-stopwatch"></i>
                  </span>
                  <h6 class="m-portlet__head-text">
                    <font v-html="queueTitle(queue)">
                      06:00 -11:29
                    </font>
                    <small class="m--font-danger" v-if="queue.error" v-html="queue.error">請選擇廣告</small>
                  </h6>
                </div>
              </div>
              <div class="m-portlet__head-tools">
                <ul class="m-portlet__nav">
                  <li class="m-portlet__nav-item">
                    <a href="javascript:void(0)" @click="copy(queue.id)" v-if="queue.rows.length > 0" data-toggle="m-tooltip" data-original-title="複製" class="m-portlet__nav-link m-portlet__nav-link--icon">
                      <i class="fa fa-copy"></i>
                    </a>
                    <a href="javascript:void(0)" @click="paste(queue.id)"  data-toggle="m-tooltip" data-original-title="貼上" class="m-portlet__nav-link m-portlet__nav-link--icon">
                      <i class="fa fa-paste"></i>
                    </a>
                    <a href="javascript:void(0)" @click="setCurrentQueue(queue.id)" data-portlet-tool="toggle" class="m-portlet__nav-link m-portlet__nav-link--icon">
                      <i class="la" :class="currentQueue.id == queue.id ? 'la-angle-up' : 'la-angle-down'"></i>
                    </a>
                  </li>
                </ul>
              </div>
            </div>

            <div class="m-portlet__body" v-show="queue.id == currentQueue.id">
              <span class="m--font-primary m--font-boldest" v-html="summary(queue)"></span>
              <table class="table table-striped m-table">
                <thead>
                  <tr>
                    <th>
                      編號
                    </th>
                    <th>
                      示意圖
                    </th>
                    <th>
                      名稱
                    </th>
                    <th>
                      秒數
                    </th>
                    <th>
                      操作
                    </th>
                  </tr>
                </thead>
                <tr class="m-table__row--warning" v-if="includePromotion">
                  <td>
                  </td>
                  <td v-html="preview(promotion.url)"></td>
                  <td style="width: 120px" v-html="promotion.name">
                    好康報報
                  </td>
                  <td v-html="promotion.seconds">
                    300
                  </td>
                  <td>
                  </td>
                </tr>
                <draggable
                     tag="tbody"
                     :group="{ name: 'ads' }"
                     :list="queue.rows"
                     @change="log">
                <tr v-for="(row, num) in queue.rows" v-bind:class="{ 'm-table__row--accent': isNews(row.id) }">
                  <td v-html="row.sn">
                  </td>
                  <td v-html="preview(row.material_sample_url)"></td>
                  <td v-html="row.name">
                  </td>
                  <td v-html="secondsOf(row.seconds, num)">
                  </td>
                  <td>
                    <i data-toggle="m-tooltip" data-original-title="新增" class="fa fa-plus" @click="cloneQueueAt(num, row)"></i>
                    <i data-toggle="m-tooltip" data-original-title="刪除" class="la la-trash" @click="removeQueueAt(num)"></i>
                  </td>
                </tr>
                </draggable>
              </table>
              <!--end: datatable -->
            </div>

          </div>
          <br />
        </template>
      </div>
      <!--end::Portlet-->
    </div>
  </div>
</template>

<script>
import draggable from "vuedraggable";
import { event } from '../../shared/event_hub';
import _              from 'lodash';

export default {
  name: "schedule-arranger",
  components: {
    draggable
  },
  props: {
    startAt: String,
    ads: Array,
    allNews: Array,
    sessions: Array,
    promotion: Object,
    includePromotion: Boolean

  },
  data() {
    return {
      queues: [],
      currentQueue: [],
      keyword: '',
      searchPlaceholder: ['name', 'sn'],
      clipboard: [],
      visibleAds: []
    };
  },
  created() {
  },
  mounted: function(){
    $('[data-toggle="m-tooltip"]').tooltip()
    this.initializeQueues();
    this.initializeCurrentQueue();
    this.visibleAds = this.ads;
  },
  methods: {
    log: function(evt) {
      window.console.log(evt);
    },
    removeQueueAt(num) {
      this.currentQueue.rows.splice(num, 1);
    },
    cloneQueueAt(num, row){
      this.currentQueue.rows.splice(num, 0, row);
    },
    queueSeconds(queue) {
      var bottomLine = this.bottomLineOfQueue();
      var self = this
      return this.currentQueue.rows.reduce((sum, row) => {
        var seconds = row.seconds
        return seconds == null ? sum : sum + parseInt(seconds);
      }, bottomLine);
    },
    appendToQueue(row) {
      this.currentQueue.rows.push(row);
    },
    removeFromQueue(id) {
      this.currentQueue.rows = this.currentQueue.rows.filter((row) => {
        return row.id != id;
      })
      return true;
    },
    renderCell(ad, column){
      let content = ad[column]
      if(this.isFilterable(column)){
        content = this.columnRender(content, this.keyword)
      }

      return content
    },
    filterByKeyword(keyword) {
      this.visibleAds = this.ads.filter((ad) => {
        return ad.name.includes(keyword) || ad.sn.includes(keyword);
      })
    },
    columnRender: function(text, keyword){ // for hightlight
      if(text && text != '') {
        return text.replace(new RegExp(keyword, 'gi'), '<span class="text-danger">$&</span>');
      } else {
        return '';
      }
    },
    isFilterable(column){
      if(!this.keyword) {
        return false;
      }

      return this.searchPlaceholder.indexOf(column) > -1
    },
    period(ad) {
      const startAt = ad.start_at > this.startAt ? `<span class="text-danger">${ad.start_at}</span>` : ad.start_at
      return `<td>${startAt}</td>`;
    },
    summary(queue) {
      return `總長度：${this.queueSeconds(queue)}秒     總篇數：${this.lengthOf(queue)}則`
    },
    queueTitle(queue) {
      return `${queue.period} (${this.lengthOf(queue)})`
    },
    moreInfo(ad) {
      let result = '';
      if(ad.product_name) {
        result = result.concat(`商品名稱:${ad.product_name} <br />`);
      }
      result = result.concat(`類別:${ad.category_name} <br />`);
      result = result.concat(`開始時間:${ad.start_at} <br />`);
      return result;
    },
    renderAdSn(ad) {
      let result = '';
      if(ad.start_at > this.startAt || ad.end_at < this.endAt) {
        result = result.concat('<i class="text-warning la la-warning"></i> ');
      }

      result = result.concat(this.renderCell(ad, 'sn'));
      return result;
    },
    initializeCurrentQueue(){
      this.currentQueue = this.queues[0];
    },
    setCurrentQueue(id) {
      if(this.currentQueue.id == id) {
        this.currentQueue = {
          id: null,
          rows:[]
        };
      } else {
        this.currentQueue = this.queues.find((queue) => {
          return queue.id == id;
        })
      };
    },
    initializeQueues() {

      this.sessions.forEach((session) => {
        var rows = session.queue.map(id => {
          return this.findRow(id);
        });

        this.queues.push(
          {
            id:  session.id,
            period: session.start_at,
            shift: session.shift,
            rows: rows,
            error: session.error_queue
          }
        );
      })
    },
    copy(id) {
      var target = this.queues.find((queue, _index) => {
        return queue.id == id;
      })

      this.clipboard = target.rows;
      toastr.info('已複製', 'Info');
    },
    paste(id) {
      var target = this.queues.find((queue, _index) => {
        return queue.id == id;
      })

      var shift = target.shift;
      var self = this;

      var rows = this.clipboard.map((row) => {
        if(this.isNews(row.id)) {
          let news = this.findRow(row.id);

          if(news.shift != shift) {
            row = this.allNews.find((news) => {
              return news.shift == shift;
            })
          }
        }

        return row;
      });

      this.queues.forEach((queue) => {
         if(queue.id  == id) {
           queue.rows = queue.rows.concat(rows);
         }
      })

      return true;
    },
    isNews(id){
      return typeof id === 'string' && id.match(/^n/);
    },
    preview(url){
      if (!url) {
        return '';
      }
      var extension = url.split('.').pop();
      if(extension == 'mp4') {
        return `<video src="${url}" style="width: 70px; height: 48px;" alt=""></video>`;
      } else {
        return `<img src="${url}" style="width: 70px; height: 48px;" alt="">`;
      }
    },
    lengthOf(queue) {
      return this.includePromotion ? queue.rows.length + 1 : queue.rows.length;
    },
    findDictionaryBy(id) {
      if(this.isNews(id)) {
        return this.allNews;
      } else {
        return this.ads;
      }
    },
    findRow(id) {
      var dictionary = this.findDictionaryBy(id);

      return dictionary.find((record) => {
        return record.id == id;
      })
    },
    idsOf(queue){
      return queue.rows.map(row => row.id);
    },
    secondsOf(seconds, index){
      var num = index + 1;
      var bottomLine = this.bottomLineOfQueue();

      var cumulativeSeconds = this.currentQueue.rows.slice(0, num).reduce((sum, row) => {
        var seconds = row.seconds
        return seconds == null ? sum : sum + parseInt(seconds);
      }, bottomLine);

      var result = seconds;

      if (cumulativeSeconds > 3600) {
        result += '<br /><small class="text-danger"><i class="flaticon-alarm-1"></i><b>超時1H</b></small>'
      }
      return result;
    },
    bottomLineOfQueue(){
      return this.includePromotion ? this.promotion.seconds : 0;
    }
  },
  watch: {
    keyword: _.debounce( function(keyword) {
      this.filterByKeyword(keyword);
    }, 500)
  }
};
</script>
