var element = document.getElementById('visualization');
var sourceName = 'Real Time Sales';
var visualization = {
    name: 'Packed Bubbles',
    variables: {
        'Bubble Size': 'count',
        'Bubble Color': 'usersentiment:avg'
    }
};
var credentials = {
    secure: false,
    host: 'localhost',
    port: 8080,
    path: '/zoomdata',
    key: '551894f5d4c6c18e19cc7b57'
};
var queryConfig = {
    player: {
        speed: 1,
        pauseAfterRead: true
    },
    time: {
        timeField: '_ts'
    },
    filters: [],
    groupBy: [{
        name: 'usercity',
        limit: 10,
        sort: {
            dir: 'desc',
            name: 'usersentiment'
        }
    }],
    metrics: [
        {
            name: 'usersentiment',
            func: 'AVG'
        }
    ]
};

Zoomdata.createClient({
    credentials: credentials
})
    .then(
        function (client) {
            window.client = client;
            console.log('Validated:', client);

            return client
                    .createQuery(sourceName, queryConfig)
                    .then(function (query) {
                        console.log('Query created:', query);
                        window.query = query;
                        query.on('filters:add', function (filters) {
                            console.log('Filters add:', filters);
                        });
                        query.on('filters:remove', function (filters) {
                            console.log('Filters remove:', filters);
                        });
                        query.on('filters:change', function (filters) {
                            console.log('Filters change:', filters);
                        });
                    });
        }
    )
    .then(
        function () {
            return window
                    .client
                    .visualize({
                        element: element,
                        query: query,
                        visualization: visualization.name,
                        variables: visualization.variables
                    });
        }
    )
    .catch(onError);

function onError(reason) {
    console.error(reason.stack || reason.statusText || reason);
}
