local placeholders = import '../../lib/placeholders.libsonnet';

// Accommodation
local accommodation_introduction = import 'household/blocks/accommodation/accommodation_introduction.jsonnet';
local accommodation_type = import 'household/blocks/accommodation/accommodation_type.jsonnet';
local central_heating = import 'household/blocks/accommodation/central_heating.jsonnet';
local number_bedrooms = import 'household/blocks/accommodation/number_bedrooms.jsonnet';
local number_of_vehicles = import 'household/blocks/accommodation/number_of_vehicles.jsonnet';
local own_or_rent = import 'household/blocks/accommodation/own_or_rent.jsonnet';
local self_contained = import 'household/blocks/accommodation/self_contained.jsonnet';
local type_of_flat = import 'household/blocks/accommodation/type_of_flat.jsonnet';
local type_of_house = import 'household/blocks/accommodation/type_of_house.jsonnet';
local who_rent_from = import 'household/blocks/accommodation/who_rent_from.jsonnet';

// Who lives here
local any_visitors = import 'household/blocks/who-lives-here/any_visitors.jsonnet';
local anyone_else = import 'household/blocks/who-lives-here/anyone_else.jsonnet';
local anyone_else_list_collector = import 'household/blocks/who-lives-here/anyone_else_list_collector.jsonnet';
local anyone_else_temporarily_away_list_collector = import 'household/blocks/who-lives-here/anyone_else_temporarily_away_list_collector.jsonnet';
local primary_person_list_collector = import 'household/blocks/who-lives-here/primary_person_list_collector.jsonnet';
local visitor_list_collector = import 'household/blocks/who-lives-here/visitor_list_collector.jsonnet';
local who_lives_here_interstitial = import 'household/blocks/who-lives-here/who_lives_here_interstitial.jsonnet';

// Relationships
local relationships_collector = import 'household/blocks/relationships/relationships_collector.jsonnet';
local relationships_interstitial = import 'household/blocks/relationships/relationships_interstitial.jsonnet';

// Personal Details
local individual_interstitial = import 'household/blocks/individual/individual_interstitial.jsonnet';
local proxy = import 'household/blocks/individual/proxy.jsonnet';
local address_type = import 'individual/blocks/personal-details/address_type.jsonnet';
local another_address = import 'individual/blocks/personal-details/another_address.jsonnet';
local another_address_outside_uk = import 'individual/blocks/personal-details/another_address_outside_uk.jsonnet';
local confirm_dob = import 'individual/blocks/personal-details/confirm_dob.jsonnet';
local current_marriage_status = import 'individual/blocks/personal-details/current_marriage_status.jsonnet';
local current_partnership_status = import 'individual/blocks/personal-details/current_partnership_status.jsonnet';
local date_of_birth = import 'individual/blocks/personal-details/date_of_birth.jsonnet';
local in_education = import 'individual/blocks/personal-details/in_education.jsonnet';
local marriage_type = import 'individual/blocks/personal-details/marriage_type.jsonnet';
local other_uk_address = import 'individual/blocks/personal-details/other_uk_address.jsonnet';
local previous_marriage_status = import 'individual/blocks/personal-details/previous_marriage_status.jsonnet';
local previous_partnership_status = import 'individual/blocks/personal-details/previous_partnership_status.jsonnet';
local sex = import 'individual/blocks/personal-details/sex.jsonnet';
local term_time_address_country = import 'individual/blocks/personal-details/term_time_address_country.jsonnet';
local term_time_address_country_outside_uk = import 'individual/blocks/personal-details/term_time_address_country_outside_uk.jsonnet';
local term_time_address_details = import 'individual/blocks/personal-details/term_time_address_details.jsonnet';
local term_time_location = import 'individual/blocks/personal-details/term_time_location.jsonnet';

