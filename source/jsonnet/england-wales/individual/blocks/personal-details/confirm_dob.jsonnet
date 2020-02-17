local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, yesLabel, noLabel, noValue, yesValue) = {
  id: 'confirm-date-of-birth',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'confirm-date-of-birth-answer',
      mandatory: true,
      options: [
        {
          label: yesLabel,
          value: yesValue,
        },
        {
          label: noLabel,
          value: noValue,
        },
      ],
      type: 'Radio',
    },
  ],
};

local dateOfBirthPlaceholder = {
  placeholder: 'age',
  transforms: [
    {
      transform: 'calculate_date_difference',
      arguments: {
        first_date: {
          source: 'answers',
          identifier: 'date-of-birth-answer',
        },
        second_date: {
          value: 'now',
        },
      },
    },
  ],
};

local nonProxyTitle = {
  text: 'You are {age} old. Is this correct?',
  placeholders: [
    dateOfBirthPlaceholder,
  ],
};
local nonProxyYesLabel = {
  text: 'Yes, I am {age} old',
  placeholders: [
    dateOfBirthPlaceholder,
  ],
};
local nonProxyYesValue = 'Yes, I am {age} old';

local nonProxyNoLabel = 'No, I need to correct my date of birth';
local nonProxyNoValue = 'No, I need to correct my date of birth';

local proxyTitle = {
  text: '{person_name} is {age} old. Is this correct?',
  placeholders: [
    placeholders.personName,
    dateOfBirthPlaceholder,
  ],
};
local proxyYesLabel = {
  text: 'Yes, {person_name} is {age} old',
  placeholders: [
    placeholders.personName,
    dateOfBirthPlaceholder,
  ],
};

local proxyYesValue = 'Yes, {person_name} is {age} old';

local proxyNoLabel = 'No, I need to correct their date of birth';
local proxyNoValue = 'No, I need to correct their date of birth';

{
  type: 'ConfirmationQuestion',
  id: 'confirm-dob',
  question_variants: [
    {
      question: question(nonProxyTitle, nonProxyYesLabel, nonProxyNoLabel, nonProxyNoValue, nonProxyYesValue),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, proxyYesLabel, proxyNoLabel, proxyNoValue, proxyYesValue),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'date-of-birth',
        when: [
          {
            id: 'confirm-date-of-birth-answer',
            condition: 'equals any',
            values: [proxyNoValue, nonProxyNoValue],
          },
        ],
      },
    },
    {
      goto: {
        block: 'sex',
      },
    },
  ],
}
