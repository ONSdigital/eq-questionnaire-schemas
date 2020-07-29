local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local anotherCountryAnswerOption = 'No, it is in another country';
local pastAnotherCountryAnswerOption = 'No, it was in another country';

local question(title, anotherCountry) = {
  id: 'workplace-location-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'workplace-location-answer',
      mandatory: false,
      options: [
        {
          label: 'Yes',
          value: 'Yes',
        },
        {
          label: anotherCountry,
          value: anotherCountry,
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitle = 'Is your main place of <em>work</em> in <em>the UK</em>?';
local proxyTitle = {
  text: 'Is <em>{person_name_possessive}</em> main place of <em>work</em> in <em>the UK</em>?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local pastNonProxyTitle = 'Was your main place of <em>work</em> in <em>the UK</em>?';
local pastProxyTitle = {
  text: 'Was <em>{person_name_possessive}</em> main place of <em>work</em> in <em>the UK</em>?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

{
  type: 'Question',
  id: 'workplace-location',
  question_variants: [
    {
      question: question(nonProxyTitle, anotherCountryAnswerOption),
      when: [rules.isNotProxy, rules.mainJob],
    },
    {
      question: question(proxyTitle, anotherCountryAnswerOption),
      when: [rules.isProxy, rules.mainJob],
    },
    {
      question: question(pastNonProxyTitle, pastAnotherCountryAnswerOption),
      when: [rules.isNotProxy],
    },
    {
      question: question(pastProxyTitle, pastAnotherCountryAnswerOption),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'place-of-work-elsewhere',
        when: [
          {
            id: 'workplace-location-answer',
            condition: 'equals any',
            values: ['No, it is in another country', 'No, it was in another country'],
          },
        ],
      },
    },
    {
      goto: {
        block: 'workplace-address',
      },
    },
  ],
}
