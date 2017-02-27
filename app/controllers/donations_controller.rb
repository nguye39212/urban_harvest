class DonationsController < ApplicationController
  before_action :set_donation, only: [:show, :edit, :update, :destroy]

  # GET /donations
  # GET /donations.json
  def index
    @donations = Donation.all
  end


  # GET /donations/new
  def new
    @donation = current_user.donor_donations.build
  end

  # GET /donations/1/edit
  def edit
  end

  # POST /donations
  # POST /donations.json
  def create
    @donation = current_user.donor_donations.build(donation_params)

    respond_to do |format|
      if @donation.save
        format.html { redirect_to root_url, notice: 'Donation was successfully created.' }
        format.json { render :show, status: :created, location: @donation }
      else
        format.html { render :new }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /donations/1
  # PATCH/PUT /donations/1.json
  def update
    respond_to do |format|
      if @donation.update(donation_params)
        format.html { redirect_to root_url, notice: 'Donation was successfully updated.' }
        format.json { render :show, status: :ok, location: @donation }
      else
        format.html { render :edit }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /donations/1
  # DELETE /donations/1.json
  def destroy
    @donation.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Donation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def current_donations
    @donations = Donation.fresh.unclaimed
  end

  def claim
    @donation = Donation.find(params[:id])
    if @donation.food_bank_id.blank?
      @donation.claim!(current_user)
      DonationsMailer.confirmation_email(@donation).deliver_now
      redirect_to confirmation_user_donation_path(@donation.donor, @donation)
    else
      flash[:error] = "That donation has been claimed"
      redirect_to current_donations_path
    end
  end

  def picked_up
    @donation = Donation.find(params[:id])
    @donation.picked_up = true
    @donation.save
    redirect_to root_path
  end

  def confirmation
    @donation = Donation.find(params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_donation
      if current_user.food_bank?
        @donation = current_user.food_bank_donations.find(params[:id])
      else
        @donation = current_user.donor_donations.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def donation_params
      params.require(:donation).permit(:description, :expires, :donor_id, :food_bank_id)
    end
end
