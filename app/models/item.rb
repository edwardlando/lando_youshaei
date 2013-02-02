class Item < ActiveRecord::Base
  attr_accessible :title, :url, :gender, :price, :vibe, :apparel, :genes 

  belongs_to :user #tastemaker
  has_and_belongs_to_many :wishlists
  has_many :line_items
  has_many :orders, :through => :line_items
  has_many :item_votes

  validates_presence_of :title, :url, :apparel, :vibe, :price, :gender,
  :message => "Please make sure to fill in all fields"

  before_destroy :ensure_not_referenced_by_any_line_item

  GENDER_OPTIONS = ["Female", "Male", "All"]

  PRICE_OPTIONS = ["$", "$$", "$$$", "All"]

  VIBE_OPTIONS = ["Elegant", "Casual", "Preppy", "Flashy", "All"]

  APPAREL_OPTIONS = ["Tops","Bottoms", "All"]
                
  SIZE_OPTIONS = ["Extra Small", "Small", "Medium", "Large", "Extra Large"]

  ALPHA = 0.2
  BETA = 0.5

  def self.by_votes
    select('items.*, coalesce(value, 0) as votes').
    joins('left join item_votes on item_id=item.id').
    order('votes desc')
  end

  def votes
    read_attribute(:votes) || item_votes.sum(:value)
  end

  # Begining of machine learning code
  def vote(channel,value)
    puts "voting in channel"
    self.genes = update_gene_values(self,channel,value*ALPHA)
    channel.genes = update_gene_values(channel,self,value*BETA)
    self.save
    channel.save
  end

  def update_gene_values(item1,item2,greek)
    new_genes = []
    item1.genes.split(",").each_with_index do |gene,ind|
      gene = gene.to_f
      new_genes[ind] = gene + greek*(item2.genes[ind].to_f-item1.genes[ind].to_f)
      if new_genes[ind] < 0
        new_genes[ind] = 0
      elsif new_genes[ind] > 5
        new_genes[ind] = 5
      end
    end
    new_genes
  end

  def gene_distance(channel)
    sqr = 0
    channel_array = channel.genes.split(",")
    item_array = self.genes.split(",")
    for ind in (0..channel_array.length-1)
      sqr+=((channel_array[ind].to_f-item_array[ind].to_f)**2)
    end
    Math.sqrt(sqr)
  end

  private

	  def ensure_not_referenced_by_any_line_item
	  	if line_items.empty?
	  		return true
	  	else
	  		errors.add(:base, "Line Items present")
	  		return false
	  	end
	  end
  
end
