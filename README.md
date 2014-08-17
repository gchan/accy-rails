ACCY - Bookkeeping on Rails
====

Simple double-entry accounting system built on Ruby on Rails.

This was a weekend prototype project for fun and profit.
It goes without saying this is unstable and nowhere near production ready.

I rarely share my incomplete, unpolished projects, so this is the first one!

![Chart of Accounts](https://raw.github.com/gchan/accy-rails/master/doc/images/chart-of-accounts.png)
![Journal Entries](https://raw.github.com/gchan/accy-rails/master/doc/images/journal-entries.png)
![Account Transactions](https://raw.github.com/gchan/accy-rails/master/doc/images/account-transactions.png)

## Features
* Double-entry journal system
* Imports Xero data (accounts and general ledger)
* Chart of accounts (Assets, Liabilities, Equity, Revenue, Expenses)
* Supports creation of new accounts and simple entries (one debit and one credit transaction)

##  List of potential things to do (The dream)

#### Features
* Transaction search (and global search)
* Export charts of accounts and ledger via Web interface
* Invoicing
* Contacts
* File upload, attach to ledger entries

#### Reporting
* Balance Sheet
* Income Statement (Profit and Loss)
* and others

#### Charting
* Dashboard widgets
* Charts, graphs, etc.

#### Accounting Rules
* Balance day adjustments
* Depreciation
* GST (sales tax) support

#### Multitenancy
* User accounts with Devise
* OAuth login (Google, GitHub, etc.)
* Organisation support
* Authorisation and access control through pundit

#### Replace Plutus with a customised bookkeeping solution with additional features
* Better constraints (deletion restriction)
* Better association integrity and data retrieval via ActiveRecord
* Better entry building (form objects)
* Individual line entry narrations

#### User Interface, User Experience
* Journal entry form to support multiple transactions and made to look more familiar
* Auto-complete where appropriate
* Better form layouts and errors (remove simple_form for control and flexibility?)
* Bootstrap theme/customisation

#### Security, common-sense
* Prevent accidental deletion, modification in back-end (accounts with entries currently can be deleted!)
* Authorisation
* Clean up code, remove scaffolding

#### Tests
* RSpec unit tests
* Capybara integration tests
* PhantomJS driver with poltergeist
* FactoryGirl fixtures
