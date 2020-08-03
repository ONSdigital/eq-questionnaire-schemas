local rules = import 'rules.libsonnet';

local question(title, instruction) = {
  id: 'rooms-shared-with-another-household-question',
  title: title,
  instruction: instruction,
  type: 'General',
  answers: [{
    id: 'rooms-shared-with-another-household-answer',
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
  id: 'rooms-shared-with-another-household',
  question_variants: [
    {
      question: question('Are all the rooms in this accommodation, including the kitchen, bathroom and toilet, behind a door that only this household can use?', ['If “No” confirm one or more rooms are shared with another household']),
      when: [rules.livingAtCurrentAddress],
    },
    {
      question: question('Were all the rooms in that accommodation, including the kitchen, bathroom and toilet, behind a door that only this household could use?', ['If “No” confirm one or more rooms were shared with another household']),
      when: [rules.livingAtDifferentAddress],
    },
  ],
}
