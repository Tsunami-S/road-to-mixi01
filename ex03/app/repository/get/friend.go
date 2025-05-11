package get

import (
	"minimal_sns_app/db"
	"minimal_sns_app/model"
)

type RealFriendRepository struct{}

func (r *RealFriendRepository) GetFriends(id int) ([]model.Friend, error) {
	return Friend(id)
}

func Friend(id int) ([]model.Friend, error) {
	var friends []model.Friend
	query := `
        SELECT u.user_id AS id, u.name
        FROM friend_link f
        JOIN users u ON u.user_id = f.user2_id
        WHERE f.user1_id = ?
        AND NOT EXISTS (
            SELECT 1 FROM block_list
            WHERE (user1_id = f.user1_id AND user2_id = f.user2_id)
               OR (user1_id = f.user2_id AND user2_id = f.user1_id)
        )
        UNION
        SELECT u.user_id AS id, u.name
        FROM friend_link f
        JOIN users u ON u.user_id = f.user1_id
        WHERE f.user2_id = ?
        AND NOT EXISTS (
            SELECT 1 FROM block_list
            WHERE (user1_id = f.user1_id AND user2_id = f.user2_id)
               OR (user1_id = f.user2_id AND user2_id = f.user1_id)
        );
    `

	err := db.DB.Raw(query, id, id).Scan(&friends).Error

	return friends, err
}
