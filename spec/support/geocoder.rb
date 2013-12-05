Geocoder.configure(lookup: :test)

chicago = [
  {
    'latitude'     => 41.9703133,
    'longitude'    => -87.663045,
    'address'      => 'Chicago, IL, USA',
    'state'        => 'Chicago',
    'state_code'   => 'IL',
    'country'      => 'United States',
    'country_code' => 'US'
  }
]

Geocoder::Lookup::Test.add_stub("Chicago, IL", chicago)
Geocoder::Lookup::Test.add_stub("Chicago, IL 60640", chicago)
