local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, options, description) = {
  id: 'term-time-location-question',
  type: 'General',
  title: title,
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
            description: description,
          },
        ],
      },
    } + options,
  ],
};

local nonProxyTitle = 'During term time, where do you usually live?';
local proxyTitle = {
  text: 'During term time, where does <em>{person_name}</em> usually live?',
  placeholders: [
    placeholders.personName,
  ],
};

local nonProxyDescription = 'Your answer helps us produce an accurate count of the population during term time. These figures can be used to plan services such as healthcare and transport. This is particularly important in areas with large universities and student populations.';
local proxyDescription = 'Their answer helps us produce an accurate count of the population during term time. These figures can be used to plan services such as healthcare and transport. This is particularly important in areas with large universities and student populations.';

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
            transforms: [{
              transform: 'concatenate_list',
              arguments: {
                list_to_concatenate: {
                  source: 'answers',
                  identifier: ['other-address-answer-building', 'other-address-answer-street'],
                },
                delimiter: ', ',
              },
            }],
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
  question_variants: [
    {
      question: question(nonProxyTitle, otherNonUkAddressOptions, nonProxyDescription),
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
      question: question(proxyTitle, otherNonUkAddressOptions, proxyDescription),
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
      question: question(nonProxyTitle, otherUkAddressOptions, nonProxyDescription),
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
      question: question(proxyTitle, otherUkAddressOptions, proxyDescription),
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
      question: question(nonProxyTitle, noOtherAddressOptions, nonProxyDescription),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, noOtherAddressOptions, proxyDescription),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        section: 'End',
        when: [
          {
            id: 'term-time-location-answer',
            condition: 'equals any',
            values: [
              '{household_address}',
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
