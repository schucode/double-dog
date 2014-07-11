require_relative 'check_this.rb'
require_relative 'check_admin.rb'

module DoubleDog
  class SeeAllOrders < CheckThis

    include CheckAdmin

    def run(params)
      return failure(:not_admin) unless admin_session?(params[:admin_session])

      orders = DoubleDog.db.all_orders
      return success(orders: orders)
    end

  end
end