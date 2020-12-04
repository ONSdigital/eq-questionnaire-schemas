local rules = import '../../lib/common_rules.libsonnet';
local placeholders = import '../../lib/placeholders.libsonnet';

// Who lives here
local another_address_interviewer_note = import 'ccs/blocks/who-lives-here/another_address_interviewer_note.jsonnet';
local any_more_people_living_here = import 'ccs/blocks/who-lives-here/any_more_people_living_here.jsonnet';
local any_more_visitors = import 'ccs/blocks/who-lives-here/any_more_visitors.jsonnet';
local any_visitors = import 'ccs/blocks/who-lives-here/any_visitors.jsonnet';
local anyone_else_driver = import 'ccs/blocks/who-lives-here/anyone_else_driver.jsonnet';
local anyone_else_usually_living_here = import 'ccs/blocks/who-lives-here/anyone_else_usually_living_here.jsonnet';
local anyone_related = import 'ccs/blocks/who-lives-here/anyone_related.jsonnet';
local outside_uk_note = import 'ccs/blocks/who-lives-here/outside_uk_note.jsonnet';
local usual_address = import 'ccs/blocks/who-lives-here/usual_address.jsonnet';
local usual_address_in_uk = import 'ccs/blocks/who-lives-here/usual_address_in_uk.jsonnet';
local were_you_usually_living_here = import 'ccs/blocks/who-lives-here/were_you_usually_living_here.jsonnet';
local who_else_lives_here = import 'ccs/blocks/who-lives-here/who_else_lives_here.jsonnet';
local who_lives_here_introduction = import 'ccs/blocks/who-lives-here/who_lives_here_introduction.jsonnet';
local who_to_interview_note = import 'ccs/blocks/who-lives-here/who_to_interview_note.jsonnet';

// Accommodation
local accommodation_introduction = import 'ccs/blocks/accommodation/accommodation_introduction.jsonnet';
local accommodation_type = import 'ccs/blocks/accommodation/accommodation_type.jsonnet';
local government_services = import 'ccs/blocks/accommodation/government_services.jsonnet';
local internet = import 'ccs/blocks/accommodation/internet.jsonnet';
local own_or_rent = import 'ccs/blocks/accommodation/own_or_rent.jsonnet';
local respondent_living_at = import 'ccs/blocks/accommodation/respondent_living_at.jsonnet';
local rooms_shared_with_another_household = import 'ccs/blocks/accommodation/rooms_shared_with_another_household.jsonnet';
local type_of_flat = import 'ccs/blocks/accommodation/type_of_flat.jsonnet';
local type_of_house = import 'ccs/blocks/accommodation/type_of_house.jsonnet';
local who_rent_from = import 'ccs/blocks/accommodation/who_rent_from.jsonnet';

// Individual
local address_one_year_ago = import 'ccs/blocks/individual/address_one_year_ago.jsonnet';
local age_last_birthday = import 'ccs/blocks/individual/age_last_birthday.jsonnet';
local another_uk_address = import 'ccs/blocks/individual/another_uk_address.jsonnet';
local confirm_age = import 'ccs/blocks/individual/confirm_age.jsonnet';
local country_of_birth = import 'ccs/blocks/individual/country_of_birth.jsonnet';
local date_of_birth = import 'ccs/blocks/individual/date_of_birth.jsonnet';
local employment_status = import 'ccs/blocks/individual/employment_status.jsonnet';
local employment_type = import 'ccs/blocks/individual/employment_type.jsonnet';
local ethnic_group = import 'ccs/blocks/individual/ethnic_group.jsonnet';
local ethnic_group_asian_or_asian_british = import 'ccs/blocks/individual/ethnic_group_asian_or_asian_british.jsonnet';
local ethnic_group_black_black_british_caribbean_or_african = import 'ccs/blocks/individual/ethnic_group_black_black_british_caribbean_or_african.jsonnet';
local ethnic_group_mixed_or_multiple = import 'ccs/blocks/individual/ethnic_group_mixed_or_multiple.jsonnet';
local ethnic_group_other = import 'ccs/blocks/individual/ethnic_group_other.jsonnet';
local in_education = import 'ccs/blocks/individual/in_education.jsonnet';
local individual_introduction = import 'ccs/blocks/individual/individual_introduction.jsonnet';
local length_of_stay = import 'ccs/blocks/individual/length_of_stay.jsonnet';
local marital_or_civil_partnership_status = import 'ccs/blocks/individual/marital_or_civil_partnership_status.jsonnet';
local other_uk_address = import 'ccs/blocks/individual/other_uk_address.jsonnet';
local sex = import 'ccs/blocks/individual/sex.jsonnet';
local term_time_location = import 'ccs/blocks/individual/term_time_location.jsonnet';
local white_ethnic_group = import 'ccs/blocks/individual/white_ethnic_group.jsonnet';
local who_is_answering = import 'ccs/blocks/individual/who_is_answering.jsonnet';

