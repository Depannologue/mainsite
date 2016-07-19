class Client::FormController < ApplicationController

  def new
    @user_informations_form = UserInformationsForm.new
  end

  def create
      @user_informations_form = UserInformationsForm.new(user_information_form_params)
    if @user_informations_form.save
      raise 'Changer le redirect'
      #redirect_to dashboard_url, notice: "Expense ID #{@user_expense_form.expense.id} has been created"
    else
      #raise 'Check les erreurs poto'
      render :new
    end
  end


  private
  # Using strong parameters
  def user_information_form_params
    params.require(:user_informations_form).permit(:firstname, :lastname, :address1, :address2, :zipcode, :phone_number, :city, :email)
  end
end
