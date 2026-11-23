# frozen_string_literal: true

# dateModified ne doit jamais précéder datePublished : un article préparé
# en avance (last_modified_at) puis programmé (date) produirait sinon un
# JSON-LD incohérent, que Google ignore. On ramène last_modified_at à date.
Jekyll::Hooks.register :posts, :pre_render do |post|
  mod = post.data["last_modified_at"]
  next if mod.nil?

  mod_time = mod.is_a?(String) ? Time.parse(mod) : mod.to_time
  post.data["last_modified_at"] = post.date if mod_time < post.date
rescue ArgumentError
  post.data["last_modified_at"] = post.date
end
