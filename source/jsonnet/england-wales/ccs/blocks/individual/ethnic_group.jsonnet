local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyTitle = 'What is your ethnic group?';
local proxyTitle = {
  text: 'What is <em>{person_name_possessive}</em> ethnic group?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local englandInstruction = 'Tell the respondent to turn to <strong>Showcard 9E</strong> or show them the options below';
local walesInstruction = 'Tell the respondent to turn to <strong>Showcard 9W</strong> or show them the options below';

local englandDescription = 'Includes British, Northern Irish, Irish, Gypsy, Irish Traveller, Roma or any other White background';
local walesDescription = 'Includes Welsh, British, Northern Irish, Irish, Gypsy, Irish Traveller, Roma or any other White background';

local englandAsianOption = 'Asian or Asian British';
local walesAsianOption = 'Asian, Asian Welsh or Asian British';

local englandBlackOption = 'Black, Black British, Caribbean or African';
local walesBlackOption = 'Black, Black Welsh, Black British, Caribbean or African';

local question(title, instruction, region_code) = (
  local regionDescription = if region_code == 'GB-WLS' then walesDescription else englandDescription;
  local asianOption = if region_code == 'GB-WLS' then walesAsianOption else englandAsianOption;
  local blackOption = if region_code == 'GB-WLS' then walesBlackOption else englandBlackOption;

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
            description: regionDescription,
          },
          {
            label: 'Mixed or Multiple ethnic groups',
            value: 'Mixed or Multiple ethnic groups',
            description: 'Includes White and Black Caribbean, White and Black African, White and Asian or any other Mixed or Multiple',
          },
          {
            label: asianOption,
            value: asianOption,
            description: 'Includes Indian, Pakistani, Bangladeshi, Chinese or any other Asian background',
          },
          {
            label: blackOption,
            value: blackOption,
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
  local instruction = if region_code == 'GB-WLS' then walesInstruction else englandInstruction,
  local asianOption = if region_code == 'GB-WLS' then walesAsianOption else englandAsianOption,
  local blackOption = if region_code == 'GB-WLS' then walesBlackOption else englandBlackOption,

  type: 'Question',
  id: 'ethnic-group',
  question_variants: [
    {
      question: question(nonProxyTitle, instruction, region_code),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, instruction, region_code),
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
            value: asianOption,
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
            value: blackOption,
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
