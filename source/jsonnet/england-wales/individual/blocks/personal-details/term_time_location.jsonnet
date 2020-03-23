local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, options) = {
  id: 'term-time-location-question',
  type: 'General',
  title: title,
  answers: [
    {
      id: 'term-time-location-answer',
      mandatory: true,
      type: 'Radio',
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
      question: question(nonProxyTitle, otherNonUkAddressOptions),
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
      question: question(proxyTitle, otherNonUkAddressOptions),
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
      question: question(nonProxyTitle, otherUkAddressOptions),
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
      question: question(proxyTitle, otherUkAddressOptions),
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
      question: question(nonProxyTitle, noOtherAddressOptions),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, noOtherAddressOptions),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
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
        ],
      },
    },
    {
      goto: {
        group: 'submit-group',
        when: [
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
        group: 'submit-group',
        when: [
          {
            id: 'term-time-location-answer',
            condition: 'equals',
            value: '{thirty_day_address}',
          },
        ],
      },
    },
    {
      goto: {
        group: 'submit-group',
        when: [
          {
            id: 'term-time-location-answer',
            condition: 'equals',
            value: 'The address in {thirty_day_address_country}',
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
