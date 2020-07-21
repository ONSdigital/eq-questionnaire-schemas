local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'accommodation-type-question',
  title: title,
  instruction: ['Tell the respondent to turn to <strong>Showcard 3</strong> or show them the options below'],
  type: 'General',
  answers: [
    {
      id: 'accommodation-type-answer',
      mandatory: false,
      type: 'Radio',
      options: [
        {
          label: 'Whole house or bungalow',
          value: 'Whole house or bungalow',
        },
        {
          label: 'Flat, maisonette or apartment',
          value: 'Flat, maisonette or apartment',
          description: 'Including purpose-built flats and flats within converted buildings',
        },
        {
          label: 'Caravan or other mobile or temporary structure',
          value: 'Caravan or other mobile or temporary structure',
        },
      ],
    },
  ],
};

{
  type: 'Question',
  id: 'accommodation-type',
  question_variants: [
    {
      question: question('What type of accommodation is this?'),
      when: [rules.livingAtCurrentAddress],
    },
    {
      question: question('What type of accommodation was that?'),
      when: [rules.livingAtDifferentAddress],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'type-of-house',
        when: [rules.accommodationIsHouse],
      },
    },
    {
      goto: {
        block: 'type-of-flat',
        when: [rules.accommodationIsFlat],
      },
    },
    {
      goto: {
        block: 'self-contained',
      },
    },
  ],
}
