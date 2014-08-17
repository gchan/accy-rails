module NumberHelper

  def number_to_accounting(number)
    number_to_currency number, unit: '', negative_format: "(%u%n)"
  end
end