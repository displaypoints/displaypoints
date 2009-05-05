class Price
  include DataMapper::Resource
  
  property :id, Serial
  property :feature_title, String
  property :amount, Float #unit cost per day
  property :name, String

  def self.calc_price(name, units, corporation)
    price = first(:name => name)
    discount = Discount.first(Discount.price.id => price.id, Discount.corporation.id => corporation.id)
    units * price.amount * (1 + discount.amount)
  end

  def self.discounted_price(price, corporation)
    discount = Discount.first(Discount.price.id => price.id, Discount.corporation.id => corporation.id)
    discount.amount
  end

#  def self.campaign_per_day(campaign)
#    total = 0
#    corp = campaign.user.corporation
#    campaign.content_items.each do |ci|
#      total += calc_price(ci.content_type, 1, corp)
#      total += calc_price('ab_test_price', ci.pages.length, corp)
#      ci.pages.each do |page|
#        total += calc_price('link_price', page.link_count, corp)
#      end
#    end
#    #total = total * campaign.contract.length_in_days
#    total
#  end

  def price_matrix(campaign)
    prices = {}
    all.each do |price|
      prices[price.id] = [price.feature_title, discounted_price(price.name, campaign.user.corporation)]
    end
    return prices
  end
end
