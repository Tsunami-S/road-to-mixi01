INSERT INTO users (user_id, name) VALUES
  (1, 'user01'), (2, 'user02'), (3, 'user03'), (4, 'user04'), (5, 'user05'), (6, 'user06'), (7, 'user07'), (8, 'user08'), (9, 'user09'), (10, 'user10'), (11, 'user11'), (12, 'user12'), (13, 'user13'), (14, 'user14'), (15, 'user15'), (16, 'user16'), (17, 'user17'), (18, 'user18'), (19, 'user19'), (20, 'user20'), (21, 'user21'), (22, 'user22'), (23, 'user23'), (24, 'user24'), (25, 'user25'), (26, 'user26'), (27, 'user27'), (28, 'user28'), (29, 'user29'), (30, 'user30'), (31, 'user31'), (32, 'user32'), (33, 'user33'), (34, 'user34'), (35, 'user35'), (36, 'user36'), (37, 'user37'), (38, 'user38'), (39, 'user39'), (40, 'user40'), (41, 'user41'), (42, 'user42'), (43, 'user43'), (44, 'user44');

INSERT INTO friend_link (user1_id, user2_id) VALUES
  (1, 2), (1, 3), (1, 6), (1, 7), (1, 8), (1, 9), (5, 1), (4, 1), (24, 1), (23, 1), (1, 22), (1, 21), (1, 10), (10, 1), (2, 3), (3, 39), (3, 40), (19, 2), (18, 2), (16, 2), (17, 2), (2, 14), (2, 15), (13, 2), (2, 11), (2, 12), (12, 2), (5, 37), (5, 38), (5, 36), (36, 5), (31, 5), (5, 32), (5, 4), (4, 30), (4, 29), (28, 4), (27, 4), (26, 4), (25, 4);

INSERT INTO block_list (user1_id, user2_id) VALUES
  (1, 39), (40, 1), (38, 1), (1, 37), (7, 3), (3, 6), (41, 3), (3, 41), (42, 3), (3, 43), (17, 2), (2, 16), (2, 15), (14, 2), (19, 1), (1, 18), (1, 20), (20, 1), (21, 1), (1, 22), (23, 1), (1, 24), (26, 1), (1, 25), (4, 27), (28, 4), (4, 29), (30, 4), (33, 5), (5, 34), (35, 5), (5, 35), (5, 9), (8, 5);
