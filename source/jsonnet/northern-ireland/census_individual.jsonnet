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
local term_time_address = import 'individual/blocks/personal-details/term_time_address.jsonnet';
local term_time_country_outside_uk = import 'individual/blocks/personal-details/term_time_country_outside_uk.jsonnet';
local term_time_location = import 'individual/blocks/personal-details/term_time_location.jsonnet';

// Identity and Health
local address_one_year_ago = import 'individual/blocks/identity-and-health/address_one_year_ago.jsonnet';
local address_one_year_ago_outside_uk = import 'individual/blocks/identity-and-health/address_one_year_ago_outside_uk.jsonnet';
local arrive_in_country = import 'individual/blocks/identity-and-health/arrive_in_country.jsonnet';
local country_of_birth = import 'individual/blocks/identity-and-health/country_of_birth.jsonnet';
local country_of_birth_elsewhere = import 'individual/blocks/identity-and-health/country_of_birth_elsewhere.jsonnet';
local disability_other = import 'individual/blocks/identity-and-health/disability_other.jsonnet';
local ethnic_group = import 'individual/blocks/identity-and-health/ethnic_group.jsonnet';
local ethnic_group_other = import 'individual/blocks/identity-and-health/ethnic_group_other.jsonnet';
local frequency_irish = import 'individual/blocks/identity-and-health/frequency_irish.jsonnet';
local frequency_ulster_scots = import 'individual/blocks/identity-and-health/frequency_ulster_scots.jsonnet';
local health = import 'individual/blocks/identity-and-health/health.jsonnet';
local health_conditions_or_illnesses = import 'individual/blocks/identity-and-health/health_conditions_or_illnesses.jsonnet';
local health_conditions_or_illnesses_limitations = import 'individual/blocks/identity-and-health/health_conditions_or_illnesses_limitations.jsonnet';
local location_one_year_ago = import 'individual/blocks/identity-and-health/location_one_year_ago.jsonnet';
local look_after_or_support_others = import 'individual/blocks/identity-and-health/look_after_or_support_others.jsonnet';
local language = import 'individual/blocks/identity-and-health/main_language.jsonnet';
local national_identity = import 'individual/blocks/identity-and-health/national_identity.jsonnet';
local no_religion = import 'individual/blocks/identity-and-health/no_religion.jsonnet';
local no_religion_other = import 'individual/blocks/identity-and-health/no_religion_other.jsonnet';
local other_main_language = import 'individual/blocks/identity-and-health/other_main_language.jsonnet';
local other_national_identities = import 'individual/blocks/identity-and-health/other_national_identities.jsonnet';
local other_national_identity = import 'individual/blocks/identity-and-health/other_national_identity.jsonnet';
local passports = import 'individual/blocks/identity-and-health/passports.jsonnet';
local passports_additional_other = import 'individual/blocks/identity-and-health/passports_additional_other.jsonnet';
local passports_other = import 'individual/blocks/identity-and-health/passports_other.jsonnet';
local religion = import 'individual/blocks/identity-and-health/religion.jsonnet';
local religion_other = import 'individual/blocks/identity-and-health/religion_other.jsonnet';
local sexual_orientation = import 'individual/blocks/identity-and-health/sexual_orientation.jsonnet';
local speak_english = import 'individual/blocks/identity-and-health/speak_english.jsonnet';
local understand_irish = import 'individual/blocks/identity-and-health/understand_irish.jsonnet';
local understand_ulster_scots = import 'individual/blocks/identity-and-health/understand_ulster_scots.jsonnet';

// School
local place_of_study = import 'individual/blocks/school/place_of_study.jsonnet';
local place_of_study_elsewhere = import 'individual/blocks/school/place_of_study_elsewhere.jsonnet';
local school_location = import 'individual/blocks/school/school_location.jsonnet';
local school_travel = import 'individual/blocks/school/school_travel.jsonnet';
local study_location_type = import 'individual/blocks/school/study_location_type.jsonnet';

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
local place_of_work = import 'individual/blocks/employment/place_of_work.jsonnet';
local place_of_work_elsewhere = import 'individual/blocks/employment/place_of_work_elsewhere.jsonnet';
local supervise_others = import 'individual/blocks/employment/supervise_others.jsonnet';
local town_and_county = import 'individual/blocks/employment/town_and_county.jsonnet';
local travel_to_work = import 'individual/blocks/employment/travel_to_work.jsonnet';
local work_location = import 'individual/blocks/employment/work_location.jsonnet';
local work_location_type = import 'individual/blocks/employment/work_location_type.jsonnet';

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
  sections: [
    {
      id: 'individual-section',
      title: 'Individual Section',
      groups: [
        {
          id: 'personal-details-group',
          title: 'Personal Details',
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
            term_time_address,
            term_time_country_outside_uk,
          ],
        },
        {
          id: 'identity-and-health-group',
          title: 'Identity and Health',
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
            no_religion,
            no_religion_other,
            language,
            other_main_language,
            speak_english,
            understand_irish,
            frequency_irish,
            understand_ulster_scots,
            frequency_ulster_scots,
            health,
            health_conditions_or_illnesses_limitations,
            health_conditions_or_illnesses,
            disability_other,
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
            work_location_type,
            place_of_work,
            place_of_work_elsewhere,
            town_and_county,
            work_location,
            travel_to_work,
          ],
        },
        {
          id: 'school-group',
          title: 'School',
          blocks: [
            study_location_type,
            place_of_study,
            place_of_study_elsewhere,
            school_location,
            school_travel,
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
