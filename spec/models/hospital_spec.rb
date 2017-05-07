require 'rails_helper'
describe Hospital do

  describe "#search" do
    shared_examples_for 'equal all sql' do
      it{is_expected.to eq Hospital.all.to_sql}
    end

    describe "params[ロケーション]" do
      context "駅から1km以内" do
        let(:kashiwa_station){create(:kashiwa_station)}
        let(:params){{km:1, station: kashiwa_station.id, location: 'station'}}
        let(:current_location){Hospital.location_params(params)}
        subject{Hospital.search(params).to_sql}
        it "sqlが同一である" do
          sql = Hospital.within_near(params,current_location).order_by_distance(current_location).to_sql
          is_expected.to eq sql
        end
      end
      context "現在地から" do
        let(:params){{km:1, geo_location: '35.5612479,140.1880582', location: 'geo_location'}}
        let(:current_location){Hospital.location_params(params)}
        subject{Hospital.search(params).to_sql}
        it "sqlが同一である" do
          sql = Hospital.within_near(params,current_location).order_by_distance(current_location).to_sql
          is_expected.to eq sql
        end
      end

      context "params[km]なし" do
        let(:params){{geo_location: '35.5612479,140.1880582', location: 'geo_location'}}
        let(:current_location){Hospital.location_params(params)}
        subject{Hospital.search(params).to_sql}
        it "order_by_distanceが実行されること" do
          sql = Hospital.order_by_distance(current_location).to_sql
          is_expected.to eq sql
        end
      end

      context "params[ロケーション]なし" do
        let(:params){{km:1, location: 'geo_location'}}
        let(:current_location){Hospital.location_params(params)}
        subject{Hospital.search(params).to_sql}
        it_behaves_like 'equal all sql'
      end
    end

    describe "params[診療科目]" do
      context "paramsあり" do
        let(:params) {{subject: {ids:[1,2,3]}}}
        subject{Hospital.search(params).to_sql}
        it "診療科目での絞込のsqlと同一である" do
          sql = Hospital.where_subjects(params).to_sql
          is_expected.to eq sql
        end
      end

      context "paramsなし" do
        let(:empty_params) {{subject: {ids:[]}}}
        subject {Hospital.search(empty_params).to_sql}
        it_behaves_like 'equal all sql'
      end
    end

    describe "params[病院名]" do
      context "paramsあり" do
        let(:params) {{name: "病院名"}}
        subject {Hospital.search(params).to_sql}
        it "病院名での絞込のsqlと同一である" do
          sql = Hospital.like_name(params).to_sql
          is_expected.to eq sql
        end
      end

      context "paramsなし" do
        let(:empty_params) {{name: ''}}
        subject {Hospital.search(empty_params).to_sql}
        it_behaves_like 'equal all sql'
      end
    end

    describe "params[監督署]" do
      context "paramsあり" do
        let(:params) {{jurisdiction: "kashiwa"}}
        context "登録済みの監督署" do
          before do
            @kashiwa = create(:kashiwa)
          end
          subject {Hospital.search(params).to_sql}
          it "監督署での絞込のsqlと同一である" do
            sql = Hospital.eq_jurisdiction(@kashiwa).to_sql
            is_expected.to eq sql
          end
        end

        context "登録していない監督署" do
          subject {Hospital.search(params).to_sql}
          it_behaves_like 'equal all sql'
        end
      end

      context "paramsなし" do
        let(:empty_params) {{jurisdiction: ''}}
        subject {Hospital.search(empty_params).to_sql}
        it_behaves_like 'equal all sql'
      end
    end

    context "all_params_blank" do
      let(:params){{}}
      subject{Hospital.search(params).to_sql}
      it_behaves_like 'equal all sql'
    end
  end
end