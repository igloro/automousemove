#Persistent
CoordMode, Mouse, Screen  ; Use absolute screen coordinates for all mouse commands

; Initialize global variables
lastX := 0
lastY := 0
moveX := 0
moveY := 0
isMoving := false ; Track if the script has moved the mouse

SetTimer, IdleCheck, 1000 ; Check every 1000 ms (1 second)
Return

IdleCheck:
    MouseGetPos, currentX, currentY
    if (A_TimeIdleMouse > 60000) ; Check if mouse has been idle > 60 seconds
    {
        if (isMoving) {
            ; If we previously moved the mouse, check if the user has moved it since
            if (currentX != lastX || currentY != lastY) {
                ; User moved the mouse, stop the script movements
                isMoving := false
                SetTimer, MoveMouseContinuously, Off
                Return
            }
        }

        SetTimer, MoveMouseContinuously, 100
        isMoving := true
    }
    else
    {
        SetTimer, MoveMouseContinuously, Off
        isMoving := false
    }
Return

MoveMouseContinuously:
    MouseGetPos, currentX, currentY

    ; Randomly move between -10 to 10 pixels
    Random, xMove, -10, 10
    Random, yMove, -10, 10

    moveX := currentX + xMove
    moveY := currentY + yMove

    ; Move the mouse to the new random position
    MouseMove, moveX, moveY, 10 ; speed 10

    ; Save the last moved coordinates
    lastX := moveX
    lastY := moveY
Return
