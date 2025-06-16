SELECT
    o.name,
    o.type_desc,
    (SELECT
         COUNT(*)
     FROM
         sys.sql_expression_dependencies sed
     WHERE
         sed.referencing_id = o.object_id) as dependent_object_count
FROM
    sys.objects o
WHERE
    o.type IN ('TF', 'IF', 'FN', 'FS', 'FT')
ORDER BY
    dependent_object_count DESC,
    o.name;