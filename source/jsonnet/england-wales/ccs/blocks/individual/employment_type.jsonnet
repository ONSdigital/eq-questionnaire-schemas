local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'employment-type-question',
  title: title,
  instruction: ['Tell the respondent to turn to <strong>Showcard 11</strong> or show them the options below'],
  type: 'General',
  answers: [
    {
      id: 'employment-type-answer',
      mandatory: false,
      options: [
        {
          label: 'Retired',
          value: 'Retired',
          description: 'Whether receiving a pension or not',
        },
        {
          label: 'Studying',
          value: 'Studying',
        },
        {
          label: 'Looking after home or family',
          value: 'Looking after home or family',
        },
        {
          label: 'Long-term sick or disabled',
          value: 'Long-term sick or disabled',
        },
        {
          label: 'Other',
          value: 'Other',
        },
      ],
      type: 'Checkbox',
    },
  ],
};

local nonProxyTitle = {
  text: 'Which of the following describes what you were doing during the week of 15 to {census_date}?',
  placeholders: [
    placeholders.censusDate,
  ],
};

local proxyTitle = {
  text: 'Which of the following describes what <em>{person_name}</em> was doing during the week of 15 to {census_date}?',
  placeholders: [
    placeholders.personName(),
    placeholders.censusDate,
  ],
};

{
  type: 'Question',
  id: 'employment-type',
  question_variants: [
    {
      question: question(nonProxyTitle),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle),
      when: [rules.isProxy],
    },
  ],
}
