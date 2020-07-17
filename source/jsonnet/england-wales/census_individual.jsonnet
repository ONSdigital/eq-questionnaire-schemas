// personal details
local accommodation_type = import 'individual/blocks/personal-details/accommodation_type.jsonnet';
local address_type = import 'individual/blocks/personal-details/address_type.jsonnet';
local another_address = import 'individual/blocks/personal-details/another_address.jsonnet';
local another_address_outside_uk = import 'individual/blocks/personal-details/another_address_outside_uk.jsonnet';
local confirm_age = import 'individual/blocks/personal-details/confirm_age.jsonnet';
local sex_of_current_partner = import 'individual/blocks/personal-details/sex_of_current_partner.jsonnet';
local current_partnership_status = import 'individual/blocks/personal-details/current_partnership_status.jsonnet';
local date_of_birth = import 'individual/blocks/personal-details/date_of_birth.jsonnet';
local establishment_position = import 'individual/blocks/personal-details/establishment_position.jsonnet';
local in_education = import 'individual/blocks/personal-details/in_education.jsonnet';
local marriage_or_civil_partnership_status = import 'individual/blocks/personal-details/marriage_or_civil_partnership_status.jsonnet';
local name = import 'individual/blocks/personal-details/name.jsonnet';
local other_address_uk = import 'individual/blocks/personal-details/other_address_uk.jsonnet';
local sex_of_previous_partner = import 'individual/blocks/personal-details/sex_of_previous_partner.jsonnet';
local previous_partnership_status = import 'individual/blocks/personal-details/previous_partnership_status.jsonnet';
local proxy = import 'individual/blocks/personal-details/confirm_who_is_answering.jsonnet';
local sex = import 'individual/blocks/personal-details/sex.jsonnet';
local term_time_address_country = import 'individual/blocks/personal-details/term_time_address_country.jsonnet';
local term_time_address_country_outside_uk = import 'individual/blocks/personal-details/term_time_address_country_outside_uk.jsonnet';
local term_time_address_uk = import 'individual/blocks/personal-details/term_time_address_uk.jsonnet';
local term_time_location = import 'individual/blocks/personal-details/term_time_location.jsonnet';

// Identity and Health
local arrive_in_country = import 'individual/blocks/identity-and-health/arrive_in_country.jsonnet';
local gender_identity = import 'individual/blocks/identity-and-health/gender_identity.jsonnet';
local look_after_or_support_others = import 'individual/blocks/identity-and-health/look_after_or_support_others.jsonnet';
local country_of_birth = import 'individual/blocks/identity-and-health/country_of_birth.jsonnet';
local country_of_birth_elsewhere = import 'individual/blocks/identity-and-health/country_of_birth_elsewhere.jsonnet';
local health_conditions_or_illnesses = import 'individual/blocks/identity-and-health/health_conditions_or_illnesses.jsonnet';
local health_conditions_or_illnesses_limitations = import 'individual/blocks/identity-and-health/health_conditions_or_illnesses_limitations.jsonnet';
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
local language = import 'individual/blocks/identity-and-health/main_language.jsonnet';
local other_main_language = import 'individual/blocks/identity-and-health/other_main_language.jsonnet';
local address_one_year_ago = import 'individual/blocks/identity-and-health/address_one_year_ago.jsonnet';
local length_of_stay = import 'individual/blocks/identity-and-health/length_of_stay.jsonnet';
local national_identity = import 'individual/blocks/identity-and-health/national_identity.jsonnet';
local other_national_identities = import 'individual/blocks/identity-and-health/other_national_identities.jsonnet';
local other_national_identity = import 'individual/blocks/identity-and-health/other_national_identity.jsonnet';
local passports = import 'individual/blocks/identity-and-health/passports.jsonnet';
local passports_additional_other = import 'individual/blocks/identity-and-health/passports_additional_other.jsonnet';
local passports_other = import 'individual/blocks/identity-and-health/passports_other.jsonnet';
local address_one_year_ago_outside_uk = import 'individual/blocks/identity-and-health/address_one_year_ago_outside_uk.jsonnet';
local location_one_year_ago = import 'individual/blocks/identity-and-health/location_one_year_ago.jsonnet';
local religion = import 'individual/blocks/identity-and-health/religion.jsonnet';
local religion_other = import 'individual/blocks/identity-and-health/religion_other.jsonnet';
local sexual_orientation = import 'individual/blocks/identity-and-health/sexual_orientation.jsonnet';
local speak_english = import 'individual/blocks/identity-and-health/speak_english.jsonnet';
local understand_welsh = import 'individual/blocks/identity-and-health/understand_welsh.jsonnet';
local when_arrive_in_uk = import 'individual/blocks/identity-and-health/when_arrive_in_uk.jsonnet';

