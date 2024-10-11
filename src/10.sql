SELECT machine_id, ROUND(AVG(processing_time), 3) AS processing_time FROM
    (SELECT machine_id,
        activity_type,
        Activity.timestamp - (lag(Activity.timestamp) OVER (ORDER BY machine_id, process_id, activity_type)) as processing_time
        FROM Activity
    ) as TABLE1
WHERE activity_type = 'end'
GROUP BY machine_id;
