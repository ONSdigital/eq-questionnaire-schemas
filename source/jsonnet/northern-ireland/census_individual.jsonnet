// Personal Details
local accommodation_type = import 'individual/blocks/personal-details/accommodation_type.jsonnet';
local age_last_birthday = import 'individual/blocks/personal-details/age_last_birthday.jsonnet';
local confirm_age = import 'individual/blocks/personal-details/confirm_age.jsonnet';
local proxy = import 'individual/blocks/personal-details/confirm_who_is_answering.jsonnet';
local date_of_birth = import 'individual/blocks/personal-details/date_of_birth.jsonnet';
local establishment_position = import 'individual/blocks/personal-details/establishment_position.jsonnet';
local in_education = import 'individual/blocks/personal-details/in_education.jsonnet';
local marriage_or_civil_partnership_status = import 'individual/blocks/personal-details/marriage_or_civil_partnership_status.jsonnet';
local name = import 'individual/blocks/personal-details/name.jsonnet';
local sex = import 'individual/blocks/personal-details/sex.jsonnet';
local term_time_address_country_outside_uk = import 'individual/blocks/personal-details/term_time_address_country_outside_uk.jsonnet';
local term_time_address_uk = import 'individual/blocks/personal-details/term_time_address_uk.jsonnet';
local term_time_location = import 'individual/blocks/personal-details/term_time_location.jsonnet';

// Identity and Health
local address_one_year_ago = import 'individual/blocks/identity-and-health/address_one_year_ago.jsonnet';
local address_one_year_ago_outside_uk = import 'individual/blocks/identity-and-health/address_one_year_ago_outside_uk.jsonnet';
local arrive_in_country = import 'individual/blocks/identity-and-health/arrive_in_country.jsonnet';
local childhood_religion = import 'individual/blocks/identity-and-health/childhood_religion.jsonnet';
local childhood_religion_other = import 'individual/blocks/identity-and-health/childhood_religion_other.jsonnet';
local country_of_birth = import 'individual/blocks/identity-and-health/country_of_birth.jsonnet';
local country_of_birth_elsewhere = import 'individual/blocks/identity-and-health/country_of_birth_elsewhere.jsonnet';
local ethnic_group = import 'individual/blocks/identity-and-health/ethnic_group.jsonnet';
local ethnic_group_other = import 'individual/blocks/identity-and-health/ethnic_group_other.jsonnet';
local frequency_irish = import 'individual/blocks/identity-and-health/frequency_irish.jsonnet';
local frequency_ulster_scots = import 'individual/blocks/identity-and-health/frequency_ulster_scots.jsonnet';
local health = import 'individual/blocks/identity-and-health/health.jsonnet';
local health_conditions_or_illnesses_limitations = import 'individual/blocks/identity-and-health/health_conditions_or_illnesses_limitations.jsonnet';
local level_of_spoken_english = import 'individual/blocks/identity-and-health/level_of_spoken_english.jsonnet';
local location_one_year_ago = import 'individual/blocks/identity-and-health/location_one_year_ago.jsonnet';
local look_after_or_support_others = import 'individual/blocks/identity-and-health/look_after_or_support_others.jsonnet';
local language = import 'individual/blocks/identity-and-health/main_language.jsonnet';
local national_identity = import 'individual/blocks/identity-and-health/national_identity.jsonnet';
local other_health_conditions = import 'individual/blocks/identity-and-health/other_health_conditions.jsonnet';
local other_main_language = import 'individual/blocks/identity-and-health/other_main_language.jsonnet';
local other_national_identities = import 'individual/blocks/identity-and-health/other_national_identities.jsonnet';
local other_national_identity = import 'individual/blocks/identity-and-health/other_national_identity.jsonnet';
local passports = import 'individual/blocks/identity-and-health/passports.jsonnet';
local passports_additional_other = import 'individual/blocks/identity-and-health/passports_additional_other.jsonnet';
local passports_other = import 'individual/blocks/identity-and-health/passports_other.jsonnet';
local physical_health_conditions = import 'individual/blocks/identity-and-health/physical_health_conditions.jsonnet';
local religion = import 'individual/blocks/identity-and-health/religion.jsonnet';
local religion_other = import 'individual/blocks/identity-and-health/religion_other.jsonnet';
local sexual_orientation = import 'individual/blocks/identity-and-health/sexual_orientation.jsonnet';
local understand_irish = import 'individual/blocks/identity-and-health/understand_irish.jsonnet';
local understand_ulster_scots = import 'individual/blocks/identity-and-health/understand_ulster_scots.jsonnet';

// School
local study_location = import 'individual/blocks/school/study_location.jsonnet';
local study_location_country = import 'individual/blocks/school/study_location_country.jsonnet';
local study_location_in_northern_ireland = import 'individual/blocks/school/study_location_in_northern_ireland.jsonnet';
local study_location_type = import 'individual/blocks/school/study_location_type.jsonnet';
local travel_to_study_location = import 'individual/blocks/school/travel_to_study_location.jsonnet';

