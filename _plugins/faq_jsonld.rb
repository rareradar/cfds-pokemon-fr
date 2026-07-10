Jekyll::Hooks.register :posts, :pre_render do |post|
  pairs = []
  post.content.to_s.scan(/\*\*Q\s*:\s*(.+?)\*\*\s*\n+R\s*:\s*(.+?)(?=\n{2,}|\z)/m) do |question, answer|
    pairs << {
      "q" => question.strip.gsub(/\*/, ""),
      "a" => answer.strip.gsub(/\*/, "").gsub(/\s+/, " ")
    }
  end
  post.data["faq_pairs"] = pairs unless pairs.empty?
end
