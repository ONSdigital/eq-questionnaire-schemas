local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'study-location-in-northern-ireland-question',
  type: 'General',
  title: title,
  answers: [
    {
      id: 'study-location-in-northern-ireland-details-answer-building',
      label: 'Address line 1',
      mandatory: true,
      type: 'TextField',
    },
    {
      id: 'study-location-in-northern-ireland-details-answer-street',
      label: 'Address line 2',
      mandatory: false,
      type: 'TextField',
    },
    {
      id: 'study-location-in-northern-ireland-details-answer-city',
      label: 'Town or city',
      mandatory: false,
      type: 'TextField',
    },
    {
      id: 'study-location-in-northern-ireland-details-answer-postcode',
      label: 'Postcode',
      mandatory: false,
      type: 'TextField',
    },
  ],
};

local nonProxyTitleSchool = 'What is the address of your main place of <em>study</em>?';
local proxyTitleSchool = {
  text: 'What is the address of <em>{person_name_possessive}</em> main place of <em>study</em>?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

{
  type: 'Question',
  id: 'study-location-in-northern-ireland',
  question_variants: [
    {
      question: question(nonProxyTitleSchool),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitleSchool),
      when: [rules.isProxy],
    },
  ],
}
