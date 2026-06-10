-- Сегментация мероприятий по размеру аудитории

SELECT
    CASE
        WHEN participants_count < 100 THEN 'До 100 участников'
        WHEN participants_count BETWEEN 100 AND 999 THEN '100-999 участников'
        ELSE '1000+ участников'
    END AS event_size_segment,
    COUNT(event_id) AS events_count,
    SUM(participants_count) AS total_participants,
    ROUND(AVG(participants_count), 2) AS avg_participants,
    ROUND(AVG(registrations_count), 2) AS avg_registrations
FROM it_events
GROUP BY event_size_segment
ORDER BY
    CASE
        WHEN event_size_segment = 'До 100 участников' THEN 1
        WHEN event_size_segment = '100-999 участников' THEN 2
        ELSE 3
    END;