// Identity and Health
local past_usual_household_address = import 'household/blocks/individual/past_usual_household_address.jsonnet';
local arrive_in_country = import 'individual/blocks/identity-and-health/arrive_in_country.jsonnet';
local birth_gender = import 'individual/blocks/identity-and-health/birth_gender.jsonnet';
local carer = import 'individual/blocks/identity-and-health/carer.jsonnet';
local country_of_birth = import 'individual/blocks/identity-and-health/country_of_birth.jsonnet';
local country_of_birth_elsewhere = import 'individual/blocks/identity-and-health/country_of_birth_elsewhere.jsonnet';
local disability = import 'individual/blocks/identity-and-health/disability.jsonnet';
local disability_limitation = import 'individual/blocks/identity-and-health/disability_limitation.jsonnet';
local ethnic_group = import 'individual/blocks/identity-and-health/ethnic_group.jsonnet';
local ethnic_group_asian = import 'individual/blocks/identity-and-health/ethnic_group_asian.jsonnet';
local ethnic_group_asian_other = import 'individual/blocks/identity-and-health/ethnic_group_asian_other.jsonnet';
local ethnic_group_black = import 'individual/blocks/identity-and-health/ethnic_group_black.jsonnet';
local ethnic_group_black_african = import 'individual/blocks/identity-and-health/ethnic_group_black_african.jsonnet';
local ethnic_group_black_other = import 'individual/blocks/identity-and-health/ethnic_group_black_other.jsonnet';
local ethnic_group_mixed = import 'individual/blocks/identity-and-health/ethnic_group_mixed.jsonnet';
local ethnic_group_mixed_other = import 'individual/blocks/identity-and-health/ethnic_group_mixed_other.jsonnet';
local ethnic_group_other = import 'individual/blocks/identity-and-health/ethnic_group_other.jsonnet';
local ethnic_group_other_other = import 'individual/blocks/identity-and-health/ethnic_group_other_other.jsonnet';
local ethnic_group_white = import 'individual/blocks/identity-and-health/ethnic_group_white.jsonnet';
local ethnic_group_white_other = import 'individual/blocks/identity-and-health/ethnic_group_white_other.jsonnet';
local health = import 'individual/blocks/identity-and-health/health.jsonnet';
local language = import 'individual/blocks/identity-and-health/language.jsonnet';
local language_other = import 'individual/blocks/identity-and-health/language_other.jsonnet';
local last_year_address = import 'individual/blocks/identity-and-health/last_year_address.jsonnet';
local length_of_stay = import 'individual/blocks/identity-and-health/length_of_stay.jsonnet';
local national_identity = import 'individual/blocks/identity-and-health/national_identity.jsonnet';
local national_identity_additional_other = import 'individual/blocks/identity-and-health/national_identity_additional_other.jsonnet';
local national_identity_other = import 'individual/blocks/identity-and-health/national_identity_other.jsonnet';
local passports = import 'individual/blocks/identity-and-health/passports.jsonnet';
local passports_additional_other = import 'individual/blocks/identity-and-health/passports_additional_other.jsonnet';
local passports_other = import 'individual/blocks/identity-and-health/passports_other.jsonnet';
local past_usual_address_outside_uk = import 'individual/blocks/identity-and-health/past_usual_address_outside_uk.jsonnet';
local religion = import 'individual/blocks/identity-and-health/religion.jsonnet';
local religion_other = import 'individual/blocks/identity-and-health/religion_other.jsonnet';
local sexual_identity = import 'individual/blocks/identity-and-health/sexual_identity.jsonnet';
local speak_english = import 'individual/blocks/identity-and-health/speak_english.jsonnet';
local understand_welsh = import 'individual/blocks/identity-and-health/understand_welsh.jsonnet';
local when_arrive_in_uk = import 'individual/blocks/identity-and-health/when_arrive_in_uk.jsonnet';

// Qualifications
local a_level = import 'individual/blocks/qualifications/a_level.jsonnet';
local apprenticeship = import 'individual/blocks/qualifications/apprenticeship.jsonnet';
local degree = import 'individual/blocks/qualifications/degree.jsonnet';
local gcse = import 'individual/blocks/qualifications/gcse.jsonnet';
local nvq_level = import 'individual/blocks/qualifications/nvq_level.jsonnet';
local other_qualifications = import 'individual/blocks/qualifications/other_qualifications.jsonnet';
local qualifications = import 'individual/blocks/qualifications/qualifications.jsonnet';

