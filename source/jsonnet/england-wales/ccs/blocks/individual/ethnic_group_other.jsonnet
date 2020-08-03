local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local englandInstruction = 'Ask the respondent to continue looking at <strong>Showcard 9E</strong> or show them the options below';
local walesInstruction = 'Ask the respondent to continue looking at <strong>Showcard 9W</strong> or show them the options below';

local question(title, instruction) = {
  id: 'other-ethnic-group-question',
  title: title,
  instruction: [instruction],
  type: 'General',
  answers: [
    {
      id: 'other-ethnic-group-answer',
      mandatory: false,
      options: [
        {
          label: 'Arab',
          value: 'Arab',
        },
        {
          label: 'Any other ethnic group',
          value: 'Any other ethnic group',
          description: 'Select to enter answer',
          detail_answer: {
            id: 'other-ethnic-group-answer-other',
            type: 'TextField',
            mandatory: false,
            label: 'Enter other ethnic group or background',
          },
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitle = 'Which one best describes your other ethnic group or background?';
local proxyTitle = {
  text: 'Which one best describes <em>{person_name_possessive}</em> other ethnic group or background?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

function(region_code) {
  local instruction = if region_code == 'GB-WLS' then walesInstruction else englandInstruction,

  type: 'Question',
  id: 'other-ethnic-group',
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