// Qualifications
local a_level = import 'individual/blocks/qualifications/a_level.jsonnet';
local apprenticeship = import 'individual/blocks/qualifications/apprenticeship.jsonnet';
local degree = import 'individual/blocks/qualifications/degree_level_or_above.jsonnet';
local gcse = import 'individual/blocks/qualifications/gcse.jsonnet';
local nvq_level = import 'individual/blocks/qualifications/nvq_level.jsonnet';
local other_qualifications = import 'individual/blocks/qualifications/other_qualifications.jsonnet';
local qualifications = import 'individual/blocks/qualifications/qualifications_introduction.jsonnet';

// Employment
local about_to_start_job = import 'individual/blocks/employment/about_to_start_job.jsonnet';
local available_for_work = import 'individual/blocks/employment/available_for_work.jsonnet';
local business_name = import 'individual/blocks/employment/business_name.jsonnet';
local business_type = import 'individual/blocks/employment/business_type.jsonnet';
local employment_status_last_seven_days = import 'individual/blocks/employment/employment_status_last_seven_days.jsonnet';
local ever_worked = import 'individual/blocks/employment/ever_worked.jsonnet';
local hours_worked = import 'individual/blocks/employment/hours_worked.jsonnet';
local job_description = import 'individual/blocks/employment/job_description.jsonnet';
local job_title = import 'individual/blocks/employment/job_title.jsonnet';
local looking_for_work = import 'individual/blocks/employment/looking_for_work.jsonnet';
local main_job_introduction = import 'individual/blocks/employment/main_job_introduction.jsonnet';
local main_job_status = import 'individual/blocks/employment/main_job_status.jsonnet';
local not_employed_status_last_seven_days = import 'individual/blocks/employment/not_employed_status_last_seven_days.jsonnet';
local supervise_others = import 'individual/blocks/employment/supervise_others.jsonnet';
local travel_to_work = import 'individual/blocks/employment/travel_to_work.jsonnet';
local workplace_address = import 'individual/blocks/employment/workplace_address.jsonnet';
local workplace_country = import 'individual/blocks/employment/workplace_country.jsonnet';
local workplace_location = import 'individual/blocks/employment/workplace_location.jsonnet';
local workplace_outside_northern_ireland = import 'individual/blocks/employment/workplace_outside_northern_ireland.jsonnet';
local workplace_type = import 'individual/blocks/employment/workplace_type.jsonnet';

function(region_code) {
  mime_type: 'application/json/ons/eq',
  language: 'en',
  schema_version: '0.0.1',
  data_version: '0.0.3',
  survey_id: 'census',
  title: 'Census 2021',
  description: 'Census England Individual Schema',
  theme: 'census-nisra',
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
  submission: {
    button: 'Submit census',
    guidance: 'By submitting this census return you are confirming that, to the best of your knowledge and belief, the details provided are correct.',
    title: 'Submit census',
    warning: 'You must submit this census to complete it',
    confirmation_email: true,
  },
  sections: [
    {
      id: 'individual-section',
      title: 'Individual Section',
      groups: [
        {
          id: 'personal-details-group',
          title: 'Personal details',
          blocks: [
            accommodation_type,
            proxy,
            name,
            establishment_position,
            date_of_birth,
            confirm_age,
            age_last_birthday,
            sex,
            marriage_or_civil_partnership_status,
            in_education,
            term_time_location,
            term_time_address_uk,
            term_time_address_country_outside_uk,
          ],
        },
        {
          id: 'identity-and-health-group',
          title: 'Identity and health',
          blocks: [
            country_of_birth,
            country_of_birth_elsewhere,
            arrive_in_country,
            location_one_year_ago,
            address_one_year_ago_outside_uk,
            address_one_year_ago,
            passports,
            passports_other,
            passports_additional_other,
            national_identity,
            other_national_identity,
            other_national_identities,
            ethnic_group,
            ethnic_group_other,
            religion,
            religion_other,
            childhood_religion,
            childhood_religion_other,
            language,
            other_main_language,
            level_of_spoken_english,
            understand_irish,
            frequency_irish,
            understand_ulster_scots,
            frequency_ulster_scots,
            health,
            health_conditions_or_illnesses_limitations,
            physical_health_conditions,
            other_health_conditions,
            look_after_or_support_others,
            sexual_orientation,
          ],
        },
        {
          id: 'qualifications-group',
          title: 'Qualifications',
          blocks: [
            qualifications,
            degree,
            gcse,
            a_level,
            nvq_level,
            other_qualifications,
            apprenticeship,
          ],
        },
        {
          id: 'employment-group',
          title: 'Employment',
          blocks: [
            employment_status_last_seven_days,
            not_employed_status_last_seven_days,
            looking_for_work,
            available_for_work,
            about_to_start_job,
            ever_worked,
            main_job_introduction,
            main_job_status,
            business_name,
            job_title,
            job_description,
            business_type,
            supervise_others,
            hours_worked,
            workplace_type,
            workplace_location,
            workplace_country,
            workplace_outside_northern_ireland,
            workplace_address,
            travel_to_work,
          ],
        },
        {
          id: 'school-group',
          title: 'School',
          blocks: [
            study_location_type,
            study_location,
            study_location_country,
            study_location_in_northern_ireland,
            travel_to_study_location,
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
