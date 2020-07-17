local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'self-contained-question',
  title: title,
  instruction: 'If “No” confirm one or more rooms were shared with another household',
  type: 'General',
  answers: [{
    id: 'self-contained-answer',
    mandatory: false,
    options: [
      {
        label: 'Yes',
        value: 'Yes',
      },
      {
        label: 'No',
        value: 'No',
      },
    ],
    type: 'Radio',
  }],
};

{
  type: 'Question',
  id: 'self-contained',
  question_variants: [
    {
      question: question('Are all the rooms in this accommodation, including the kitchen, bathroom and toilet, behind a door that only this household can use?'),
      when: [rules.livingAtCurrentAddress],
    },
    {
      question: question('Were all the rooms in that accommodation, including the kitchen, bathroom and toilet, behind a door that only this household could use?'),
      when: [rules.livingAtDifferentAddress],
    },
  ],
}
