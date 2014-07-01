{Range, Point} = require 'atom'

EmacsMark = require './mark'

module.exports =
  activate: (state) ->

    atom.workspaceView.eachEditorView (editorView) =>
      new EmacsMark(editorView)

      editorView.command 'mark-mode:recenter', => @recenter editorView
      editorView.command 'mark-mode:clear-selection', => @clearSelection editorView

      editorView.on 'core:cancel', => editorView.trigger 'mark-mode:clear-selection'      


  deactivate: ->

  serialize: ->

  clearSelection: (editorView) ->
    editor = editorView.getEditor()
    sel.clear() for sel in editor.getSelections()

  recenter: (editorView) ->
    cursorPos = editorView.getEditor().getCursorScreenPosition()
    rows = editorView.getPageRows()

    topRow = cursorPos.row - parseInt(rows / 2)
    topPos = editorView.getEditor().clipScreenPosition [topRow, 0]

    pix = editorView.pixelPositionForScreenPosition topPos
    editorView.scrollTop pix.top
