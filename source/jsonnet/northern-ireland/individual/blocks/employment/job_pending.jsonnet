local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, guidanceHeader) = {
  id: 'job-pending-question',
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
      id: 'job-pending-answer',
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

local nonProxyTitle = 'In the last seven days, were you waiting to start a job already accepted?';
local proxyTitle = {
  text: 'In the last seven days, was <em>{person_name}</em> waiting to start a job already accepted?',
  placeholders: [
    placeholders.personName,
  ],
};

local nonProxyGuidanceHeader = 'Why we ask this question if you are retired or long-term sick or disabled';
local proxyGuidanceHeader = 'Why we ask this question if they are retired or long-term sick or disabled';


{
  type: 'Question',
  id: 'about-to-start-job',
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
}
