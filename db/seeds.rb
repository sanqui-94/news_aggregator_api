# ============================================================
# Tags
# ============================================================
tags = %w[
  Ruby Rails JavaScript Python DevOps Security
  AI Open-Source Databases Performance Architecture
].map do |name|
  Tag.find_or_create_by!(name: name)
end

puts "Created #{tags.size} tags"

# ============================================================
# Sources
# ============================================================
sources = [
  {
    name: "Ruby Weekly",
    url: "https://rubyweekly.com/rss/1ivh0e74",
    site_url: "https://rubyweekly.com",
    description: "A free, once-weekly e-mail round-up of Ruby news and articles.",
    tag_names: %w[Ruby Rails]
  },
  {
    name: "The Changelog",
    url: "https://changelog.com/podcast/feed",
    site_url: "https://changelog.com",
    description: "News and interviews about open source, software development, and the people who make it.",
    tag_names: %w[Open-Source]
  },
  {
    name: "InfoQ",
    url: "https://feed.infoq.com",
    site_url: "https://www.infoq.com",
    description: "Facilitating the spread of knowledge and innovation in professional software development.",
    tag_names: %w[Architecture Performance]
  },
  {
    name: "Hacker News Best",
    url: "https://hnrss.org/best",
    site_url: "https://news.ycombinator.com",
    description: "Top-ranked stories from Hacker News.",
    tag_names: %w[Open-Source Security]
  },
  {
    name: "The Pragmatic Engineer",
    url: "https://newsletter.pragmaticengineer.com/feed",
    site_url: "https://newsletter.pragmaticengineer.com",
    description: "Observations and insights from Gergely Orosz on the software industry.",
    tag_names: %w[Architecture]
  }
]

tag_lookup = Tag.all.index_by(&:name)

sources.each do |attrs|
  tag_names = attrs.delete(:tag_names)
  source = Source.find_or_create_by!(url: attrs[:url]) do |s|
    s.assign_attributes(attrs)
  end

  tag_names.each do |tag_name|
    tag = tag_lookup[tag_name]
    SourceTag.find_or_create_by!(source: source, tag: tag) if tag
  end
end

puts "Created #{Source.count} sources with tags"

# ============================================================
# Default Feed (first 5 sources)
# ============================================================
Source.limit(5).each do |source|
  DefaultFeedSource.find_or_create_by!(source: source)
end

puts "Default feed configured with #{DefaultFeedSource.count} sources"
