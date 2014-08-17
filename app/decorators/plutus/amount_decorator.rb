class Plutus::AmountDecorator < Draper::Decorator
  delegate_all

  decorates_association :entry, with: Plutus::EntryDecorator

  def amount
    h.number_to_accounting object.amount
  end

  def credit_amount?
    object.is_a? Plutus::CreditAmount
  end

  def debit_amount?
    object.is_a? Plutus::DebitAmount
  end
end