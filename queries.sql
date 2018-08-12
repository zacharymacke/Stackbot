-- Pull the questions from the "post_questions" database (Legacy)
SELECT
  id,
  title,
  body,
  answer_count,
  creation_date,
  score,
  tags,
FROM
  [bigquery-public-data:stackoverflow.posts_questions]
WHERE
  tags LIKE '%python%'
  AND score > 0
  AND answer_count > 0


-- Pull the answers from the "posts_answers" database (Legacy)
SELECT
  id,
  body,
  score,
  parent_id,
FROM
  [bigquery-public-data:stackoverflow.posts_answers]
WHERE
  score >= 0


-- Change the answer column names (Standard)
SELECT
  * EXCEPT(body,score),
  body AS answer, score AS answer_score
FROM
`stack.all_answers` 


--Change question column names (Standard)
SELECT
  * EXCEPT(title,body,score),
  title AS question_title,
  body AS question_body,
  score AS question_score
FROM
  `stack.stack`


-- Merge questions and answers (Standard)
SELECT *
FROM `kaggle-210015.stack.python_questions` A, `kaggle-210015.stack.all_answers` B
WHERE A.question_id = B.parent_id


--Discard python 2.x (Legacy)
SELECT * FROM
  [kaggle-210015.stack.python_qa]
OMIT RECORD IF
  tags like '%python-2%'
or
  question_title like '%python (2%'
or
  question_title like '%python-2%'
or
  question_body like '%python (2%'
or
  question_body like '%python 2%'
or
  question_body like '%Python 2%'
or
  question_body like '%Python (2%'

