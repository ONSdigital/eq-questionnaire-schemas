local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'other-health-conditions-question',
  title: title,
  type: 'MutuallyExclusive',
  mandatory: false,
  answers: [
    {
      id: 'other-health-conditions-answer',
      mandatory: false,
      options: [
        {
          label: 'An intellectual or learning disability',
          value: 'An intellectual or learning disability',
          description: 'For example Down syndrome',
        },
        {
          label: 'A learning difficulty',
          value: 'A learning difficulty',
          description: 'For example dyslexia',
        },
        {
          label: 'Autism or Asperger syndrome',
          value: 'Autism or Asperger syndrome',
        },
        {
          label: 'An emotional, psychological or mental health condition',
          value: 'An emotional, psychological or mental health condition',
          description: 'For example depression or schizophrenia',
        },
        {
          label: 'Frequent periods of confusion or memory loss',
          value: 'Frequent periods of confusion or memory loss',
          description: 'For example dementia',
        },
        {
          label: 'Long-term pain or discomfort',
          value: 'Long-term pain or discomfort',
        },
        {
          label: 'Other condition',
          value: 'Other condition',
          description: 'For example cancer, diabetes or heart disease',
        },
      ],
      type: 'Checkbox',
    },
    {
      id: 'other-health-conditions-answer-exclusive',
      type: 'Checkbox',
      mandatory: false,
      options: [
        {
          label: 'None of these conditions',
          value: 'None of these conditions',
        },
      ],
    },
  ],
};

local nonProxyTitle = 'Do you have any of the following <em>other health conditions</em> which have lasted, or are expected to last, at least 12 months?';

local proxyTitle = {
  text: 'Does {person_name} have any of the following <em>other health conditions</em> which have lasted, or are expected to last, at least 12 months?',
  placeholders: [
    placeholders.personName(),
  ],
};

{
  type: 'Question',
  id: 'other-health-conditions',
  page_title: 'Other health conditions',
  question_variants: [
    {
      question: question(nonProxyTitle),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        section: 'End',
        when: [rules.schoolYearUnder4],
      },
    },
    {
      goto: {
        section: 'End',
        when: [rules.lastBirthdayAgeLessThan(4)],
      },
    },
    {
      goto: {
        block: 'look-after-or-support-others',
        when: [rules.over5],
      },
    },
    {
      goto: {
        block: 'look-after-or-support-others',
        when: [rules.lastBirthdayAgeOver(5)],
      },
    },
    {
      goto: {
        group: 'school-group',
      },
    },
  ],
}
