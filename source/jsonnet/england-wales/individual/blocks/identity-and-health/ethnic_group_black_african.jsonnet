local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'ethnic-group-black-african-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'ethnic-group-black-african-answer',
      label: 'African ethnic group or background',
      description: 'Enter your own answer or select from suggestions',
      mandatory: false,
      type: 'TextField',
    },
  ],
};
{
  type: 'Question',
  id: 'ethnic-group-black-african',
  question_variants: [
    {
      question: question('You selected “African”. How would you describe your African ethnic group or background?'),
      when: [rules.isNotProxy],
    },
    {
      question: question({
        text: 'You selected “African”. How would {person_name} describe their African ethnic group or background?',
        placeholders: [
          placeholders.personName,
        ],
      }),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'religion',
      },
    },
  ],
}
