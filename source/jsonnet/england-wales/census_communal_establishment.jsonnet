// establishment details
local detention_establishment = import 'communal-establishment/blocks/establishment-details/detention_establishment.jsonnet';
local education_establishment = import 'communal-establishment/blocks/establishment-details/education_establishment.jsonnet';
local live_in_establishment = import 'communal-establishment/blocks/establishment-details/live_in_establishment.jsonnet';
local medical_establishment = import 'communal-establishment/blocks/establishment-details/medical_establishment.jsonnet';
local establishment_details = import 'communal-establishment/blocks/establishment-details/nature_of_establishment.jsonnet';
local number_of_visitors_in_establishment = import 'communal-establishment/blocks/establishment-details/number_of_visitors_in_establishment.jsonnet';
local people_in_establishment = import 'communal-establishment/blocks/establishment-details/people_in_establishment.jsonnet';
local responsible_for_establishment = import 'communal-establishment/blocks/establishment-details/responsible_for_establishment.jsonnet';
local travel_establishment = import 'communal-establishment/blocks/establishment-details/travel_establishment.jsonnet';
local visitors_in_establishment = import 'communal-establishment/blocks/establishment-details/visitors_in_establishment.jsonnet';

function(region_code, census_month_year_date) {
  mime_type: 'application/json/ons/eq',
  schema_version: '0.0.1',
  data_version: '0.0.3',
  survey_id: 'census',
  title: '2021 Census',
  description: 'Census Communal Establishment',
  theme: 'census',
  legal_basis: 'Voluntary',
  metadata: [
    {
      name: 'user_id',
      type: 'string',
    },
    {
      name: 'period_id',
      type: 'string',
    },
    {
      name: 'display_address',
      type: 'string',
    },
  ],
  sections: [
    {
      id: 'communal-establishment',
      title: 'Communal Establishment',
      groups: [
        {
          id: 'establishment-details-group',
          title: 'Personal Details',
          blocks: [
            establishment_details,
            medical_establishment,
            responsible_for_establishment,
            education_establishment,
            detention_establishment,
            travel_establishment,
            live_in_establishment,
            people_in_establishment,
            visitors_in_establishment,
            number_of_visitors_in_establishment,
          ],
        },
      ],
    },
    {
      id: 'submit-answers-section',
      title: 'Submit answers',
      groups: [
        {
          id: 'submit-group',
          title: 'Submit answers',
          blocks: [
            {
              id: 'summary',
              type: 'Summary',
            },
          ],
        },
      ],
    },
  ],
}
