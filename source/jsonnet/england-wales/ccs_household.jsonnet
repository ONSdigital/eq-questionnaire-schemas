local placeholders = import '../../lib/placeholders.libsonnet';

// Who lives here
local another_address_interviewer_note_interstitial = import 'ccs/blocks/who-lives-here/another_address_interviewer_note_interstitial.jsonnet';
local any_visitors = import 'ccs/blocks/who-lives-here/any_visitors.jsonnet';
local anyone_else_list_collector = import 'ccs/blocks/who-lives-here/anyone_else_list_collector.jsonnet';
local anyone_else_temp_away_list_collector = import 'ccs/blocks/who-lives-here/anyone_else_temp_away_list_collector.jsonnet';
local anyone_else_usually_living = import 'ccs/blocks/who-lives-here/anyone_else_usually_living.jsonnet';
local interviewer_note_interstitial = import 'ccs/blocks/who-lives-here/interviewer_note_interstitial.jsonnet';
local primary_person_list_collector = import 'ccs/blocks/who-lives-here/primary_person_list_collector.jsonnet';
local relationships = import 'ccs/blocks/who-lives-here/relationships.jsonnet';
local visitor_list_collector = import 'ccs/blocks/who-lives-here/visitor_list_collector.jsonnet';
local who_lives_here_interstitial = import 'ccs/blocks/who-lives-here/who_lives_here_interstitial.jsonnet';

// Accommodation
local accommodation_introduction = import 'ccs/blocks/accommodation/accommodation_introduction.jsonnet';
local accommodation_type = import 'ccs/blocks/accommodation/accommodation_type.jsonnet';
local government_services = import 'ccs/blocks/accommodation/government_services.jsonnet';
local internet = import 'ccs/blocks/accommodation/internet.jsonnet';
local interviewer_note = import 'ccs/blocks/accommodation/interviewer_note.jsonnet';
local other_living_accommodation = import 'ccs/blocks/accommodation/other_living_accommodation.jsonnet';
local own_or_rent = import 'ccs/blocks/accommodation/own_or_rent.jsonnet';
local self_contained = import 'ccs/blocks/accommodation/self_contained.jsonnet';
local type_of_flat = import 'ccs/blocks/accommodation/type_of_flat.jsonnet';
local type_of_house = import 'ccs/blocks/accommodation/type_of_house.jsonnet';
local who_rent_from = import 'ccs/blocks/accommodation/who_rent_from.jsonnet';

// Individual
local age_last_birthday = import 'ccs/blocks/individual/age_last_birthday.jsonnet';
local another_uk_address = import 'ccs/blocks/individual/another_uk_address.jsonnet';
local confirm_dob = import 'ccs/blocks/individual/confirm_dob.jsonnet';
local country_of_birth = import 'ccs/blocks/individual/country_of_birth.jsonnet';
local date_of_birth = import 'ccs/blocks/individual/date_of_birth.jsonnet';
local employment_status = import 'ccs/blocks/individual/employment_status.jsonnet';
local employment_type = import 'ccs/blocks/individual/employment_type.jsonnet';
local ethnic_group = import 'ccs/blocks/individual/ethnic_group.jsonnet';
local ethnic_group_asian = import 'ccs/blocks/individual/ethnic_group_asian.jsonnet';
local ethnic_group_black = import 'ccs/blocks/individual/ethnic_group_black.jsonnet';
local ethnic_group_mixed = import 'ccs/blocks/individual/ethnic_group_mixed.jsonnet';
local ethnic_group_other = import 'ccs/blocks/individual/ethnic_group_other.jsonnet';
local ethnic_group_white = import 'ccs/blocks/individual/ethnic_group_white.jsonnet';
local in_education = import 'ccs/blocks/individual/in_education.jsonnet';
local individual_interstitial = import 'ccs/blocks/individual/individual_interstitial.jsonnet';
local length_of_stay = import 'ccs/blocks/individual/length_of_stay.jsonnet';
local marriage_type = import 'ccs/blocks/individual/marriage_type.jsonnet';
local other_census_address = import 'ccs/blocks/individual/other_census_address.jsonnet';
local past_usual_household_address = import 'ccs/blocks/individual/past_usual_household_address.jsonnet';
local proxy = import 'ccs/blocks/individual/proxy.jsonnet';
local sex = import 'ccs/blocks/individual/sex.jsonnet';
local term_time_location = import 'ccs/blocks/individual/term_time_location.jsonnet';

