local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local title(isProxy) = (
  if isProxy then
    {
      text: 'During term time, where does <em>{person_name}</em> usually live?',
      placeholders: [
        placeholders.personName(),
      ],
    }
  else 'During term time, where do you usually live?'
);

local answerDescription(isProxy) = (
  if isProxy then
    'Their answer helps us produce an accurate count of the population during term time. These figures can be used to plan services such as healthcare and transport. This is particularly important in areas with large universities and student populations.'
  else 'Your answer helps us produce an accurate count of the population during term time. These figures can be used to plan services such as healthcare and transport. This is particularly important in areas with large universities and student populations.'
);

local question(options, isProxy) = {
  id: 'term-time-location-question',
  type: 'General',
  title: title(isProxy),
  answers: [
    {
      id: 'term-time-location-answer',
      mandatory: true,
      type: 'Radio',
      guidance: {
        show_guidance: 'Why we ask for term-time address',
        hide_guidance: 'Why we ask for term-time address',
        contents: [
          {
            description: answerDescription(isProxy),
          },
        ],
      },
    } + options,
  ],
};

local noOtherAddressOptions = {
  options: [
    {
      label: {
        text: '{household_address}',
        placeholders: [
          placeholders.address,
        ],
      },
      value: '{household_address}',
    },
    {
      label: 'Another address',
      value: 'Another address',
    },
  ],
};

local otherUkAddressOptions = {
  options: [
    {
      label: {
        text: '{household_address}',
        placeholders: [
          placeholders.address,
        ],
      },
      value: '{household_address}',
    },
    {
      label: {
        text: '{thirty_day_address}',
        placeholders: [
          {
            placeholder: 'thirty_day_address',
            value: {
              identifier: 'other-address-uk-answer',
              source: 'answers',
              selector: 'line1',
            },
          },
        ],
      },
      value: '{thirty_day_address}',
    },
    {
      label: 'Another address',
      value: 'Another address',
    },
  ],
};

local otherNonUkAddressOptions = {
  options: [
    {
      label: {
        text: '{household_address}',
        placeholders: [
          placeholders.address,
        ],
      },
      value: '{household_address}',
    },
    {
      label: {
        text: 'The address in {thirty_day_address_country}',
        placeholders: [
          {
            placeholder: 'thirty_day_address_country',
            value: {
              source: 'answers',
              identifier: 'another-address-outside-uk-answer',
            },
          },
        ],
      },
      value: 'The address in {thirty_day_address_country}',
    },
    {
      label: 'Another address',
      value: 'Another address',
    },
  ],
};

{
  type: 'Question',
  id: 'term-time-location',
  page_title: 'Term-time location',
  question_variants: [
    {
      question: question(otherNonUkAddressOptions, isProxy=false),
      when: [
        rules.isNotProxy,
        {
          id: 'another-address-answer',
          condition: 'equals',
          value: 'Yes, an address outside the UK',
        },
      ],
    },
    {
      question: question(otherNonUkAddressOptions, isProxy=true),
      when: [
        rules.isProxy,
        {
          id: 'another-address-answer',
          condition: 'equals',
          value: 'Yes, an address outside the UK',
        },
      ],
    },
    {
      question: question(otherUkAddressOptions, isProxy=false),
      when: [
        rules.isNotProxy,
        {
          id: 'another-address-answer',
          condition: 'equals',
          value: 'Yes, an address within the UK',
        },
      ],
    },
    {
      question: question(otherUkAddressOptions, isProxy=true),
      when: [
        rules.isProxy,
        {
          id: 'another-address-answer',
          condition: 'equals',
          value: 'Yes, an address within the UK',
        },
      ],
    },
    {
      question: question(noOtherAddressOptions, isProxy=false),
      when: [rules.isNotProxy],
    },
    {
      question: question(noOtherAddressOptions, isProxy=true),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        group: 'identity-and-health-group',
        when: [
          {
            id: 'term-time-location-answer',
            condition: 'equals',
            value: '{household_address}',
          },
        ],
      },
    },
    {
      goto: {
        section: 'End',
        when: [
          {
            id: 'term-time-location-answer',
            condition: 'equals any',
            values: [
              '{thirty_day_address}',
              'The address in {thirty_day_address_country}',
            ],
          },
        ],
      },
    },
    {
      goto: {
        block: 'term-time-address-country',
        when: [
          {
            id: 'another-address-answer',
            condition: 'equals',
            value: 'No',
          },
          {
            id: 'term-time-location-answer',
            condition: 'equals',
            value: 'Another address',
          },
        ],
      },
    },
    {
      goto: {
        block: 'term-time-address-country',
        when: [
          {
            id: 'another-address-answer',
            condition: 'not set',
          },
          {
            id: 'term-time-location-answer',
            condition: 'equals',
            value: 'Another address',
          },
        ],
      },
    },
    {
      goto: {
        section: 'End',
        when: [
          {
            id: 'term-time-location-answer',
            condition: 'equals',
            value: 'Another address',
          },
          {
            id: 'another-address-answer',
            condition: 'equals',
            value: 'Yes, an address within the UK',
          },
        ],
      },
    },
    {
      goto: {
        section: 'End',
        when: [
          {
            id: 'term-time-location-answer',
            condition: 'equals',
            value: 'Another address',
          },
          {
            id: 'another-address-answer',
            condition: 'equals',
            value: 'Yes, an address outside the UK',
          },
        ],
      },
    },
    {
      goto: {
        group: 'identity-and-health-group',
      },
    },
  ],
}
