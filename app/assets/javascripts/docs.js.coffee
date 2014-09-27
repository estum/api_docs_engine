#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require bootstrap/affix
#= require turbolinks
#= require highlight

unless $.fn.doOnce
  $.fn.doOnce = (fn) -> fn.call(@) if @length > 0

$.fn.add_edit_link = (classnames) ->
  @toggleClass 'col-sm-10', on
  @after -> """<a href="#{@dataset.editPath}" class="col-sm-2 #{classnames}"><i class="fa fa-edit"></i></a>"""

$.fn.highlight = (sel) -> 
  @find(sel).each (i, block) -> hljs.highlightBlock(block)

process_request = (source, callback) ->
  $.post '/docs/markdown.json', source: source, callback, 'json'

$.fn.markdownize = (target) ->
  @on 'change', -> process_request @value, (json) -> 
    ($ target).doOnce ->
      @html json.result
      @highlight 'pre code, pre samp'

jQuery ->
  page_loaded = ->
    ($ document).highlight('pre code, pre samp')
    
    ($ "#left-sidebar [data-edit-path]").each ->
      ($ @).add_edit_link "sidebar-edit-link text-muted"
    
    ($ '.preview-markdown').each ->
      ($ @dataset.source).markdownize(this).change()
    
    ($ '.navbar-spyscroll').doOnce ->
      ($ 'body').scrollspy target: '.navbar-spyscroll'
      @affix()
  
  ($ document).on 'page:load', page_loaded
  do page_loaded