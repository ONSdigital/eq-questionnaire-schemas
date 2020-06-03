local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'who-rent-from-question',
  title: 'Who is your landlord?',
  instruction: 'Tell respondent to turn to <strong>Showcard 5</strong> or show them the options below',
  type: 'General',
  answers: [{
    id: 'who-rent-from-answer',
    mandatory: false,
    options: [
      {
        label: 'Housing association, housing co-operative, charitable trust, registered social landlord',
        value: 'Housing association, housing co-operative, charitable trust, registered social landlord',
      },
      {
        label: 'Council or local authority',
        value: 'Council or local authority',
      },
      {
        label: 'Private landlord or letting agency',
        value: 'Private landlord or letting agency',
      },
      {
        label: 'Employer of a household member',
        value: 'Employer of a household member',
      },
      {
        label: 'Relative or friend of a household member',
        value: 'Relative or friend of a household member',
      },
      {
        label: 'Other',
        value: 'Other',
      },
    ],
    type: 'Radio',
  }],
};

{
  type: 'Question',
  id: 'who-rent-from',
  question_variants: [
    {
      question: question('Who is your landlord?'),
      when: [rules.livingAtCurrentAddress],
    },
    {
      question: question('Who was your landlord?'),
      when: [rules.livingAtDifferentAddress],
    },
  ],
}
