class AjaxStack

  stack: (url, settings, callback, fail_callback, finish) ->
    self = @
    if not self.ajaxActive
      self.ajaxActive = true
      self.nextAjaxSettings = null
      $.ajax(url, settings)
      .done (data) ->
        if $.type(callback) is 'function'
          callback(data)
      .fail (data) ->
        if $.type(fail_callback) is 'function'
          fail_callback(data)
      .always ->
        self.ajaxActive = false
        if self.nextAjaxSettings
          self.stack(url, self.nextAjaxSettings, callback, fail_callback, finish)
        else
          if $.type(finish) is 'function'
            finish()
    else
      self.nextAjaxSettings = settings

