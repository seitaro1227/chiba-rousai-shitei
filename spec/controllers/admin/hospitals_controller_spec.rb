require 'rails_helper'

RSpec.describe Admin::HospitalsController, type: :controller do

  describe 'GET #index' do
    let!(:hospitals) { [create(:hospital), create(:hospital), create(:hospital)] }
    context "adminである場合" do
      before { valid_auth { get :index } }
      it 'hospitalsがアサインされていること' do
        expect(assigns(:hospitals)).to match_array(hospitals)
      end
    end
    context "adminでない場合" do
      before { invalid_auth { get :index } }
      it "認証に失敗すること" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "GET #show" do
    let!(:hospital) { create(:hospital) }
    context "adminである場合" do
      before { valid_auth { get :show, params: { id: hospital.to_param } } }
      it "hospitalがアサインされていること" do
        expect(assigns(:hospital)).to eq(hospital)
      end
    end
    context "adminでない場合" do
      before { invalid_auth { get :show, params: { id: hospital.to_param } } }
      it "認証に失敗すること" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "GET #new" do
    context "adminである場合" do
      before { valid_auth { get :new } }
      it "Hospital#newがアサインさていること" do
        expect(assigns(:hospital)).to be_a_new(Hospital)
      end
    end
    context "adminでない場合" do
      before { invalid_auth { get :new } }
      it "認証に失敗すること" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "GET #edit" do
    let(:hospital) { create(:hospital) }
    context "adminである場合" do
      before { valid_auth { get :edit, params: { id: hospital.to_param } } }
      it "hospitalがアサインされていること" do
        expect(assigns(:hospital)).to eq(hospital)
      end
    end
    context "adminでない場合" do
      before { invalid_auth { get :edit, params: { id: hospital.to_param } } }
      it "認証に失敗すること" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "POST #create" do
    let(:valid_attributes) { attributes_for(:hospital) }
    context "with valid params" do
      before do |example|
        unless example.metadata[:skip_before]
          valid_auth { post :create, params: { hospital: valid_attributes } }
        end
      end

      it 'Hospital#countが1件増えること', skip_before: true do
        expect {
          valid_auth { post :create, params: { hospital: valid_attributes } }
        }.to change(Hospital, :count).by(1)
      end

      it 'hospitalがアサインされていること' do
        expect(assigns(:hospital)).to be_a(Hospital)
        expect(assigns(:hospital)).to be_persisted
      end

      it 'admin_hospital_pathにリダイレクトされること' do
        expect(response).to redirect_to(admin_hospital_path(assigns(:hospital)))
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { attributes_for(:invalid_hospital) }
      before do
        valid_auth { post :create, params: { hospital: invalid_attributes } }
      end
      it 'hospitalがアサインされていること' do
        expect(assigns(:hospital)).to be_a_new(Hospital)
      end
      it 'newを再表示すること' do
        expect(response).to render_template(:new)
      end
    end

    context "adminでない場合" do
      before do
        invalid_auth { post :create, params: { hospital: valid_attributes } }
      end
      it "認証に失敗すること" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "PUT #update" do
    let!(:hospital) { create(:hospital) }
    let(:new_attributes) { attributes_for(:nichidai_matsudo_shika) }
    context "with valid params" do
      before do
        valid_auth { put :update, params: { id: hospital.to_param, hospital: new_attributes } }
      end

      it "hospitalが更新されていること" do
        hospital.reload
        expect(hospital.name).to eql(new_attributes[:name])
      end

      it "requestにhospitalがアサインされていること" do
        expect(assigns(:hospital)).to eql(hospital)
      end

      it "admin_hospital_pathにリダイレクトされること" do
        expect(response).to redirect_to(admin_hospital_path(hospital))
      end
    end

    context "with invalid params" do
      let(:invalid_attributes) { attributes_for(:invalid_hospital) }
      before do
        valid_auth { put :update, params: { id: hospital.to_param, hospital: invalid_attributes } }
      end
      it "hosputalがアサインされていること" do
        expect(assigns(:hospital)).to eq(hospital)
      end
      it "editを再表示すること" do
        expect(response).to render_template(:edit)
      end
    end

    context "adminでない場合" do
      before do
        invalid_auth { put :update, params: { id: hospital.to_param, hospital: new_attributes } }
      end
      it "認証に失敗すること" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:hospital) { create(:hospital) }
    context "adminである場合" do
      before do |example|
        unless example.metadata[:skip_before]
          valid_auth { delete :destroy, params: { id: hospital.to_param } }
        end
      end
      it "Hospital#countが1件減ること", skip_before: true do
        expect {
          valid_auth { delete :destroy, params: { id: hospital.to_param } }
        }.to change(Hospital, :count).by(-1)
      end

      it "admin_hospitals_pathにリダイレクトされること" do
        expect(response).to redirect_to(admin_hospitals_url)
      end
    end

    context "adminでない場合" do
      before do
        invalid_auth { delete :destroy, params: { id: hospital.to_param } }
      end
      it "認証に失敗すること" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  private
  def valid_auth
    authenticate_with_http_digest("admin", ENV['ADMIN_PASSWORD']) do
      yield
    end
  end

  def invalid_auth
    authenticate_with_http_digest("admin", 'invalid') do
      yield
    end
  end
end
