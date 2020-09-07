import Vue from 'vue/dist/vue.esm';
import helpers from '../../mixins/helpers';
import _              from 'lodash';

new Vue({
  el: '#form',
  data: {
    keyword: '',
    devices: $('#all-devices').data('options'),
    selectedDeviceIds: $('#selected-devices').data('ids'),
    selectedChannel: '',
    visibleDevices: [],
  },
  mixins:[helpers],
  mounted(){
    this.visibleDevices = this.devices;
  },
  methods:{
    toggle(id){
      var idx = this.selectedDeviceIds.indexOf(id);

      if (idx > -1) {
        this.selectedDeviceIds.splice(idx, 1);
      } else {
        this.selectedDeviceIds.push(id);
      }
    },
    totalGuarantee(){
      var total = this.selectedDeviceIds.reduce( (accumulator, deviceId) => {
        var currentDevice = this.devices.find(device => device.id == deviceId);
        return accumulator += currentDevice.guarantee;
      }, 0);

      return this.formatNumber(total);
    },
    resolutions(){
      var resolutionsArray = this.selectedDeviceIds.reduce( (accumulator, deviceId) => {
        var currentDevice = this.devices.find(device => device.id == deviceId);
        var currentResolution = currentDevice.resolution;
        if (!accumulator.includes(currentResolution)) {
          accumulator.push(currentResolution);
        }
        return accumulator;
      }, []);

      return resolutionsArray.join('、');
    },
    filteDevices(){
      let visibleDevices = this.devices;

      if(this.keyword){
        visibleDevices = visibleDevices.filter((device) => {
          return device.name.includes(this.keyword) || device.location_name.includes(this.keyword);
        })
      }

      if(this.selectedChannel){
        visibleDevices = visibleDevices.filter((device) => {
          let channeIds = device.channels.map(channel => channel.id);
          return channeIds.length > 0  && channeIds.indexOf(parseInt(this.selectedChannel)) > -1
        })
      }

      this.visibleDevices = visibleDevices;
    },
    toggleAll(){
        const visibleDeviceIds = this.visibleDevices.map(function(device){
          return device.id;
        })

        if (this.toggleAllIsCheck()){
          this.selectedDeviceIds = this.selectedDeviceIds.filter((deviceId) => {
            return !visibleDeviceIds.includes(deviceId);
          })
        } else {
          this.selectedDeviceIds = _.union(this.selectedDeviceIds.concat(visibleDeviceIds));
        }
    },
    toggleAllIsCheck(){

      if (this.visibleDevices.length == 0 || this.selectedDeviceIds.length == 0) {
        return false
      }
      const currentIds = this.visibleDevices.map(function(device){
        return device.id;
      })

      return currentIds.every((deviceId) => {
        return this.selectedDeviceIds.includes(deviceId);
      })
    },
    channelNameOf(device) {
      let names = device.channels.map( channel => channel.name );
      return names.join(',');
    }

  },
  watch: {
    keyword: _.debounce( function() {
      this.filteDevices();
    }, 100),

    selectedChannel: _.debounce( function() {
      this.filteDevices();
    }, 100)
  }
})
