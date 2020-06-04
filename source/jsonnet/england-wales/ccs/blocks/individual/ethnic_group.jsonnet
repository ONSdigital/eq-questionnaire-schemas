local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyTitle = 'What is your ethnic group?';
local proxyTitle = {
  text: 'What is <em>{person_name_possessive}</em> ethnic group?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local englandInstruction = 'Tell the respondent to turn to <strong>Showcard 9E</strong> or show them the answer options below';
local walesInstruction = 'Tell the respondent to turn to <strong>Showcard 9W</strong> or show them the answer options below';


local question(title, instruction) = (
  {
    id: 'ethnic-group-question',
    title: title,
    instruction: instruction,
    type: 'General',
    answers: [
      {
        id: 'ethnic-group-answer',
        mandatory: false,
        options: [
          {
            label: 'White',
            value: 'White',
          },
          {
            label: 'Mixed or Multiple ethnic groups',
            value: 'Mixed or Multiple ethnic groups',
          },
          {
            label: 'Asian or Asian British',
            value: 'Asian or Asian British',
          },
          {
            label: 'Black, Black British, Caribbean or African',
            value: 'Black, Black British, Caribbean or African',
          },
          {
            label: 'Other ethnic group',
            value: 'Other ethnic group',
          },
        ],
        type: 'Radio',
      },
    ],
  }
);

function(region_code) {
  local instruction = if region_code == 'GB-WLS' then walesInstruction else englandInstruction,

  type: 'Question',
  id: 'ethnic-group',
  question_variants: [
    {
      question: question(nonProxyTitle, instruction),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, instruction),
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
            value: 'Asian or Asian British',
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
            value: 'Black, Black British, Caribbean or African',
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
