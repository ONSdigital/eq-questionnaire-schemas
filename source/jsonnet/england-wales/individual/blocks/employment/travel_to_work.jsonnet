local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local questionTitle(isProxy) = (
  if isProxy then {
    text: 'How does <em>{person_name}</em> usually travel to work?',
    placeholders: [
      placeholders.personName(),
    ],
  }
  else 'How do you usually travel to work?'
);

local questionDescription(isProxy) = (
  if isProxy then [
    'Answer for the longest part, <em>by distance</em>, of their current journey to work',
    'If the <strong>coronavirus</strong> pandemic has affected how they travel to work, select the answer that best describes their <strong>current circumstances</strong>.',
  ] else [
    'Answer for the longest part, <em>by distance</em>, of your current journey to work',
    'If the <strong>coronavirus</strong> pandemic has affected how you travel to work, select the answer that best describes your <strong>current circumstances</strong>.',
  ]
);

local question(isProxy) = {
  title: questionTitle(isProxy),
  id: 'travel-to-work-question',
  description: questionDescription(isProxy),
  type: 'General',
  answers: [
    {
      id: 'travel-to-work-answer',
      mandatory: false,
      options: [
        {
          label: 'Work mainly at or from home',
          value: 'Work mainly at or from home',
        },
        {
          label: 'Underground, metro, light rail or tram',
          value: 'Underground, metro, light rail or tram',
        },
        {
          label: 'Train',
          value: 'Train',
        },
        {
          label: 'Bus, minibus or coach',
          value: 'Bus, minibus or coach',
        },
        {
          label: 'Taxi',
          value: 'Taxi',
        },
        {
          label: 'Motorcycle, scooter or moped',
          value: 'Motorcycle, scooter or moped',
        },
        {
          label: 'Driving a car or van',
          value: 'Driving a car or van',
        },
        {
          label: 'Passenger in a car or van',
          value: 'Passenger in a car or van',
        },
        {
          label: 'Bicycle',
          value: 'Bicycle',
        },
        {
          label: 'On foot',
          value: 'On foot',
        },
        {
          label: 'Other',
          value: 'Other',
        },
      ],
      type: 'Radio',
    },
  ],
};

{
  type: 'Question',
  id: 'travel-to-work',
  page_title: 'Travel to work',
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
}