//visitor
local visitor_dob = import 'ccs/blocks/visitor/date_of_birth.jsonnet';
local visitor_sex = import 'ccs/blocks/visitor/sex.jsonnet';
local usual_household_address = import 'ccs/blocks/visitor/usual_household_address.jsonnet';
local usual_household_address_details = import 'ccs/blocks/visitor/usual_household_address_details.jsonnet';
local visitor_age_last_birthday = import 'ccs/blocks/visitor/visitor_age_last_birthday.jsonnet';
local visitor_interstitial = import 'ccs/blocks/visitor/visitor_interstitial.jsonnet';

function(region_code, census_month_year_date) {
  mime_type: 'application/json/ons/eq',
  language: 'en',
  schema_version: '0.0.1',
  data_version: '0.0.3',
  survey_id: 'ccs',
  title: '2019 Census Coverage Survey Test',
  description: 'Census Coverage Survey Schema',
  theme: 'census',
  legal_basis: 'Voluntary',
  navigation: {
    visible: false,
  },
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
  hub: {
    enabled: true,
    complete: {
      title: 'Submit census',
      guidance: 'Please submit this census to complete it',
    },
    incomplete: {
      guidance: 'You must complete all sections in order to complete this census',
    },
    submission: {
      button: 'Submit census',
    },
    required_completed_sections: ['who-lives-here-section'],
  },
  sections: [
    {
      id: 'who-lives-here-section',
      title: 'This section is now complete',
      summary: {
        show_on_completion: true,
        items: [
          {
            type: 'List',
            for_list: 'household',
            title: 'Householder members',
            add_link_text: 'Add someone to this household',
            empty_list_text: 'There are no householders',
          },
          {
            type: 'List',
            for_list: 'visitors',
            title: 'Visitors',
            add_link_text: 'Add a visitor',
            empty_list_text: 'There are no visitors',
          },
        ],
      },
      groups: [
        {
          id: 'who-lives-here-group',
          title: 'Who lives here',
          blocks: [
            who_lives_here_interstitial,
            primary_person_list_collector,
            anyone_else_usually_living,
            interviewer_note_interstitial,
            another_address_interviewer_note_interstitial,
            anyone_else_list_collector,
            anyone_else_temp_away_list_collector,
            any_visitors,
            visitor_list_collector,
            relationships,
          ],
        },
      ],
    },
    {
      id: 'accommodation-section',
      title: 'Household accommodation',
      summary: { show_on_completion: false },
      groups: [
        {
          id: 'accommodation-group',
          title: '',
          blocks: [
            accommodation_introduction,
            interviewer_note,
            accommodation_type,
            type_of_house,
            type_of_flat,
            self_contained,
            own_or_rent,
            who_rent_from,
            internet,
            government_services,
            other_living_accommodation,
          ],
        },
      ],
    },
    {
      id: 'individual-section',
      title: 'Individual Section',
      summary: { show_on_completion: false },
      repeat: {
        for_list: 'household',
        title: {
          text: '{person_name}',
          placeholders: [
            {
              placeholder: 'person_name',
              transforms: [
                {
                  transform: 'concatenate_list',
                  arguments: {
                    list_to_concatenate: {
                      source: 'answers',
                      identifier: ['first-name', 'last-name'],
                    },
                    delimiter: ' ',
                  },
                },
              ],
            },
          ],
        },
      },
      groups: [
        {
          id: 'personal-details-group',
          title: 'Personal Details',
          blocks: [
            individual_interstitial,
            proxy,
            date_of_birth,
            age_last_birthday,
            confirm_dob,
            sex,
            country_of_birth,
            marriage_type,
            ethnic_group(region_code),
            ethnic_group_white(region_code),
            ethnic_group_mixed(region_code),
            ethnic_group_asian(region_code),
            ethnic_group_black(region_code),
            ethnic_group_other(region_code),
            in_education,
            term_time_location,
            past_usual_household_address,
            length_of_stay,
            employment_status,
            employment_type,
            another_uk_address,
            other_census_address,
          ],
        },
      ],
    },
    {
      id: 'visitor-section',
      title: 'Visitors',
      repeat: {
        for_list: 'visitors',
        title: {
          text: '{person_name} (Visitor)',
          placeholders: [
            {
              placeholder: 'person_name',
              transforms: [
                {
                  transform: 'concatenate_list',
                  arguments: {
                    list_to_concatenate: {
                      source: 'answers',
                      identifier: ['first-name', 'last-name'],
                    },
                    delimiter: ' ',
                  },
                },
              ],
            },
          ],
        },
      },
      groups: [
        {
          id: 'visitor-group',
          title: '',
          blocks: [
            visitor_interstitial,
            visitor_dob,
            visitor_age_last_birthday,
            visitor_sex,
            usual_household_address,
            usual_household_address_details,
          ],
        },
      ],
    },
  ],
}