// Qualifications
local a_level = import 'individual/blocks/qualifications/a_level.jsonnet';
local apprenticeship = import 'individual/blocks/qualifications/apprenticeship.jsonnet';
local degree = import 'individual/blocks/qualifications/degree_level_or_above.jsonnet';
local gcse = import 'individual/blocks/qualifications/gcse.jsonnet';
local nvq_level = import 'individual/blocks/qualifications/nvq_level.jsonnet';
local other_qualifications = import 'individual/blocks/qualifications/other_qualifications.jsonnet';
local qualifications = import 'individual/blocks/qualifications/qualifications_introduction.jsonnet';

// employment
local armed_forces = import 'individual/blocks/employment/armed_forces.jsonnet';
local business_name = import 'individual/blocks/employment/business_name.jsonnet';
local depot_address = import 'individual/blocks/employment/depot_address.jsonnet';
local workplace_address = import 'individual/blocks/employment/workplace_address.jsonnet';
local workplace_type = import 'individual/blocks/employment/workplace_type.jsonnet';
local business_type = import 'individual/blocks/employment/business_type.jsonnet';
local employment_status_last_seven_days = import 'individual/blocks/employment/employment_status_last_seven_days.jsonnet';
local not_employed_status_last_seven_days = import 'individual/blocks/employment/not_employed_status_last_seven_days.jsonnet';
local ever_worked = import 'individual/blocks/employment/ever_worked.jsonnet';
local hours_worked = import 'individual/blocks/employment/hours_worked.jsonnet';
local available_for_work = import 'individual/blocks/employment/available_for_work.jsonnet';
local job_description = import 'individual/blocks/employment/job_description.jsonnet';
local about_to_start_job = import 'individual/blocks/employment/about_to_start_job.jsonnet';
local job_title = import 'individual/blocks/employment/job_title.jsonnet';
local looking_for_work = import 'individual/blocks/employment/looking_for_work.jsonnet';
local main_job_introduction = import 'individual/blocks/employment/main_job_introduction.jsonnet';
local main_job_status = import 'individual/blocks/employment/main_job_status.jsonnet';
local mainly_work_in_uk = import 'individual/blocks/employment/mainly_work_in_uk.jsonnet';
local mainly_work_outside_uk = import 'individual/blocks/employment/mainly_work_outside_uk.jsonnet';
local supervise_others = import 'individual/blocks/employment/supervise_others.jsonnet';
local travel_to_work = import 'individual/blocks/employment/travel_to_work.jsonnet';

local understandWelshBlock(region_code) = if region_code == 'GB-WLS' then [understand_welsh] else [];

function(region_code, census_month_year_date) {
  mime_type: 'application/json/ons/eq',
  language: 'en',
  schema_version: '0.0.1',
  data_version: '0.0.3',
  survey_id: 'census',
  title: 'Census 2021',
  description: 'Census Individual Schema',
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
            sex,
            marriage_or_civil_partnership_status,
            sex_of_current_partner,
            sex_of_previous_partner,
            current_partnership_status,
            previous_partnership_status,
            another_address,
            another_address_outside_uk,
            other_address_uk,
            address_type,
            in_education,
            term_time_location,
            term_time_address_country,
            term_time_address_country_outside_uk,
            term_time_address_uk,
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
            location_one_year_ago,
            address_one_year_ago_outside_uk,
            address_one_year_ago,
            national_identity(region_code),
            other_national_identity,
            other_national_identities,
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
            other_main_language,
            speak_english,
            passports,
            passports_other,
            passports_additional_other,
            health,
            health_conditions_or_illnesses,
            health_conditions_or_illnesses_limitations,
            look_after_or_support_others,
            sexual_orientation,
            gender_identity,
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
            business_type(region_code),
            supervise_others,
            hours_worked,
            travel_to_work,
            workplace_type,
            mainly_work_in_uk,
            workplace_address,
            depot_address,
            mainly_work_outside_uk,
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
