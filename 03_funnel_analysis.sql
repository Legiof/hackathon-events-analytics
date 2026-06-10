-- Анализ общей воронки участия:
-- регистрация -> участие -> сдача проекта -> завершение

SELECT
    SUM(registrations_count) AS total_registrations,
    SUM(participants_count) AS total_participants,
    SUM(submitted_projects_count) AS total_submitted_projects,
    SUM(finished_participants_count) AS total_finished_participants,

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
FROM it_events;

