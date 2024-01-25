SecureHeaders::Configuration.default do |config|
    config.csp = {
      default_src: %w('self'),
      script_src: %w('self' 'unsafe-inline' https://cdnjs.cloudflare.com https://code.jquery.com),
      style_src: %w('self' 'unsafe-inline' https://cdnjs.cloudflare.com),
      font_src: %w('self' https://fonts.gstatic.com),
      img_src: %w('self' data:),
      connect_src: %w('self'),
      frame_src: %w('self'),
      upgrade_insecure_requests: true,
      block_all_mixed_content: true,
      base_uri: %w('self'),
      report_uri: %w(/csp_report)
    }
  end
  