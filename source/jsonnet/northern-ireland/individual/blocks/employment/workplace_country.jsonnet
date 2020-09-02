local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local listName = 'countries-of-birth.json';

local suggestionsUrl = {
  text: '{suggestions_url}',
  placeholders: [placeholders.suggestionsUrl(listName)],
};

local question(title) = {
  id: 'workplace-country-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'workplace-country-answer',
      label: 'Current name of country',
      description: 'Enter your own answer or select from suggestions',
      suggestions_url: suggestionsUrl,
      mandatory: false,
      type: 'TextField',
    },
  ],
};

local nonProxyTitle = 'In which country is your main place of <em>work</em>?';
local proxyTitle = {
  text: 'In which country is <em>{person_name_possessive}</em> main place of <em>work</em>?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local pastNonProxyTitle = 'In which country was your main place of <em>work</em>?';
local pastProxyTitle = {
  text: 'In which country was <em>{person_name_possessive}</em> main place of <em>work</em>?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

{
  type: 'Question',
  id: 'workplace-country',
  question_variants: [
    {
      question: question(nonProxyTitle),
      when: [rules.isNotProxy, rules.mainJob],
    },
    {
      question: question(proxyTitle),
      when: [rules.isProxy, rules.mainJob],
    },
    {
      question: question(pastNonProxyTitle),
      when: [rules.isNotProxy],
    },
    {
      question: question(pastProxyTitle),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'workplace-outside-northern-ireland',
        when: [
          {
            id: 'workplace-country-answer',
            condition: 'equals any',
            values: [
              'Carlow',
              'Cavan',
              'Clare',
              'Connaught',
              'Cork',
              'Donegal',
              'Dublin',
              'Eire',
              'Galway',
              'Ireland',
              'Ireland (Republic)',
              'Ireland (Southern)',
              'Irish Free State',
              'Irish Republic',
              'Kerry',
              'Kildare',
              'Kilkenny',
              'Laois',
              'Leinster',
              'Leitrim',
              'Limerick',
              'Longford',
              'Louth',
              'Mayo',
              'Meath',
              'Monaghan',
              'Munster',
              'Offaly',
              'Republic of Ireland',
              'RoI',
              'Roscommon',
              'Sligo',
              'Southern Ireland',
              'Tipperary',
              'Waterford',
              'Westmeath',
              'Wexford',
              'Wicklow',
              'South of Ireland',
            ],
          },
        ],
      },
    },
    {
      goto: {
        block: 'travel-to-work',
      },
    },
  ],
}