// Employment
local armed_forces = import 'individual/blocks/employment/armed_forces.jsonnet';
local business_name = import 'individual/blocks/employment/business_name.jsonnet';
local employer_address_depot = import 'individual/blocks/employment/employer_address_depot.jsonnet';
local employer_address_workplace = import 'individual/blocks/employment/employer_address_workplace.jsonnet';
local employer_type_of_address = import 'individual/blocks/employment/employer_type_of_address.jsonnet';
local employers_business = import 'individual/blocks/employment/employers_business.jsonnet';
local employment_status = import 'individual/blocks/employment/employment_status.jsonnet';
local employment_type = import 'individual/blocks/employment/employment_type.jsonnet';
local ever_worked = import 'individual/blocks/employment/ever_worked.jsonnet';
local hours_worked = import 'individual/blocks/employment/hours_worked.jsonnet';
local job_availability = import 'individual/blocks/employment/job_availability.jsonnet';
local job_description = import 'individual/blocks/employment/job_description.jsonnet';
local job_pending = import 'individual/blocks/employment/job_pending.jsonnet';
local job_title = import 'individual/blocks/employment/job_title.jsonnet';
local jobseeker = import 'individual/blocks/employment/jobseeker.jsonnet';
local main_employment_block = import 'individual/blocks/employment/main_employment_block.jsonnet';
local main_job_type = import 'individual/blocks/employment/main_job_type.jsonnet';
local mainly_work_in_uk = import 'individual/blocks/employment/mainly_work_in_uk.jsonnet';
local mainly_work_outside_uk = import 'individual/blocks/employment/mainly_work_outside_uk.jsonnet';
local supervise = import 'individual/blocks/employment/supervise.jsonnet';
local work_travel = import 'individual/blocks/employment/work_travel.jsonnet';

// Visitor
local visitor_dob = import 'household/blocks/visitor/date_of_birth.jsonnet';
local visitor_sex = import 'household/blocks/visitor/sex.jsonnet';
local usual_household_address = import 'household/blocks/visitor/usual_household_address.jsonnet';
local usual_household_address_details = import 'household/blocks/visitor/usual_household_address_details.jsonnet';
local usual_household_address_other = import 'household/blocks/visitor/usual_household_address_other.jsonnet';

local visitor_interstitial = import 'household/blocks/visitor/visitor_interstitial.jsonnet';

local understandWelshBlock(region_code) = if region_code == 'GB-WLS' then [understand_welsh] else [];

