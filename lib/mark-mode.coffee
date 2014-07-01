{Range, Point} = require 'atom'

EmacsMark = require './mark'

module.exports =
  deactivate: ->

  serialize: ->

  activate: (state) ->

    atom.workspaceView.eachEditorView (editorView) =>
      new EmacsMark(editorView)

      editorView.command 'mark-mode:clear-selection', => @clearSelection editorView
      editorView.on 'core:cancel', => editorView.trigger 'mark-mode:clear-selection'

  clearSelection: (editorView) ->
    editor = editorView.getEditor()
    sel.clear() for sel in editor.getSelections()
