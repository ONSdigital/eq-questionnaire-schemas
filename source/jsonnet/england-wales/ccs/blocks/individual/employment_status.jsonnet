local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local title(isProxy) = (
  if isProxy then {
    text: 'During the week of 15 to {census_date}, was <em>{person_name}</em> doing any of the following?',
    placeholders: [
      placeholders.personName(),
      placeholders.censusDate,
    ],
  } else {
    text: 'During the week of 15 to {census_date}, were you doing any of the following?',
    placeholders: [
      placeholders.censusDate,
    ],
  }
);

local questionDescription(isProxy) = (
  if isProxy then 'If they had a job but were off work on <strong>furlough</strong>, in <strong>quarantine</strong> or <strong>self-isolating</strong>, answer “Temporarily away from work ill, on holiday or temporarily laid off”.' else
    'If you had a job but were off work on <strong>furlough</strong>, in <strong>quarantine</strong> or <strong>self-isolating</strong>, answer “Temporarily away from work ill, on holiday or temporarily laid off”.'

);

local answerDescription(isProxy) = (
  if isProxy then 'Freelance means that they are self-employed and work for different companies or people on particular pieces of work' else 'Freelance means that you are self-employed and work for different companies or people on particular pieces of work'
);

local question(isProxy) = {
  id: 'employment-status-question',
  title: title(isProxy),
  description: [
    questionDescription(isProxy),
    'Include casual or temporary work, even if only for one hour.',
  ],
  instruction: ['Tell the respondent to turn to <strong>Showcard 10</strong> or show them the options below'],
  type: 'MutuallyExclusive',
  mandatory: false,
  answers: [
    {
      id: 'employment-status-answer',
      mandatory: false,
      type: 'Checkbox',
      options: [
        {
          label: 'Working as an employee',
          value: 'Working as an employee',
        },
        {
          label: 'Self-employed or freelance',
          value: 'Self-employed or freelance',
          description: answerDescription(isProxy),
        },
        {
          label: 'Temporarily away from work ill, on holiday or temporarily laid off',
          value: 'Temporarily away from work ill, on holiday or temporarily laid off',
        },
        {
          label: 'On maternity or paternity leave',
          value: 'On maternity or paternity leave',
        },
        {
          label: 'Doing any other kind of paid work',
          value: 'Doing any other kind of paid work',
        },
      ],
    },
    {
      id: 'employment-status-answer-exclusive',
      type: 'Checkbox',
      mandatory: false,
      options: [
        {
          label: 'None of these apply',
          value: 'None of these apply',
        },
      ],
    },
  ],
};

{
  type: 'Question',
  id: 'employment-status',
  question_variants: [
    {
      question: question(isProxy=false),
      when: [rules.isNotProxy],
    },
    {
      question: question(isProxy=true),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'employment-type',
        when: [{
          id: 'employment-status-answer-exclusive',
          condition: 'set',
        }],
      },
    },
    {
      goto: {
        block: 'employment-type',
        when: [{
          id: 'employment-status-answer',
          condition: 'not set',
        }],
      },
    },
    {
      goto: {
        block: 'another-uk-address',
      },
    },
  ],
}
