local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, questionDescription, answerDescription) = {
  id: 'employment-status-question',
  title: title,
  description: [
    questionDescription,
    'Include casual or temporary work, even if only for one hour',
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
          description: answerDescription,
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

local nonProxyTitle = {
  text: 'During the week of 15 to {census_date}, were you doing any of the following?',
  placeholders: [
    placeholders.censusDate,
  ],
};

local proxyTitle = {
  text: 'During the week of 15 to {census_date}, was <em>{person_name}</em> doing any of the following?',
  placeholders: [
    placeholders.personName(),
    placeholders.censusDate,
  ],
};

local nonProxyQuestionDescription = 'If you have a job but have been off work in <strong>quarantine</strong> or <strong>self-isolating</strong>, answer "Temporarily away from work ill, on holiday or temporarily laid off".';

local proxyQuestionDescription = 'If they have a job but have been off work in <strong>quarantine</strong> or <strong>self-isolating</strong>, answer "Temporarily away from work ill, on holiday or temporarily laid off".';

local nonProxyAnswerDescription = 'Freelance means that you are self-employed and work for different companies or people on particular pieces of work';

local proxyAnswerDescription = 'Freelance means that they are self-employed and work for different companies or people on particular pieces of work';

{
  type: 'Question',
  id: 'employment-status',
  question_variants: [
    {
      question: question(nonProxyTitle, nonProxyQuestionDescription, nonProxyAnswerDescription),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, proxyQuestionDescription, proxyAnswerDescription),
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
