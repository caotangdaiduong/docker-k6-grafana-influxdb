import http from 'k6/http';
import {
    check,
    sleep
} from 'k6';

export const options = {
    stages: [{
            duration: '30s',
            target: 1000
        },
        {
            duration: '60s',
            target: 2000
        },
        {
            duration: '30s',
            target: 500
        }
    ]
}

export default function () {
    const url = 'https://www.reddit.com';

    const response = http.get(url);

    check(response, {
        'is status 200': (r) => r.status == 200,
        'is not status 200': (r) => r.status != 200,
    });

    sleep(1);
}
