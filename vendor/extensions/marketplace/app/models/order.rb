class Order < ActiveRecord::Base
  PAYMENT_METHODS = ['Direct Debit', 'Cheque', 'Cash', 'Online']
  belongs_to :subscription
  belongs_to :old_subscription, :class_name => 'Subscription'
  has_many :order_lines
  accepts_nested_attributes_for :order_lines, :reject_if => :all_blank
  validates_presence_of :amount, :subscription
  validates_numericality_of :amount
  validates_inclusion_of :payment_method, :in => PAYMENT_METHODS, :allow_blank => true

  delegate :reader, :to => :subscription
  delegate :nzffa_member_id, :to => :reader

  def before_save
    self.amount = calculate_amount
  end

  def calculate_amount
    amount = order_lines.map(&:amount).sum
    if amount < 0
      0
    else
      amount
    end
  end

  def add_charge(params)
    order_lines.build(params)
  end

  def add_refund(params)
    params[:amount] = -(params[:amount])
    order_lines.build(params)
  end

  def order_id
    id
  end

  def nzffa_member_id
    reader.nzffa_membership_id
  end

  def paid!(method)
    self.payment_method = method
    unless payment_method.present?
      raise 'Payment method required'
    end
    if old_subscription.present?
      old_subscription.cancel!
    end
    update_attribute(:paid_on, Date.today)
  end

  def paid?
    paid_on.present?
  end

  def self.upgrade_subscription(old_sub, new_sub)
    create(:kind => 'upgrade',
           :old_subscription => old_sub,
           :subscription => new_sub,
           :amount => CalculatesSubscriptionLevy.upgrade_price(old_sub, new_sub),
           :paid_on => nil)
  end

end