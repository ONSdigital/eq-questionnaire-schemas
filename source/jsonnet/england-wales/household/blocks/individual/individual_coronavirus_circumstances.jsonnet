local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'Interstitial',
  id: 'individual-coronavirus-circumstances',
  page_title: 'Individual circumstances due to coronavirus',
  content: {
    title: 'Coronavirus (COVID-19)',
    contents: [
      {
        description: {
          text: 'Circumstances for {person_name} may have changed during the coronavirus pandemic. Answer all questions based on the situation as it is now.',
          placeholders: [
            placeholders.personName(),
          ],
        },
      },
    ],
  },
}
