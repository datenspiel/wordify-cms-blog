return unless Wordify?
###
Public: View component that converts a textarea with css class .tiny-editor into
a TinyMCE instance.

Usage:

  <textarea id="post_text"
            data-bind="post.text"
            data-view="TinyMceView"
            class="tiny-editor" />
###
class Wordify.TinyMceView extends Batman.View

  ready: ->
    @_prependScript(j(@get('node')))

  _prependScript: (node)->
    script = """
      <script type="text/javascript">
        tinymce.init(#{JSON.stringify(Cms.Editor.tinyMceOptions('.tiny-editor'))});
        </script>
    """
    node.prepend(script)