// Visitor
local visitor_dob = import 'ccs/blocks/visitor/date_of_birth.jsonnet';
local visitor_sex = import 'ccs/blocks/visitor/sex.jsonnet';
local visitor_age_last_birthday = import 'ccs/blocks/visitor/visitor_age_last_birthday.jsonnet';
local visitor_introduction = import 'ccs/blocks/visitor/visitor_introduction.jsonnet';
local visitor_usual_address = import 'ccs/blocks/visitor/visitor_usual_address.jsonnet';
local visitor_usual_address_details = import 'ccs/blocks/visitor/visitor_usual_address_details.jsonnet';

// Household check
local household_check_introduction = import 'ccs/blocks/household-check/household_check_introduction.jsonnet';
local other_living_accommodation = import 'ccs/blocks/household-check/other_living_accommodation.jsonnet';
local separate_household = import 'ccs/blocks/household-check/separate_household.jsonnet';


function(region_code, census_month_year_date) {
  mime_type: 'application/json/ons/eq',
  language: 'en',
  schema_version: '0.0.1',
  data_version: '0.0.3',
  survey_id: 'ccs',
  survey: 'CCS',
  form_type: 'H',
  region_code: region_code,
  title: 'Census Coverage Survey 2021',
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
    required_completed_sections: ['who-lives-here-and-visitors'],
  },
  sections: [
    {
      id: 'who-lives-here-and-visitors',
      title: 'Household members and visitors',
      summary: {
        show_on_completion: true,
        items: [
          {
            type: 'List',
            for_list: 'household',
            title: 'Household members',
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
            who_lives_here_introduction,
            were_you_usually_living_here,
            anyone_else_usually_living_here,
            usual_address_in_uk,
            outside_uk_note,
            usual_address,
            anyone_else_driver,
            who_to_interview_note,
            another_address_interviewer_note,
            who_else_lives_here,
            any_more_people_living_here,
            anyone_related,
            any_visitors,
            any_more_visitors,
          ],
        },
      ],
    },
    {
      id: 'accommodation-section',
      title: 'Household and accommodation',
      summary: { show_on_completion: false },
      enabled: [
        {
          when: [
            rules.listIsNotEmpty('household'),
          ],
        },
      ],
      groups: [
        {
          id: 'accommodation-group',
          blocks: [
            accommodation_introduction,
            respondent_living_at,
            accommodation_type,
            type_of_house,
            type_of_flat,
            rooms_shared_with_another_household,
            own_or_rent,
            who_rent_from,
            internet,
            government_services,
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
          blocks: [
            individual_introduction,
            who_is_answering,
            date_of_birth,
            age_last_birthday,
            confirm_age,
            sex,
            country_of_birth,
            marital_or_civil_partnership_status,
            ethnic_group(region_code),
            white_ethnic_group(region_code),
            ethnic_group_mixed_or_multiple(region_code),
            ethnic_group_asian_or_asian_british(region_code),
            ethnic_group_black_black_british_caribbean_or_african(region_code),
            ethnic_group_other(region_code),
            in_education,
            term_time_location,
            address_one_year_ago,
            length_of_stay,
            employment_status,
            employment_type,
            another_uk_address,
            other_uk_address,
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
      summary: {
        show_on_completion: false,
      },
      groups: [
        {
          id: 'visitor-group',
          blocks: [
            visitor_introduction,
            visitor_dob,
            visitor_age_last_birthday,
            visitor_sex,
            visitor_usual_address,
            visitor_usual_address_details,
          ],
        },
      ],
    },
    {
      id: 'household-check',
      title: 'Final check – other households',
      summary: {
        show_on_completion: false,
      },
      enabled: [
        {
          when: [
            rules.listIsNotEmpty('household'),
          ],
        },
      ],
      groups: [
        {
          id: 'household-check-group',
          blocks: [
            household_check_introduction,
            other_living_accommodation,
            separate_household,
          ],
        },
      ],
    },
  ],
}
