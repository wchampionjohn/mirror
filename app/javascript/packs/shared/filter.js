import Vue from 'vue/dist/vue.esm';

Vue.filter('to_title', function (value) {
  return _.startCase(_.toLower(value.replace('_',' ')));
});

Vue.filter('datetime', function (value) {
  if (typeof value === 'undefined' || value === null) {
    return ''
  }
  else {
    return moment(value).format('YYYY/MM/DD H:mm:ss')
  }
});

Vue.filter('date', function (value) {
  if (typeof value === 'undefined' || value === null) {
    return ''
  }
  else {
    return moment(value).format('YYYY/MM/DD')
  }
});