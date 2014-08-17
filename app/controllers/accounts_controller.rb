class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  def index
    @accounts = Plutus::Account.all.includes([:credit_amounts, :debit_amounts]).decorate
  end

  %w(asset liability expense revenue equity).each do |account_type|
    method_name = account_type.pluralize

    define_method method_name do
      @accounts = Plutus.const_get(account_type.capitalize).all
        .includes([:credit_amounts, :debit_amounts])
        .decorate

      render :index
    end
  end

  def show
  end

  def new
    @account = Plutus::Account.new
  end

  def edit
  end

  def create
    @account = Plutus::Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to account_path(@account), notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to account_path(@account), notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_account
      @account = Plutus::Account.includes([credit_amounts: :entry, debit_amounts: :entry])
        .find(params[:id]).decorate
    end

    def account_params
      params.require(:account).permit(:name, :code, :type)
    end
end
