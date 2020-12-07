local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local title(isProxy) = (
  if isProxy then {
    text: 'During term time, where did <em>{person_name}</em> usually live?',
    placeholders: [
      placeholders.personName(),
    ],
  } else 'During term time, where did you usually live?'
);

local description(isProxy) = (
  if isProxy then {
    text: 'If the <strong>coronavirus</strong> pandemic affected their usual term-time address, answer based on their situation on Sunday {census_date}?',
    placeholders: [
      placeholders.censusDate,
    ],
  } else {
    text: 'If the <strong>coronavirus</strong> pandemic affected your usual term-time address, answer based on your situation on Sunday {census_date}?',
    placeholders: [
      placeholders.censusDate,
    ],
  }
);

local question(options, isProxy) = {
  id: 'term-time-location-question',
  type: 'General',
  title: title(isProxy),
  description: [description(isProxy)],
  answers: [
    {
      id: 'term-time-location-answer',
      mandatory: false,
      type: 'Radio',
    } + options,
  ],
};

local noOtherAddressOptions = {
  options: [
    {
      label: 'At this household’s address',
      value: 'At this household’s address',
    },
    {
      label: 'At another address',
      value: 'At another address',
    },
  ],
};

{
  type: 'Question',
  id: 'term-time-location',
  question_variants: [
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
        block: 'another-uk-address',
        when: [
          {
            id: 'term-time-location-answer',
            condition: 'equals',
            value: 'At another address',
          },
        ],
      },
    },
    {
      goto: {
        block: 'address-one-year-ago',
      },
    },
  ],
}
