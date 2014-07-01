{Range, Point} = require 'atom'

EmacsMark = require './mark'

module.exports =
  deactivate: ->

  serialize: ->

  activate: (state) ->

    atom.workspaceView.eachEditorView (editorView) =>
      new EmacsMark(editorView)

      editorView.command 'mark-mode:recenter', => @recenter editorView
      editorView.command 'mark-mode:clear-selection', => @clearSelection editorView

      editorView.on 'core:cancel', => editorView.trigger 'mark-mode:clear-selection'

  clearSelection: (editorView) ->
    editor = editorView.getEditor()
    sel.clear() for sel in editor.getSelections()

  recenter: (editorView) ->
    cursorPos = editorView.getEditor().getCursorScreenPosition()
    pageRows = editorView.getPageRows()

    topWhenCenter = cursorPos.row - parseInt(pageRows / 2) - 1
    topWhenTop = cursorPos.row
    topWhenBottom = cursorPos.row - pageRows + 1

    firstVisibleRow = editorView.getFirstVisibleScreenRow()

    topPos =
      switch firstVisibleRow
        when topWhenCenter
          editorView.getEditor().clipScreenPosition [topWhenTop, 0]
        when topWhenTop
          editorView.getEditor().clipScreenPosition [topWhenBottom, 0]
        else
          editorView.getEditor().clipScreenPosition [topWhenCenter, 0]

    pix = editorView.pixelPositionForScreenPosition topPos
    editorView.scrollTop pix.top
