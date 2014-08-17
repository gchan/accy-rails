require 'csv'

namespace :seeds do
  desc "Import Xero Demo Chart of Accounts"
  task chart_of_accounts: :environment do
    ACCOUNT_TYPE_MAP = {
      'Asset'        => :Asset,
      'Liability'    => :Liability,
      'Equity'       => :Equity,
      'Revenue'      => :Revenue,
      'Expense'      => :Expense,
      'Bank'                        => :Asset,
      'Direct Costs'                => :Expense,
      'Overhead'                    => :Expense,
      'Bank Revaluations'           => :Expense,
      'Unrealised Currency Gains'   => :Expense,
      'Realised Currency Gains'     => :Expense,
      'Accounts Receivable'         => :Asset,
      'Current Asset'               => :Asset,
      'Fixed Asset'                 => :Asset,
      'Accounts Payable'            => :Liability,
      'Unpaid Expense Claims'       => :Liability,
      'Current Liability'           => :Liability,
      'Non-current Liability'       => :Liability,
      'GST'                         => :Liability,
      'Historical'                  => :Liability,
      'Rounding'                    => :Liability,
      'Tracking'                    => :Liability,
      'Retained Earnings'           => :Equity
    }

    ActiveRecord::Base.transaction do
      CSV.foreach(Rails.root + "db/seeds/ChartOfAccounts.csv", headers: true) do |row|
        name = row['Name']
        type = row['Type']
        code = row['Code']
        account_type = ACCOUNT_TYPE_MAP[type]

        raise "Unknown account type #{type}" if account_type.nil?

        Plutus.const_get(account_type).create!(name: name, code: code)
      end
    end
  end

  desc "Import Xero Journal Entries"
  task journal_entries: :environment do
    ActiveRecord::Base.transaction do
      Plutus::Entry.delete_all
      Plutus::Amount.delete_all

      journal_number = -1
      entry = nil

      csv = CSV.read(Rails.root + "db/seeds/JournalEntries.csv", headers: true, col_sep: "\t")

      csv.sort_by(&:first).each do |row|
        current_number  = row['JournalNumber']
        account         = Plutus::Account.find_by(name: row['AccountName'])
        amount          = row['NetAmount'].to_f
        description     = row['Description']
        date            = Date.parse(row['JournalDate'])

        # When journal number is different, save previous entry and create a new one
        if current_number != journal_number
          entry.save! if entry
          entry = Plutus::Entry.new(description: '.', created_at: date)
          journal_number = current_number
        end

        amount_hash = { account: account, amount: amount.abs, entry: entry }

        if amount > 0
          entry.debit_amounts.new(amount_hash)
        else
          entry.credit_amounts.new(amount_hash)
        end

        entry.description = description if description
      end

      entry.save!
    end
  end
end
