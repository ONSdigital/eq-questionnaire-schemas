local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyTitle = 'What is your country of birth?';
local proxyTitle = {
  text: 'What is <em>{person_name_possessive}</em> country of birth?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local question(title, region_code, elsewhereDescription) = (

  local englandOptions = {
    options: [
      {
        label: 'England',
        value: 'England',
      },
      {
        label: 'Wales',
        value: 'Wales',
      },
      {
        label: 'Scotland',
        value: 'Scotland',
      },
      {
        label: 'Northern Ireland',
        value: 'Northern Ireland',
      },
      {
        label: 'Republic of Ireland',
        value: 'Republic of Ireland',
      },
      {
        label: 'Elsewhere',
        value: 'Elsewhere',
        description: elsewhereDescription,
      },
    ],
  };

  local walesOptions = {
    options: [
      {
        label: 'Wales',
        value: 'Wales',
      },
      {
        label: 'England',
        value: 'England',
      },
      {
        label: 'Scotland',
        value: 'Scotland',
      },
      {
        label: 'Northern Ireland',
        value: 'Northern Ireland',
      },
      {
        label: 'Republic of Ireland',
        value: 'Republic of Ireland',
      },
      {
        label: 'Elsewhere',
        value: 'Elsewhere',
        description: elsewhereDescription,
      },
    ],
  };

  local radioOptions = if region_code == 'GB-WLS' then walesOptions else englandOptions;
  {
    id: 'country-of-birth-question',
    title: title,
    type: 'General',
    answers: [
      {
        id: 'country-of-birth-answer',
        mandatory: true,
        type: 'Radio',
      } + radioOptions,
    ],
  }
);

function(region_code) {
  type: 'Question',
  id: 'country-of-birth',
  page_title: 'Country of birth',
  question_variants: [
    {
      question: question(nonProxyTitle, region_code, 'You can enter your country of birth on the next question'),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, region_code, 'You can enter their country of birth on the next question'),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'country-of-birth-elsewhere',
        when: [
          {
            id: 'country-of-birth-answer',
            condition: 'equals',
            value: 'Elsewhere',
          },
        ],
      },
    },
    {
      goto: {
        block: 'arrive-in-uk',
        when: [
          {
            id: 'country-of-birth-answer',
            condition: 'equals',
            value: 'Republic of Ireland',
          },
        ],
      },
    },
    {
      goto: {
        block: 'national-identity',
        when: [
          {
            id: 'country-of-birth-answer',
            condition: 'equals any',
            values: ['Wales', 'England', 'Scotland', 'Northern Ireland'],
          },
          rules.under1,
        ],
      },
    },
    {
      goto: {
        block: 'location-one-year-ago',
      },
    },
  ],
}
