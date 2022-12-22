class StripeChargesServices
  DEFAULT_CURRENCY = 'usd'.freeze

  def initialize(params, user)
    @stripe_email = params[:stripeEmail]
    @stripe_token = params[:stripeToken]
    @order = params[:order_id]
    @user = user
  end

  def call
    create_charge(find_customer)
  end

  private

  attr_accessor :user, :stripe_email, :stripe_token, :order

  def find_customer
    if user.stripe_token
      retrieve_customer(user.stripe_token)
    else
      create_customer
    end
  end

  def retrieve_customer(stripe_token)
    Stripe::Customer.retrieve(stripe_token)
  end

  def create_customer
    customer = Stripe::Customer.create(
        email: stripe_email,
        source: stripe_token
    )
    user.update(stripe_token: customer.id)
    customer
  end

  def create_charge(customer)
    response = Stripe::Charge.create(
        customer: customer.id,
        amount: order_amount.to_i,
        description: customer.email,
        currency: DEFAULT_CURRENCY
    )
    related_order = Order.find_by(id: order)
    if response[:status] == 'succeeded'
      related_order.payment_status = 2
      related_order.response_id = response[:id]
      related_order.receipt_url= response[:receipt_url]
      related_order.save!
    end
  end

  def order_amount
    Order.find_by(id: order).total_amount
  end
end