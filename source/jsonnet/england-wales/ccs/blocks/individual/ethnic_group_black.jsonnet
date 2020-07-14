local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local englandStrings = {
  instruction: 'Ask the respondent to continue looking at <strong>Showcard 9E</strong> or show them the options below',
  nonProxyTitle: 'Which one best describes your Black, Black British, Caribbean or African ethnic group or background?',
  proxyTitle: {
    text: 'Which one best describes <em>{person_name_possessive}</em> Black, Black British, Caribbean or African ethnic group or background?',
    placeholders: [
      placeholders.personNamePossessive,
    ],
  },
};

local walesStrings = {
  instruction: 'Ask the respondent to continue looking at <strong>Showcard 9W</strong> or show them the options below',
  nonProxyTitle: 'Which one best describes your Black, Black Welsh, Black British, Caribbean or African ethnic group or background?',
  proxyTitle: {
    text: 'Which one best describes <em>{person_name_possessive}</em> Black, Black Welsh, Black British, Caribbean or African ethnic group or background?',
    placeholders: [
      placeholders.personNamePossessive,
    ],
  },
};

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
            label: 'Enter Black, Black British or Caribbean ethnic group or background',
          },
        },
      ],
      type: 'Radio',
    },
  ],
};

function(region_code) {
  local regionStrings = if region_code == 'GB-WLS' then walesStrings else englandStrings,

  type: 'Question',
  id: 'black-ethnic-group',
  question_variants: [
    {
      question: question(regionStrings.nonProxyTitle, regionStrings.instruction),
      when: [rules.isNotProxy],
    },
    {
      question: question(regionStrings.proxyTitle, regionStrings.instruction),
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
