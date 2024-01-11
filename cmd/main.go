package main

import (
	"github.com/gbrzyn/auth-service-api/internal/database"
	"github.com/gin-gonic/gin"
)

func setupRouter() *gin.Engine {
	r := gin.Default()

	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})

	database.Connect()
	return r
}

func main() {
	router := setupRouter()

	router.Run()
}
