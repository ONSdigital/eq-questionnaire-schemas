local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'internet-question',
  title: title,
  instruction: ['Tell the respondent to turn to <strong>Showcard 6</strong> or show them the options below'],
  type: 'MutuallyExclusive',
  mandatory: false,
  answers: [
    {
      id: 'internet-answer',
      mandatory: false,
      type: 'Checkbox',
      options: [
        {
          label: 'Broadband or WiFi',
          value: 'Broadband or WiFi',
        },
        {
          label: 'A mobile phone network such as 3G, 4G or 5G',
          value: 'A mobile phone network such as 3G, 4G or 5G',
        },
        {
          label: 'Public WiFi hotspot',
          value: 'Public WiFi hotspot',
        },
      ],
    },
    {
      id: 'internet-answer-exclusive',
      type: 'Checkbox',
      mandatory: false,
      options: [
        {
          label: 'Unable to access the internet at home',
          value: 'Unable to access the internet at home',
        },
      ],
    },
  ],
};

{
  type: 'Question',
  id: 'internet',
  question_variants: [
    {
      question: question('How do you and the people in your household connect to the internet at home?'),
      when: [rules.livingAtCurrentAddress],
    },
    {
      question: question('How did you and the people in your household connect to the internet at home?'),
      when: [rules.livingAtDifferentAddress],
    },
  ],
}
