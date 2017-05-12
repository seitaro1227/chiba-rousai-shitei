class Admin::HospitalsController < ApplicationController
  before_action :set_hospital, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin

  # GET /admin/hospitals
  # GET /admin/hospitals.json
  def index
    @hospitals = Hospital.all
  end

  # GET /admin/hospitals/1
  # GET /admin/hospitals/1.json
  def show
  end

  # GET /admin/hospitals/new
  def new
    @hospital = Hospital.new
  end

  # GET /admin/hospitals/1/edit
  def edit
  end

  # POST /admin/hospitals
  # POST /admin/hospitals.json
  def create
    @hospital = Hospital.new(hospital_params)
    if @hospital.save
      redirect_to [:admin, @hospital], notice: 'Hospital was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/hospitals/1
  # PATCH/PUT /admin/hospitals/1.json
  def update
    if @hospital.update(hospital_params)
      redirect_to [:admin, @hospital], notice: 'Hospital was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/hospitals/1
  # DELETE /admin/hospitals/1.json
  def destroy
    @hospital.destroy
    respond_to do |format|
      format.html { redirect_to admin_hospitals_url, notice: 'Hospital was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    REALM = controller_name
    USERS = { "admin" => Digest::MD5::hexdigest(["admin", controller_name, ENV['ADMIN_PASSWORD']].join(":")) }
    # Use callbacks to share common setup or constraints between actions.
    def set_hospital
      @hospital = Hospital.find(params[:id])
    end

    def hospital_params
      params.fetch(:hospital, {})
          .permit(:number, :name, :zip_code, :address, :saikei, :niji, :phone_number, :latitude, :longitude)
    end

    def authenticate_admin
      authenticate_or_request_with_http_digest(REALM) {|username| USERS[username] }
    end
end
