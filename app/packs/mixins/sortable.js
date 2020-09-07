const data = {
  sort: { name: '', taxis: '' },
}

const mixins = {
  methods: {
    sortBy(column) {
      const currentTaxis = this.sort.taxis;
      let newTaxis;

      if(currentTaxis === '' || currentTaxis === undefined) {
        newTaxis = 'asc';
      } else if(currentTaxis == 'asc') {
        newTaxis = 'desc';
      } else if(currentTaxis == 'desc') {
        newTaxis = '';
      }

      this.sort = { name: column, taxis: newTaxis}
    },
    sorttingColumnClass(column){
      const taxis = this.sort.taxis;

      if(column != this.sort.name) {
        return 'la-arrows-v'
      }

      if(!taxis) {
        return 'la-arrows-v'
      } else if(taxis == 'asc') {
        return  'la-arrow-up'
      } else if(taxis == 'desc') {
        return 'la-arrow-down'
      }
    },
    sortedRows(rawRows) {
      if (rawRows.length == 0 ) {
        return [];
      }

      const column = this.sort.name;
      const taxis = this.sort.taxis;

      // slice for avoid infinite update
      return rawRows.slice().sort((a, b) => {
        var value1 = a[column];
        var value2 = b[column];

        if(taxis == 'desc') {
          if (value1 > value2) {
            return -1;
          }
          if (value1 < value2) {
            return 1;
          }
        } else {
          if (value1 < value2) {
            return -1;
          }
          if (value1 > value2) {
            return 1;
          }
        }

        if (value1 == value2) {
          return 0;
        }
      })
    },
  }
}

export { mixins, data }
