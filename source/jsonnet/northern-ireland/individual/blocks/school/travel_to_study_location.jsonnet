local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, description) = {
  title: title,
  id: 'travel-to-study-location-question',
  description: [
    description,
  ],
  type: 'General',
  answers: [
    {
      id: 'travel-to-study-location-answer',
      mandatory: false,
      options: [
        {
          label: 'Driving a car or van',
          value: 'Driving a car or van',
        },
        {
          label: 'Passenger in a car or van',
          value: 'Passenger in a car or van',
        },
        {
          label: 'Car or van pool, sharing driving',
          value: 'Car or van pool, sharing driving',
        },
        {
          label: 'Bus, minibus or coach',
          value: 'Bus, minibus or coach',
          description: 'This could be public or private',
        },
        {
          label: 'Taxi',
          value: 'Taxi',
        },
        {
          label: 'Train',
          value: 'Train',
        },
        {
          label: 'Motorcycle, scooter or moped',
          value: 'Motorcycle, scooter or moped',
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


local nonProxyTitleSchool = 'How do you usually travel to your main place of <em>study</em>, including school?';
local proxyTitleSchool = {
  text: 'How does <em>{person_name}</em> usually travel to their main place of <em>study</em>, including school?',
  placeholders: [
    placeholders.personName(),
  ],
};

local nonProxyDescriptionSchool = 'Answer for the longest part, by distance, of your usual journey to your place of study';
local proxyDescriptionSchool = 'Answer for the longest part, by distance, of their usual journey to their place of study';

{
  type: 'Question',
  id: 'travel-to-study-location',
  page_title: 'Travel to study location',
  question_variants: [
    {
      question: question(nonProxyTitleSchool, nonProxyDescriptionSchool),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitleSchool, proxyDescriptionSchool),
      when: [rules.isProxy],
    },
  ],
}
