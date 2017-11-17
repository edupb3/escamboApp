class Ad < ActiveRecord::Base
  belongs_to :category, counter_cache: true
  belongs_to :member
  
  # Constants
  QTT_PER_PAGE = 6
  
  # Callbacks
  before_save :md_to_html
  
  # Validates
  validates :title, :description_md, :description_short, :category, :picture, presence: true
  validates :price, numericality: {greater_than: 0}
  
  # Scopes
  scope :descending_order, -> (quantity = 10) {  limit(quantity).order(description: :desc) }
  scope :to_the, -> (current_member) {  where(member: current_member).limit(15)}
  scope :by_category, ->(id) { where(category: id).limit(QTT_PER_PAGE) }
  
  has_attached_file :picture, styles: { large: "800x300#", medium: "320x150#", thumb: "100x100#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
  
  monetize :price_cents
  
  private
  
  def md_to_html
    options = {
        filter_html: true,
        link_attributes: {
          rel: "nofollow",
          target: "_blank"
        }
    }

    extensions = {
      space_after_headers: true,
      autolink: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)
    self.description = markdown.render(self.description_md)
    
  end
  
end
