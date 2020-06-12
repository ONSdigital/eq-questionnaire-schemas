local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local englandInstruction = 'Ask the respondent to continue looking at <strong>Showcard 9E</strong> or show them the options below';
local walesInstruction = 'Ask the respondent to continue looking at <strong>Showcard 9W</strong> or show them the options below';

local question(title, instruction) = {
  id: 'black-ethnic-group-question',
  title: title,
  instruction: instruction,
  type: 'General',
  answers: [
    {
      id: 'black-ethnic-group-answer',
      mandatory: false,
      options: [
        {
          label: 'Caribbean',
          value: 'Caribbean',
        },
        {
          label: 'African',
          value: 'African',
          description: 'Select to enter answer',
          detail_answer: {
            id: 'african-ethnic-group-answer-other',
            type: 'TextField',
            mandatory: false,
            label: 'Enter African background',
          },
        },
        {
          label: 'Any other Black, Black British or Caribbean background',
          value: 'Any other Black, Black British or Caribbean background',
          description: 'Select to enter answer',
          detail_answer: {
            id: 'black-ethnic-group-answer-other',
            type: 'TextField',
            mandatory: false,
            label: 'Enter Black, Black British or Caribbean background',
          },
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyEnglandTitle = 'Which one best describes your Black, Black British, Caribbean or African ethnic group or background?';
local proxyEnglandTitle = {
  text: 'Which one best describes <em>{person_name_possessive}</em> Black, Black British, Caribbean or African ethnic group or background?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};
local nonProxyWalesTitle = 'Which one best describes your Black, Black Welsh, Black British, Caribbean or African ethnic group or background?';
local proxyWalesTitle = {
  text: 'Which one best describes <em>{person_name_possessive}</em> Black, Black Welsh, Black British, Caribbean or African ethnic group or background?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};


function(region_code) {
  local instruction = if region_code == 'GB-WLS' then walesInstruction else englandInstruction,
  local nonProxyTitle = if region_code == 'GB-WLS' then nonProxyWalesTitle else nonProxyEnglandTitle,
  local proxyTitle = if region_code == 'GB-WLS' then proxyWalesTitle else proxyEnglandTitle,

  type: 'Question',
  id: 'black-ethnic-group',
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
        block: 'another-uk-address',
        when: [rules.under1],
      },
    },
    {
      goto: {
        block: 'past-usual-household-address',
        when: [rules.under4],
      },
    },
    {
      goto: {
        block: 'in-education',
      },
    },
  ],
}
