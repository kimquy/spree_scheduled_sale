Spree::Money.class_eval do
  def display_amount
    self
  end
  alias :display_price :display_amount
end