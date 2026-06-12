import http from 'k6/http';
import { check, group, sleep } from 'k6';

export const options = {
  scenarios: {
    one_graduation_review_per_user: {
      executor: 'per-vu-iterations',
      vus: 50,
      iterations: 1,
      maxDuration: '2m',
    },
  },
  thresholds: {
    http_req_failed: ['rate<0.01'],
    http_req_duration: ['p(95)<500'],
    'http_req_duration{type:frontend}': ['p(95)<300'],
    'http_req_duration{type:api}': ['p(95)<500'],
  },
};

const FRONTEND_BASE_URL = 'http://host.docker.internal:5500';
const API_URL = 'http://host.docker.internal:8000/';

const payload = JSON.stringify({
  entry_year: '111',
  transfer_grade: 0,
  waiver_credits: 0,
  courses: [
    {
      '課業學習': {
        gradeRecordList: [
          {
            GradeRecords: [
              { courseCode: '000713032' },
              { courseCode: '000219572' },
              { courseCode: '000359011' },
              { courseCode: '304004002' },
              { courseCode: '304030001' },
              { courseCode: '041195001' },
            ],
          },
        ],
      },
    },
  ],
});

export default function () {
  group('load frontend page', () => {
    const responses = http.batch([
      ['GET', `${FRONTEND_BASE_URL}/index.html`, null, { tags: { type: 'frontend', name: 'frontend_html' } }],
      ['GET', `${FRONTEND_BASE_URL}/下載.png`, null, { tags: { type: 'frontend', name: 'frontend_logo' } }],
    ]);

    check(responses[0], {
      'frontend html status is 200': (r) => r.status === 200,
      'frontend html has upload area': (r) => r.body.includes('uploadArea'),
    });

    check(responses[1], {
      'frontend logo status is 200': (r) => r.status === 200,
    });
  });

  sleep(Math.random() * 3 + 1);

  group('submit graduation review', () => {
    const res = http.post(API_URL, payload, {
      headers: { 'Content-Type': 'application/json' },
      tags: { type: 'api', name: 'graduation_review_api' },
    });

    check(res, {
      'api status is 200': (r) => r.status === 200,
      'api has total': (r) => r.status === 200 && r.json('total') !== undefined,
      'api has total_ge': (r) => r.status === 200 && r.json('total_ge') !== undefined,
    });
  });
}
