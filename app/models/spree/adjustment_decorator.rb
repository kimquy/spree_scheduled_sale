Spree::Adjustment.class_eval do
  scope :promotion, -> { where(source_type: ['Spree::PromotionAction', 'Spree::ScheduledSale']) }

end