local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, options, questionDescription, answerDescription) = {
  id: 'term-time-location-question',
  type: 'General',
  title: title,
  description: questionDescription,
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
            description: answerDescription,
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
    placeholders.personName(),
  ],
};

local nonProxyQuestionDescription = 'If the <strong>coronavirus</strong> pandemic affected your usual term-time address, answer based on your situation as it is now';
local proxyQuestionDescription = 'If the <strong>coronavirus</strong> pandemic affected their usual term-time address, answer based on their situation as it is now';

local nonProxyAnswerDescription = 'Your answer helps us produce an accurate count of the population during term time. These figures can be used to plan services such as healthcare and transport. This is particularly important in areas with large universities and student populations.';
local proxyAnswerDescription = 'Their answer helps us produce an accurate count of the population during term time. These figures can be used to plan services such as healthcare and transport. This is particularly important in areas with large universities and student populations.';

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
      question: question(nonProxyTitle, otherNonUkAddressOptions, nonProxyQuestionDescription, nonProxyAnswerDescription),
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
      question: question(proxyTitle, otherNonUkAddressOptions, proxyQuestionDescription, proxyAnswerDescription),
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
      question: question(nonProxyTitle, otherUkAddressOptions, nonProxyQuestionDescription, nonProxyAnswerDescription),
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
      question: question(proxyTitle, otherUkAddressOptions, proxyQuestionDescription, proxyAnswerDescription),
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
      question: question(nonProxyTitle, noOtherAddressOptions, nonProxyQuestionDescription, nonProxyAnswerDescription),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, noOtherAddressOptions, proxyQuestionDescription, proxyAnswerDescription),
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
