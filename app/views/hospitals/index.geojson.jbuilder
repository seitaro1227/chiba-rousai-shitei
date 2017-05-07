json.type 'FeatureCollection'
json.features do
  json.array!(@hospitals) do |hospital|
    json.type 'Feature'
    json.geometry do
      json.type 'Point'
      json.coordinates [hospital.longitude, hospital.latitude]
    end
    json.properties do
      json.number       hospital.number
      json.name         hospital.name
      json.address      hospital.address
      json.jurisdiction_name hospital.jurisdiction.name
      json.phone_number hospital.phone_number
      json.saikei       hospital.saikei
      json.niji         hospital.niji
      json.subject      hospital.orgin_subject
      json.zip_code     hospital.zip_code
    end
  end
end