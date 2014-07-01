{Range, Point} = require 'atom'

MARKING = 'emacs-marking'

module.exports =
  class EmacsMark
    constructor: (editorView) ->
      @editorView = editorView

      @editorView.command 'mark-mode:set-mark', => @toggleMark()
      @editorView.command 'mark-mode:clear-mark', => @clearMark()

      @editorView.on 'cursor:moved', => @extendSelection()
      @editorView.on 'core:cancel', => @clearMark()
      @editorView.getEditor().getBuffer().on 'changed', => @clearMark()

      @marking = false

    toggleMark: ->
      if @marking then @clearMark() else @setMark()

    setMark: ->
      @editorView.addClass(MARKING)
      @marking = true
      editor = @editorView.getEditor()

      @markBegin = editor.getCursorBufferPosition()

    clearMark: ->
      if @marking
        @marking = false
        @editorView.removeClass(MARKING)
        @editorView.trigger('mark-mode:clear-selection')

    extendSelection: ->
      return unless @marking

      editor = @editorView.getEditor()
      cursor = editor.getCursor()
      cursorPos = editor.getCursorBufferPosition()

      reverse = Point.min(cursorPos, @markBegin) is cursorPos

      cursor.selection.setBufferRange([@markBegin, cursorPos], isReversed: reverse)
