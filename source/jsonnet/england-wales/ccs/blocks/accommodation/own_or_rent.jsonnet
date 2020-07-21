local rules = import 'rules.libsonnet';

local question(title, options) = {
  id: 'own-or-rent-question',
  title: title,
  instruction: ['Tell the respondent to turn to <strong>Showcard 4</strong> or show them the options below'],
  type: 'General',
  answers: [{
    id: 'own-or-rent-answer',
    mandatory: false,
    options: options,
    type: 'Radio',
  }],
};

local presentOptions = [
  {
    label: 'Owns outright',
    value: 'Owns outright',
  },
  {
    label: 'Owns with a mortgage or loan',
    value: 'Owns with a mortgage or loan',
  },
  {
    label: 'Part-owns and part-rents',
    value: 'Part-owns and part-rents',
    description: 'Shared ownership',
  },
  {
    label: 'Rents',
    value: 'Rents',
    description: 'With or without housing benefit',
  },
  {
    label: 'Lives here rent-free',
    value: 'Lives here rent-free',
  },
];

local pastOptions = [
  {
    label: 'Owned outright',
    value: 'Owned outright',
  },
  {
    label: 'Owned with a mortgage or loan',
    value: 'Owned with a mortgage or loan',
  },
  {
    label: 'Part-owned and part-rented',
    value: 'Part-owned and part-rented',
    description: 'Shared ownership',
  },
  {
    label: 'Rented',
    value: 'Rented',
    description: 'With or without housing benefit',
  },
  {
    label: 'Lived there rent-free',
    value: 'Lived there rent-free',
  },
];

{
  type: 'Question',
  id: 'own-or-rent',
  question_variants: [
    {
      question: question('Does your household own or rent this accommodation?', presentOptions),
      when: [rules.livingAtCurrentAddress],
    },
    {
      question: question('Did your household own or rent that accommodation?', pastOptions),
      when: [rules.livingAtDifferentAddress],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'who-rent-from',
        when: [{
          id: 'own-or-rent-answer',
          condition: 'equals any',
          values: ['Rents', 'Rented'],
        }],
      },
    },
    {
      goto: {
        block: 'who-rent-from',
        when: [{
          id: 'own-or-rent-answer',
          condition: 'equals any',
          values: ['Part-owns and part-rents', 'Part-owned and part-rented'],
        }],
      },
    },
    {
      goto: {
        block: 'who-rent-from',
        when: [{
          id: 'own-or-rent-answer',
          condition: 'equals any',
          values: ['Lives here rent-free', 'Lived there rent-free'],
        }],
      },
    },
    {
      goto: {
        block: 'internet',
      },
    },
  ],
}
