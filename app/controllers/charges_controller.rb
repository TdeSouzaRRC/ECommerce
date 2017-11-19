class ChargesController < ApplicationController 
    def create
        order = Order.find(session["order"])
        subtotal = 0
        order.line_items.each do |item|
            subtotal += item.price * item.quantity
        end
        total = subtotal + order.pst_rate*subtotal + order.gst_rate*subtotal + order.hst_rate*subtotal
        @amount = (total*100).to_i
    
        customer = Stripe::Customer.create(
            :email => params[:stripeEmail],
            :source  => params[:stripeToken]
        )
    
        charge = Stripe::Charge.create(
            :customer    => customer.id,
            :amount      => @amount,
            :description => "Order No: #{order.id}" ,
            :currency    => 'cad'
        )
    
        session["order"] = nil
        session["cart"] = nil
        
        rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to checkout_path
    end
end
