Jekyll::Hooks.register [:posts, :pages], :post_render do |doc|
  next unless doc.output_ext == ".html"

  doc.output = doc.output.gsub(/<a\s([^>]*)href="([^"]*)"([^>]*)>/i) do |match|
    pre   = $1
    href  = $2
    post  = $3

    next match if href.start_with?("/", "#", "mailto:") || href.empty?
    next match unless href.match?(/\Ahttps?:\/\//i)

    existing_rel    = (pre + post).match(/rel="([^"]*)"/i)&.[]( 1).to_s
    existing_target = (pre + post).match(/target="([^"]*)"/i)&.[](1).to_s

    is_affiliate = href.match?(/amazon\.|tag=rareradar|ebay\.|campid=|epn\./)

    rel_values =
      if is_affiliate
        %w[noopener noreferrer nofollow sponsored]
      else
        %w[noopener noreferrer]
      end

    merged_rel = (existing_rel.split + rel_values).uniq.join(" ")

    cleaned = (pre + post)
      .gsub(/\s*rel="[^"]*"/i, "")
      .gsub(/\s*target="[^"]*"/i, "")
      .strip

    "<a #{cleaned} href=\"#{href}\" rel=\"#{merged_rel}\" target=\"_blank\">"
  end
end
