-- Сравнение ключевых метрик по типам мероприятий

SELECT
    event_type,
    COUNT(event_id) AS events_count,
    SUM(registrations_count) AS total_registrations,
    SUM(participants_count) AS total_participants,
    SUM(submitted_projects_count) AS total_submitted_projects,
    SUM(finished_participants_count) AS total_finished_participants,
    ROUND(AVG(registrations_count), 2) AS avg_registrations,
    ROUND(AVG(participants_count), 2) AS avg_participants,

    ROUND(
        SUM(participants_count)::numeric
        / NULLIF(SUM(registrations_count), 0) * 100,
        2
    ) AS registration_to_participation_conversion,

    ROUND(
        SUM(submitted_projects_count)::numeric
        / NULLIF(SUM(participants_count), 0) * 100,
        2
    ) AS participation_to_submission_conversion,

    ROUND(
        SUM(finished_participants_count)::numeric
        / NULLIF(SUM(participants_count), 0) * 100,
        2
    ) AS participation_to_finish_conversion
FROM it_events
GROUP BY event_type
ORDER BY events_count DESC;

