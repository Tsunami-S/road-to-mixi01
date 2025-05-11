package debug

import (
	"fmt"

	"github.com/labstack/echo/v4"
)

func CheckIP(c echo.Context) error {
	realIP := c.Request().Header.Get("X-Real-IP")
	forwardedFor := c.Request().Header.Get("X-Forwarded-For")
	remoteAddr := c.RealIP()

	fmt.Printf("X-Real-IP: %s\n", realIP)
	fmt.Printf("X-Forwarded-For: %s\n", forwardedFor)
	fmt.Printf("c.RealIP(): %s\n", remoteAddr)

	return c.JSON(200, map[string]string{
		"X-Real-IP":       realIP,
		"X-Forwarded-For": forwardedFor,
		"c.RealIP()":      remoteAddr,
	})
}
