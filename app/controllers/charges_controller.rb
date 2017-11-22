class ChargesController < ApplicationController
  def create
    @order = Order.find(session['order'])
    subtotal = 0
    @order.line_items.each do |item|
      subtotal += item.price.to_f * item.quantity.to_i
    end

    @total = (subtotal +
              @order.pst_rate * subtotal +
              @order.gst_rate * subtotal +
              @order.hst_rate * subtotal) * 100

    amount = @total.to_i

    customer = Customer.find(@order.customer_id)

    stripe_customer = Stripe::Customer.retrieve(customer.unique_identifier)

    if stripe_customer.sources.empty?
      stripe_customer.source = params[:stripeToken]
      stripe_customer.save
    end

    @charge = Stripe::Charge.create(
      customer: customer.unique_identifier,
      amount: amount,
      description: "Order No: #{@order.id}",
      currency: 'cad'
    )

    if @charge.paid == true
      session['order'] = nil
      session['cart'] = {}
      @order.payment_identifier = @charge.id
      @order.order_status_id = 2 # Paid
      @order.save
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to checkout_path
  end
end
