class ChargesController < ApplicationController 
    def create
        @order = Order.find(session["order"])
        subtotal = 0
        @order.line_items.each do |item|
            subtotal += item.price.to_f * item.quantity.to_i
        end
        @total = (subtotal + @order.pst_rate*subtotal + @order.gst_rate*subtotal + @order.hst_rate*subtotal)*100
        amount = @total.to_i
    
        # customer = Stripe::Customer.create(
        #     :email => params[:stripeEmail],
        #     :source  => params[:stripeToken]
        # )
    
        charge = Stripe::Charge.create(
            :customer    => customer.id,
            :amount      => amount,
            :description => "Order No: #{@order.id}",
            :currency    => 'usd'
        )
    
        unless charge.nil?
            session["order"] = nil
            session["cart"] = {}
            @order.payment_id = charge.id
            @order.order_status_id = 2 #Paid
            @order.save
        end

        rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to checkout_path
    end
end
