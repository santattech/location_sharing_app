var LS = LS || {};

$(function() {
  $(document).on("click", "a[data-remote-popup]", function(event) {
    event.preventDefault();
    LS.Modal.showRemoteModal(this.href, $(this).data('title'), $(this).data('modal-class'));
  });

  $(document).on("click", "a[data-window]", function(event) {
    event.preventDefault();
    LS.Window.showWindow(this.href, $(this).data('title'), $(this).data('window-width'), $(this).data('window-height'));
  });

  $(document).on("click", "a[data-dismiss-window]", function(event) {
    self.close();
  });

  $(document).on("click", "a[data-popup]", function(event) {
    event.preventDefault();
    var target = $(this).data('modal-class'),
        title  = $(this).data('title'),
        header = '<div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button><h4 class="modal-title">' + title + '</h4></div>',
        modal_content = $('<div class="modal fade"><div class="modal-dialog"><div class="modal-content">' +
                          header + '<div class="modal-body all-categories clearfix"></div></div></div></div>');
    modal_content.find('.modal-body').html($("." + target).html());
    modal_content.modal('show');

    modal_content.on('hidden.bs.modal', function(){
      modal_content.remove();
    });
  });

  $(document).on("click", "a[data-image-popup]", function(event) {
    event.preventDefault();
    var modal_body    = '<div class="modal-body"><img src ="' + this.href + '"></div>';
    var modal_content = $('<div class="modal fade"><div class="modal-dialog"><div class="modal-content">'
                           + modal_body + '</div></div></div>');
    modal_content.addClass($(this).data('modal-class')).modal('show');
    modal_content.on('hidden.bs.modal', function(){
      modal_content.remove();
    });
  });

  $(document).on("click", "a[data-attachment-popup]", function(event) {
    event.preventDefault();
    var modal_body    = '<div class="modal-body"><object data="' + this.href + '" type="' + $(this).data('content-type') + '"></object></div>';
    var modal_content = $('<div class="modal fade"><div class="modal-dialog"><div class="modal-content">'
                           + modal_body + '</div></div></div>');
    modal_content.addClass($(this).data('modal-class')).modal('show');
    modal_content.on('hidden.bs.modal', function(){
      modal_content.remove();
    });
  });
});

LS.Modal = {
  showRemoteModal: function(url, title, modal_class){
    var header = '<div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button><h4 class="modal-title">' +
                 title + '</h4></div>';
    var modal_content = $('<div class="modal fade"><div class="modal-dialog"><div class="modal-content">' +
                          header + '<div class="modal-body clearfix"></div></div></div></div>');
    modal_content.modal({ backdrop: 'static' });
    modal_content.find('.modal-body').load(url);
    if(modal_class) {
      modal_content.find('.modal-dialog').addClass(modal_class);
    }
    modal_content.on('hidden.bs.modal', function(){
      modal_content.remove();
    });
    modal_content.on('shown.bs.modal', function(){
      $('.modal-body form').prepend("<div class='error-container'></div>");
    });
  }
};

LS.Window = {
  openedWindow: null,
  showWindow: function(url, title, width, height){
    if(SM.Window.openedWindow){
      SM.Window.openedWindow.close();
    }
    width = width || 500;
    height = height || 400;
    var top = Math.max((($(window).height() - height)/2), 50)
    var left = Math.max((($(window).width() - width)/2), 50);
    var window_url = SM.buildUrl(url, 'layout', 'popup_window');
    var window_options = "toolbar=yes, scrollbars=yes, resizable=yes, top=" + top + ", left=" + left + ", width=" + width + ", height=" + height + "";
    SM.Window.openedWindow = window.open(window_url, title, window_options);
  }
}