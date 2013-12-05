# Use this hook to configure WordifyCms.
WordifyCms.setup do |config|
  # Enable or disable multiple sites support.
  # config.multiple_sites = false

  # Specify whcih route is used to mount the CMS into the Rails application.
  # Make sure it matches the 'wordify :at' line in 'config/routes.rb'.
  config.mounted_at         = "/"

  # Enable or disable sending error reports via email.
  # config.mail_errors  = true

  # Enable or disable persisting errors to the database
  # config.persist_errors     = true

  # Adjust the sender mail address for error reports.
  # config.error_sender_mail  = "error@example.com"

  # Adjust the recipients email addresses for error reports.
  # config.error_recipients   = %w(entersandman@sandman.tld)

  # Add image versions for uploading and storing.
  config.add_image_version  name:    :thumbnail,
                            method:  :resize_to_fit,
                            size:    [nil, 100]
  config.add_image_version  name:    :gallery_main,
                            method:  :resize_to_fill,
                            size:    [500, 250]
  config.add_image_version  name:    :gallery_thumb,
                            method:  :resize_to_fill,
                            size:    [250, 250]

  # Enable or disable 'Copy to clipboard' link in the asset management list.
  # config.enable_clipboard_backend = false

  # Add a list of file types that will be allowed to upload.
  # Default ones are: jpg,jpeg,gif,png,pdf
  # config.uploadable_file_types = %w( docx )

  # Enable or disable html editing.
  config.strict_mode = true
end