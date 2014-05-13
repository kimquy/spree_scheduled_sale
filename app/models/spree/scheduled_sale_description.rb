module Spree
  class ScheduledSaleDescription <  ActiveRecord::Base
    belongs_to :schedule_sale
  end
end
