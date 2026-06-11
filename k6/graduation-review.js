import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  stages: [
    { duration: '30s', target: 400 },
    { duration: '30s', target: 400 },
    { duration: '30s', target: 400 },
    { duration: '20s', target: 0 },
  ],
  thresholds: {
    http_req_failed: ['rate<0.01'],
    http_req_duration: ['p(95)<500'],
  },
};

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
  const res = http.post('http://host.docker.internal:8000/', payload, {
    headers: { 'Content-Type': 'application/json' },
  });

  check(res, {
    'status is 200': (r) => r.status === 200,
    'has total': (r) => r.json('total') !== undefined,
    'has total_ge': (r) => r.json('total_ge') !== undefined,
  });

  sleep(1);
}