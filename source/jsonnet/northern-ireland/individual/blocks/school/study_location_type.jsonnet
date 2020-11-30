local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, description) = {
  id: 'study-location-type-question',
  title: title,
  description: [
    description,
  ],
  type: 'General',
  answers: [
    {
      id: 'study-location-type-answer',
      mandatory: true,
      options: [
        {
          label: 'At a campus or school',
          value: 'At a campus or school',
        },
        {
          label: 'At or from home',
          value: 'At or from home',
        },
        {
          label: 'No fixed place',
          value: 'No fixed place',
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitleStudy = 'Where is your main place of <em>study</em>?';
local proxyTitleStudy = {
  text: 'Where is <em>{person_name_possessive}</em> main place of <em>study</em>?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};
local nonProxyDescriptionStudy = 'Answer for the place where you spend the most time. If student or schoolchild, answer for your study address.';
local proxyDescriptionStudy = {
  text: 'Answer for the place where <em>{person_name}</em> spends the most time. If student or schoolchild, answer for their study address.',
  placeholders: [
    placeholders.personName(),
  ],
};

{
  type: 'Question',
  id: 'study-location-type',
  page_title: 'Type of study location',
  question_variants: [
    {
      question: question(nonProxyTitleStudy, nonProxyDescriptionStudy),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitleStudy, proxyDescriptionStudy),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'study-location',
        when: [
          {
            id: 'study-location-type-answer',
            condition: 'equals',
            value: 'At a campus or school',
          },
        ],
      },
    },
    {
      goto: {
        section: 'End',
        when: [
          {
            id: 'study-location-type-answer',
            condition: 'equals',
            value: 'At or from home',
          },
        ],
      },
    },
    {
      goto: {
        block: 'travel-to-study-location',
      },
    },
  ],
}
