local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, guidanceHeader) = {
  id: 'jobseeker-question',
  title: title,
  type: 'General',
  answers: [
    {
      guidance: {
        show_guidance: guidanceHeader,
        hide_guidance: guidanceHeader,
        contents: [
          {
            description: 'To get a true picture of the working population, we ask this question of everyone who is not currently working. We ask people who are retired because the number of people continuing to work after retirement is increasing. We ask people who are not working due to long-term illness or disability because some intend to go back to work.',
          },
        ],
      },
      id: 'jobseeker-answer',
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
    },
  ],
};

local nonProxyTitle = 'In the last four weeks, were you actively looking for any kind of paid work?';
local proxyTitle = {
  text: 'In the last four weeks, was <em>{person_name}</em> actively looking for any kind of paid work?',
  placeholders: [
    placeholders.personName,
  ],
};
local nonProxyGuidanceHeader = 'Why we ask this question if you are retired or long-term sick or disabled';
local proxyGuidanceHeader = 'Why we ask this question if they are retired or long-term sick or disabled';

{
  type: 'Question',
  id: 'looking-for-work',
  question_variants: [
    {
      question: question(nonProxyTitle, nonProxyGuidanceHeader),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, proxyGuidanceHeader),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'about-to-start-job',
        when: [
          {
            id: 'jobseeker-answer',
            condition: 'equals',
            value: 'No',
          },
        ],
      },
    },
    {
      goto: {
        block: 'available-for-work',
      },
    },
  ],
}
