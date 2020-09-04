'use strict';

var handleConfirm = function handleConfirm(element) {
  if (!allowAction(this)) {
    Rails.stopEverything(element);
  }
};

var allowAction = function allowAction(element) {
  if (element.getAttribute('data-confirm-swal') === null) {
    return true;
  }

  showConfirmationDialog(element);
  return false;
};

// Display the confirmation dialog
var showConfirmationDialog = function showConfirmationDialog(element) {
  var message = element.getAttribute('data-confirm-swal');
  var text = element.getAttribute('data-text');
  swal({
    title: message || 'Are you sure?',
    text: text || '',
    type: 'warning',
    showCancelButton: true,
    confirmButtonText: 'Yes',
    cancelButtonText: 'No'
  }).then(function (isConfirm) {
    if (isConfirm.value) {
      element.removeAttribute('data-confirm-swal');
      element.click();
    } else {
      return false;
    }
  });
};

// Hook the event before the other rails events so it works togeter
// with `method: :delete`.
// See https://github.com/rails/rails/blob/master/actionview/app/assets/javascripts/rails-ujs/start.coffee#L69
document.addEventListener('rails:attachBindings', function (element) {
  Rails.delegate(document, 'a[data-confirm-swal]', 'click', handleConfirm);
});