function(region_code, census_month_year_date) {
  mime_type: 'application/json/ons/eq',
  language: 'en',
  schema_version: '0.0.1',
  data_version: '0.0.3',
  survey_id: 'census',
  title: '2019 Census Test',
  description: 'Census Household Schema',
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
    required_completed_sections: ['who-lives-here-section', 'relationships-section'],
  },
  sections: [
    {
      id: 'who-lives-here-section',
      title: 'People who live here',
      summary: {
        show_on_completion: true,
        title: {
          text: 'People who live at {household_address} and overnight visitors',
          placeholders: [
            placeholders.address,
          ],
        },
        items: [
          {
            type: 'List',
            for_list: 'household',
            title: {
              text_plural: {
                forms: {
                  one: 'You said {cardinality} person is living here on Sunday {census_date}',
                  other: 'You said {cardinality} people are living here on Sunday {census_date}',
                },
                count: {
                  source: 'list',
                  identifier: 'household',
                },
              },

              placeholders: [
                placeholders.censusDate,
                placeholders.getListCardinality('household'),
              ],
            },
            add_link_text: 'Add someone to this household',
            empty_list_text: 'There are no householders',
          },
          {
            type: 'List',
            for_list: 'visitors',
            title: {
              text_plural: {
                forms: {
                  one: 'You said {cardinality} visitor is staying overnight here on Sunday {census_date}',
                  other: 'You said {cardinality} visitors are staying overnight here on Sunday {census_date}',
                },
                count: {
                  source: 'list',
                  identifier: 'visitors',
                },
              },

              placeholders: [
                placeholders.censusDate,
                placeholders.getListCardinality('visitors'),
              ],
            },
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
            anyone_else,
            anyone_else_list_collector,
            anyone_else_temporarily_away_list_collector,
            any_visitors,
            visitor_list_collector,
          ],
        },
      ],
    },
    {
      id: 'relationships-section',
      title: 'Relationships',
      show_on_hub: false,
      groups: [
        {
          id: 'relationships-group',
          title: 'Relationships',
          blocks: [
            relationships_interstitial,
            relationships_collector,
          ],
        },
      ],
      enabled: [
        {
          when: [
            {
              list: 'household',
              condition: 'greater than',
              value: 1,
            },
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
            accommodation_type,
            type_of_house,
            type_of_flat,
            self_contained,
            number_bedrooms,
            central_heating,
            own_or_rent,
            who_rent_from,
            number_of_vehicles,
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
            confirm_dob,
            sex,
            marriage_type,
            current_marriage_status,
            previous_marriage_status,
            current_partnership_status,
            previous_partnership_status,
            another_address,
            another_address_outside_uk,
            other_uk_address,
            address_type,
            in_education,
            term_time_location,
            term_time_address_country,
            term_time_address_country_outside_uk,
            term_time_address_details,
          ],
        },
        {
          id: 'identity-and-health-group',
          title: 'Identity and Health',
          blocks: [
            country_of_birth(region_code),
            country_of_birth_elsewhere,
            arrive_in_country(region_code, census_month_year_date),
            when_arrive_in_uk(region_code),
            length_of_stay,
            past_usual_household_address,
            past_usual_address_outside_uk,
            last_year_address,
            national_identity(region_code),
            national_identity_other,
            national_identity_additional_other,
            ethnic_group(region_code),
            ethnic_group_white(region_code),
            ethnic_group_white_other,
            ethnic_group_mixed,
            ethnic_group_mixed_other,
            ethnic_group_asian(region_code),
            ethnic_group_asian_other(region_code),
            ethnic_group_black(region_code),
            ethnic_group_black_african,
            ethnic_group_black_other(region_code),
            ethnic_group_other,
            ethnic_group_other_other,
            religion(region_code),
            religion_other,
          ] + understandWelshBlock(region_code) + [
            language(region_code),
            language_other,
            speak_english,
            passports,
            passports_other,
            passports_additional_other,
            health,
            disability,
            disability_limitation,
            carer,
            sexual_identity,
            birth_gender,
          ],
        },
        {
          id: 'qualifications-group',
          title: 'Qualifications',
          blocks: [
            qualifications(region_code),
            apprenticeship(region_code),
            degree(region_code),
            nvq_level(region_code),
            a_level(region_code),
            gcse(region_code),
            other_qualifications(region_code),
          ],
        },
        {
          id: 'employment-group',
          title: 'Employment',
          blocks: [
            armed_forces,
            employment_status,
            employment_type,
            jobseeker,
            job_availability,
            job_pending,
            ever_worked,
            main_employment_block,
            main_job_type,
            business_name,
            job_title,
            job_description,
            employers_business(region_code),
            supervise,
            hours_worked,
            work_travel,
            employer_type_of_address,
            mainly_work_in_uk,
            employer_address_workplace,
            employer_address_depot,
            mainly_work_outside_uk,
          ],
        },
      ],
    },
    {
      id: 'visitor-section',
      title: 'Visitors',
      summary: { show_on_completion: false },
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
            visitor_sex,
            usual_household_address,
            usual_household_address_details,
            usual_household_address_other,
          ],
        },
      ],
    },
  ],
}
