local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local irelandAnswerOption = 'No, it is in the Republic of Ireland';
local pastIrelandAnswerOption = 'No, it was in the Republic of Ireland';

local anotherCountryAnswerOption = 'No, it is in another country';
local pastAnotherCountryAnswerOption = 'No, it was in another country';

local question(title, anotherCountry, republicOfIreland) = {
  id: 'place-of-work-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'place-of-work-answer',
      mandatory: false,
      options: [
        {
          label: 'Yes',
          value: 'Yes',
        },
        {
          label: republicOfIreland,
          value: republicOfIreland,
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

local nonProxyTitle = 'Is your main place of work in Northern Ireland?';
local proxyTitle = {
  text: 'Is <em>{person_name_possessive}</em> main place of work in Northern Ireland?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local pastNonProxyTitle = 'Was your main place of work in Northern Ireland?';
local pastProxyTitle = {
  text: 'Was <em>{person_name_possessive}</em> main place of work in Northern Ireland?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

{
  type: 'Question',
  id: 'place-of-work',
  question_variants: [
    {
      question: question(nonProxyTitle, anotherCountryAnswerOption, irelandAnswerOption),
      when: [rules.isNotProxy, rules.mainJob],
    },
    {
      question: question(proxyTitle, anotherCountryAnswerOption, irelandAnswerOption),
      when: [rules.isProxy, rules.mainJob],
    },
    {
      question: question(pastNonProxyTitle, pastAnotherCountryAnswerOption, pastIrelandAnswerOption),
      when: [rules.isNotProxy],
    },
    {
      question: question(pastProxyTitle, pastAnotherCountryAnswerOption, pastIrelandAnswerOption),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'place-of-work-elsewhere',
        when: [
          {
            id: 'place-of-work-answer',
            condition: 'equals any',
            values: ['No, it is in another country', 'No, it was in another country'],
          },
        ],
      },
    },
    {
      goto: {
        block: 'work-location',
      },
    },
  ],
}