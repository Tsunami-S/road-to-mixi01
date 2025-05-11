package get_all

import (
	"net/http"

	repo_all "minimal_sns_app/repository/get_all"

	"github.com/labstack/echo/v4"
)

func Users(c echo.Context) error {
	users, err := repo_all.Users()
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"error": err.Error()})
	}
	return c.JSON(http.StatusOK, users)
}
