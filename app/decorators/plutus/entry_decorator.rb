class Plutus::EntryDecorator < Draper::Decorator
  delegate_all

  decorates_association :credit_amounts, with: Plutus::AmountDecorator
  decorates_association :debit_amounts, with: Plutus::AmountDecorator

  def description(length = 30)
    return nil if object.description == '.'

    h.truncate object.description, length: length
  end

  def date
    l object.created_at.to_date, format: :long
  end

  def amounts
    amounts = debit_amounts + credit_amounts
  end

  def table_rows
    rows = amounts.count + 1
    rows += 1 if description

    rows
  end
end