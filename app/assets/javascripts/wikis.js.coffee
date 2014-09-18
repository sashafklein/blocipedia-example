# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  editor = new EpicEditor(
    container: 'edit-wiki'
    basePath: '/assets'
    textarea: 'body-textarea'
    theme:
      base: 'epic-editor/base/epiceditor.css'
      preview: 'epic-editor/preview/preview-dark.css'
      editor: 'epic-editor/editor/epic-dark.css'
  ).load()