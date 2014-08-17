class Plutus::AccountDecorator < Draper::Decorator
  delegate_all

  decorates_association :credit_amounts, with: Plutus::AmountDecorator
  decorates_association :debit_amounts, with: Plutus::AmountDecorator

  def type
    object.class.name.demodulize
  end

  def balance
    h.number_to_accounting object.balance
  end

  def amounts
    amounts = credit_amounts + debit_amounts

    amounts.sort_by do |amount|
      amount.entry.created_at
    end

    amounts.each_with_object([]) do |amount, running_balance|
      running_balance << running_balance.last.to_i + amount.object.amount * (amount.debit_amount? ? 1 : -1)
      amount.entry.balance = running_balance.last * (credit_balance? ? -1 : 1)
    end

    amounts
  end

  def credit_balance?
    %w(Revenue Liability).include? type
  end

  def transactions
    amounts.count
  end

  def last_transaction_date
    return nil if amounts.empty?

    last_transaction.date
  end

  def last_transaction
    amounts.last.entry
  end

  def deletable?
    amounts.empty?
  end
end
