local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'establishment-position-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'establishment-position-answer',
      mandatory: false,
      options: [
        {
          label: 'Resident',
          value: 'Resident',
          description: 'For example, student, member of armed forces, patient, detainee',
        },
        {
          label: 'Staff or owner',
          value: 'Staff or owner',
        },
        {
          label: 'Family member or partner of staff or owner',
          value: 'Family member or partner of staff or owner',
        },
        {
          label: 'Staying temporarily',
          value: 'Staying temporarily',
          description: 'No usual UK address',
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitle = 'What is your position in this establishment?';
local proxyTitle = {
  text: 'What is <em>{person_name_possessive}</em> position in this establishment?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

{
  type: 'Question',
  id: 'establishment-position',
  page_title: 'Position in establishment',
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
