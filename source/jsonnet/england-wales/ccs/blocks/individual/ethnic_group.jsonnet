local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyTitle = 'What is your ethnic group?';
local proxyTitle = {
  text: 'What is <em>{person_name_possessive}</em> ethnic group?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local englandStrings = {
  instruction: 'Tell the respondent to turn to <strong>Showcard 9E</strong> or show them the options below',
  description: 'Includes British, Northern Irish, Irish, Gypsy, Irish Traveller, Roma or any other White background',
  asianOption: 'Asian or Asian British',
  blackOption: 'Black, Black British, Caribbean or African',
};

local walesStrings = {
  instruction: 'Tell the respondent to turn to <strong>Showcard 9W</strong> or show them the options below',
  description: 'Includes Welsh, British, Northern Irish, Irish, Gypsy, Irish Traveller, Roma or any other White background',
  asianOption: 'Asian, Asian Welsh or Asian British',
  blackOption: 'Black, Black Welsh, Black British, Caribbean or African',
};

local question(title, regionStrings, region_code) = (
  {
    id: 'ethnic-group-question',
    title: title,
    instruction: [regionStrings.instruction],
    type: 'General',
    answers: [
      {
        id: 'ethnic-group-answer',
        mandatory: false,
        options: [
          {
            label: 'White',
            value: 'White',
            description: regionStrings.description,
          },
          {
            label: 'Mixed or Multiple ethnic groups',
            value: 'Mixed or Multiple ethnic groups',
            description: 'Includes White and Black Caribbean, White and Black African, White and Asian or any other Mixed or Multiple background',
          },
          {
            label: regionStrings.asianOption,
            value: regionStrings.asianOption,
            description: 'Includes Indian, Pakistani, Bangladeshi, Chinese or any other Asian background',
          },
          {
            label: regionStrings.blackOption,
            value: regionStrings.blackOption,
            description: 'Includes Black British, Caribbean, African or any other Black background',
          },
          {
            label: 'Other ethnic group',
            value: 'Other ethnic group',
            description: 'Includes Arab or any other ethnic group',
          },
        ],
        type: 'Radio',
      },
    ],
  }
);

function(region_code) {
  local regionStrings = if region_code == 'GB-WLS' then walesStrings else englandStrings,

  type: 'Question',
  id: 'ethnic-group',
  question_variants: [
    {
      question: question(nonProxyTitle, regionStrings, region_code),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, regionStrings, region_code),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'white-ethnic-group',
        when: [
          {
            id: 'ethnic-group-answer',
            condition: 'equals',
            value: 'White',
          },
        ],
      },
    },
    {
      goto: {
        block: 'mixed-ethnic-group',
        when: [
          {
            id: 'ethnic-group-answer',
            condition: 'equals',
            value: 'Mixed or Multiple ethnic groups',
          },
        ],
      },
    },
    {
      goto: {
        block: 'asian-ethnic-group',
        when: [
          {
            id: 'ethnic-group-answer',
            condition: 'equals',
            value: regionStrings.asianOption,
          },
        ],
      },
    },
    {
      goto: {
        block: 'black-ethnic-group',
        when: [
          {
            id: 'ethnic-group-answer',
            condition: 'equals',
            value: regionStrings.blackOption,
          },
        ],
      },
    },
    {
      goto: {
        block: 'other-ethnic-group',
        when: [
          {
            id: 'ethnic-group-answer',
            condition: 'equals',
            value: 'Other ethnic group',
          },
        ],
      },
    },
    {
      goto: {
        block: 'another-uk-address',
        when: [
          {
            id: 'ethnic-group-answer',
            condition: 'not set',
          },
          rules.under1,
        ],
      },
    },
    {
      goto: {
        block: 'past-usual-household-address',
        when: [
          {
            id: 'ethnic-group-answer',
            condition: 'not set',
          },
          rules.under4,
        ],
      },
    },
    {
      goto: {
        block: 'in-education',
      },
    },
  ],
}
