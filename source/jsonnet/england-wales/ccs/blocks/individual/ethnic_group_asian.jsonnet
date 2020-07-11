local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local englandStrings = {
  instruction: 'Ask the respondent to continue looking at <strong>Showcard 9E</strong> or show them the options below',
  nonProxyTitle: 'Which one best describes your Asian or Asian British ethnic group or background?',
  proxyTitle: {
    text: 'Which one best describes <em>{person_name_possessive}</em> Asian or Asian British ethnic group or background?',
    placeholders: [
      placeholders.personNamePossessive,
    ],
  },
};

local walesStrings = {
  instruction: 'Ask the respondent to continue looking at <strong>Showcard 9W</strong> or show them the options below',
  nonProxyTitle: 'Which one best describes your Asian, Asian Welsh or Asian British ethnic group or background?',
  proxyTitle: {
    text: 'Which one best describes <em>{person_name_possessive}</em> Asian, Asian Welsh or Asian British ethnic group or background?',
    placeholders: [
      placeholders.personNamePossessive,
    ],
  },
};

local question(title, instruction) = {
  id: 'asian-ethnic-group-question',
  title: title,
  instruction: instruction,
  type: 'General',
  answers: [
    {
      id: 'asian-ethnic-group-answer',
      mandatory: false,
      options: [
        {
          label: 'Indian',
          value: 'Indian',
        },
        {
          label: 'Pakistani',
          value: 'Pakistani',
        },
        {
          label: 'Bangladeshi',
          value: 'Bangladeshi',
        },
        {
          label: 'Chinese',
          value: 'Chinese',
        },
        {
          label: 'Any other Asian background',
          value: 'Any other Asian background',
          description: 'Select to enter answer',
          detail_answer: {
            id: 'asian-ethnic-group-answer-other',
            type: 'TextField',
            mandatory: false,
            label: 'Enter Asian ethnic group or background',
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
  id: 'asian-ethnic-group',
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
