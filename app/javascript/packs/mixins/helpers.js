export default {
  methods:{
    adState: function(source, column){

      let style = ''

      switch(source[column]) {
        case 'pending':
          style = "m-badge--info"
          break;
        case 'running':
          style = "m-badge--success"
          break;
        case 'rejection':
          style = "m-badge--default"
          break;
        case 'stopping':
          style = "m-badge--danger"
          break;
        case 'ending':
          style = "m-badge--metal"
          break;
        case 'waiting':
          style = "m-badge--warning"
          break;
      }

      return '<span class="m-badge ' + style + ' m-badge--wide">' + source.status_text + '</span>';
    },
    service_light: function(source){

      let style = ''
      let minutes = source.out_of_service_minutes
      let tip = `設備最後回報時間：${source.last_report_time} (${source.last_report_time_words})`

      if(minutes < 30) {
        style = "m-badge--success"
      } else if(minutes >= 30 && minutes < 60) {
        style = "m-badge--warning"
      } else {
        style = "m-badge--danger"
      }

      return '<span class="m-badge ' + style + '" data-toggle="m-tooltip" data-original-title="' + tip + '"></span>';
    },
    convertToPercentage: function(rate) {
      return Math.round(rate * 1000) / 10 + '%'
    },
    sumOf(records, column) {
      return records.reduce(function(result, record){
        if(record[column]) {
          var float = parseFloat(record[column])
        } else {
          var float = 0.0;
        }
        return result + float;
      }, 0.0)
    },
    checker: function(source, column){
      return source[column] ? '<i class="la la-check-square"></i>' : '';
    },

    formatNumberForTable: function(source, column) {
      return formatNumber(source[column]);
    },
    formatNumber: function(number) {
      if(number < 1000) {
        return number;
      }
      if(number) {
        return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
      }
    },
    formatNumberForTable: function(source, column) {
      var number = source[column];

      if(number < 1000) {
        return number;
      }
      if(number) {
        return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
      }
    },
    formatMoney: function(number) {
      if(number) {
        return parseInt(number).toLocaleString('en-US', { style: 'currency', currency: 'USD', minimumFractionDigits: 0 });
      }
    },
    contarctDownloadButton: (source) => {
      return '<a href="' + source.attachment_url + '" target="_blank" class="btn btn-outline-warning m-btn m-btn--custom m-btn--icon m-btn--pill m-btn--air"><span><i class="la la-cloud-download"></i><span>下載</span></span></a>';
    },
    icon: function(source){
      return '<i class="' + source.icon + '"></i>';
    },
    adMaterialiDsplayer(source) {
      if(!source.material) {
        return '';
      }

      return `<a href="${source.material}" target="_blank">
      <img src="${source.screenshot}" width="96" height="54" />
      </a>`;
    },
    link(source, column) {
      const url = source[column]
      return `<a href="${url}" target="_blank">${url}</a>`;
    },
    nameOfLink(source, column) {
      const name = source[column]
      const url = source[column + '_url']
      if(url) {
        return `<a href="${url}">${name}</a>`;
      }
    },
    locationNameWithUrl(source, column) {
      const name = source[column];
      const url = `/admin/locations/${source.location_id}/edit`
      return `<a href="${url}">${name}</a>`;
    },
    currentScheduleRender(source) {
      if(source.current_schedule) {
        const name = source.current_schedule;
        const url = source.current_schedule_url;
        return `<a href="${url}"><u>${name}</u></a>`;
      }
    },
    linkOfDevicesInSchedule(source) {
      if(source) {
        const url = `/admin/schedules/${source.id}/edit?step=1`;
        return `<a href="${url}"><u>${source.devices}</u></a>`;
      }
    },
    linkOfAdsInSchedule(source) {
      if(source) {
        const url = `/admin/schedules/${source.id}/edit?step=2`;
        return `<a href="${url}"><u>${source.ads}</u></a>`;
      }
    },
    remainOfSchedule(schedule) {
      let remain_seconds = schedule.remain_seconds.map((session) =>{
        return `${session.start}剩餘${session.remain}秒`;
      });

      const title = remain_seconds.join('/');

      return `<span class="m--font-danger" data-toggle="m-tooltip" data-original-title="${title}">指我查看</span>`
    },
    bannerDisplayer(url) {
      if(url) {
        return `<a href="${url}" target="_blank"><img src="${url}" width="30" height="120" /></a>`;
      } else {
        return '未上傳';
      }

    }
  },
}
