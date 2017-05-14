class Admin::HospitalsController < ApplicationController
  before_action :set_hospital, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin

  # GET /admin/hospitals
  def index
    @hospitals = Hospital.includes(:subjects,:jurisdiction).all
  end

  # GET /admin/hospitals/1
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
  def create
    @hospital = Hospital.new(hospital_params)
    if @hospital.save
      redirect_to [:admin, @hospital], notice: 'Hospitalを新規作成しました'
    else
      flash.now[:alert] = "Hospital#createが失敗しました"
      render :new
    end
  end

  # PATCH/PUT /admin/hospitals/1
  def update
    if @hospital.update(hospital_params)
      redirect_to [:admin, @hospital], notice: "#{@hospital.name}を更新しました"
    else
      flash.now[:alert] = "Hospital#updateが失敗しました"
      render :edit
    end
  end

  # DELETE /admin/hospitals/1
  def destroy
    @hospital.destroy
    redirect_to admin_hospitals_url, notice: "#{@hospital.name}を削除しました"
  end

  private
    def set_hospital
      @hospital = Hospital.find(params[:id])
      @jurisdictions = Jurisdiction.all #Jurisdiction.pluck(:id,:name)
    end

    def hospital_params
      params.fetch(:hospital, {})
          .permit(:number, :name, :zip_code, :address, :saikei, :niji, :phone_number, :latitude, :longitude)
    end

    REALM = controller_name
    USERS = { "admin" => Digest::MD5::hexdigest(["admin", controller_name, ENV['ADMIN_PASSWORD']].join(":")) }
    def authenticate_admin
      authenticate_or_request_with_http_digest(REALM) { |username| USERS[username] }
    end
end
