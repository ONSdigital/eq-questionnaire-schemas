local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local englandInstruction = 'Ask the respondent to continue looking at <strong>Showcard 9E</strong> or show them the options below';
local walesInstruction = 'Ask the respondent to continue looking at <strong>Showcard 9W</strong> or show them the options below';

local question(title, instruction) = {
  id: 'mixed-or-multiple-ethnic-group-question',
  title: title,
  instruction: [instruction],
  type: 'General',
  answers: [
    {
      id: 'mixed-or-multiple-ethnic-group-answer',
      mandatory: false,
      options: [
        {
          label: 'White and Black Caribbean',
          value: 'White and Black Caribbean',
        },
        {
          label: 'White and Black African',
          value: 'White and Black African',
        },
        {
          label: 'White and Asian',
          value: 'White and Asian',
        },
        {
          label: 'Any other Mixed or Multiple background',
          value: 'Any other Mixed or Multiple background',
          description: 'Select to enter answer',
          detail_answer: {
            id: 'mixed-or-multiple-ethnic-group-answer-other',
            type: 'TextField',
            mandatory: false,
            label: 'Enter Mixed or Multiple ethnic group or background',
          },
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitle = 'Which one best describes your Mixed or Multiple ethnic group or background?';
local proxyTitle = {
  text: 'Which one best describes <em>{person_name_possessive}</em> Mixed or Multiple ethnic group or background?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

function(region_code) {
  local instruction = if region_code == 'GB-WLS' then walesInstruction else englandInstruction,

  type: 'Question',
  id: 'mixed-or-multiple-ethnic-group',
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
        block: 'address-one-year-ago',
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
