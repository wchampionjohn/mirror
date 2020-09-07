export default {
  methods:{
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
    menuAppType: function(source){
      if(source.is_image) {
        return '<span class="m-badge m-badge--info m-badge--wide">Photo</span>';
      } else if(source.is_video) {
        return '<span class="m-badge m-badge--success m-badge--wide">Film</span>';
      } else if(source.is_html5) {
        return '<span class="m-badge m-badge--warning m-badge--wide">HTML5</span>';
      }
    },
    getRowNameById(id, rows) {
      const foundRow =  rows.find(function(row) {
        return row.id == id ;
      });

      if(foundRow && foundRow.name) {
        return foundRow.name;
      } else {
        return '';
      }
    },
    materialFileDisplayer(source) {
      if(!source.material_url) {
        return '';
      }
      if(source.material_is_image) {
        return `<a href="${source.material_url}" target="_blank">
        <img src="${source.material_url}" width="96" height="54" />
        </a>`;
      } else {
        return `<a href="${source.material_url}" target="_blank">
        <video src="${source.material_url}" width="96" height="54" />
        </a>`;
      }
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
    }
  },

}
