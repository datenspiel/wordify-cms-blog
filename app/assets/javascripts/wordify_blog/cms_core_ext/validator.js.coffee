return unless Batman?

Batman.ValidationError.accessor 'errorMessage', ->
  if @attribute == 'base'
    return @get('fullMessage')
  else
    cleaned = @message.replace(/\'/g, "")
    format  = Batman.helpers.underscore(cleaned).replace(/\s/g, "_")
    I18n.t("wordify_cms.errors.#{@attribute}.#{format}")