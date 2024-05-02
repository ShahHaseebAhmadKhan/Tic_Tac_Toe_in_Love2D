-- Define a function named 'button' which takes several parameters:
-- 'text': The text to be displayed on the button.
-- 'func': The function to be executed when the button is clicked.
-- 'param': Optional parameter to pass to the function.
-- 'width': Optional width of the button. Default is 100.
-- 'height': Optional height of the button. Default is 50.
function button(text, func, param, width, height)
    -- Return a table containing properties and methods for the button:
    return {
        -- Set the width of the button. If 'width' is not provided, default to 100.
        width = width or 100,
        -- Set the height of the button. If 'height' is not provided, default to 50.
        height = height or 50,
        -- Set the function to be executed when the button is clicked. If 'func' is not provided, use a default function.
        func = func or function ()
            print("This button has no function attached")
        end,
        -- Set the parameter to be passed to the function. Default to nil if 'param' is not provided.
        param = param or nil,
        -- Set the text to be displayed on the button. If 'text' is not provided, default to an empty string.
        text = text or "",
        -- Set initial X position of the button.
        buttonX = 0,
        -- Set initial Y position of the button.
        buttonY = 0,
        -- Set initial X position of the text.
        textX = 0,
        -- Set initial Y position of the text.
        textY = 0,

        -- Method to check if the button is pressed based on mouse coordinates.
        checkPressed = function(self, mouseX, mouseY)
            -- Check if the mouse coordinates are within the button boundaries.
            if (mouseX >= self.buttonX and mouseX < self.width + self.buttonX)
            and
            (mouseY >= self.buttonY and mouseY < self.height + self.buttonY) then
                -- If the button has a function assigned to it, execute the function with optional parameter 'param'.
                if self.func then
                    self.func(self.param)
                else
                    -- If no function is assigned, execute a default function.
                    self.func()
                end
            end
        end,

        -- Method to draw the button on the screen.
        draw = function(self, buttonX, buttonY, textX, textY, alpha, scale)
            -- Set the button's position. If 'buttonX' and 'buttonY' are not provided, use current positions.
            self.buttonX = buttonX or self.buttonX
            self.buttonY = buttonY or self.buttonY

            -- Set the text's position relative to the button. If 'textX' and 'textY' are not provided, align with the button's position.
            if textX then
                self.textX = textX + self.buttonX
            else
                self.textX = self.buttonX
            end

            if textY then
                self.textY = textY + self.buttonY
            else
                self.textY = self.buttonY
            end

            -- Set the color of the button.
            love.graphics.setColor(.4 ,.4,.4,alpha)
            -- Draw a filled rectangle representing the button.
            love.graphics.rectangle(
                "fill",
                self.buttonX,
                self.buttonY,
                self.width,
                self.height
            )
            -- Set the color of the text.
            love.graphics.setColor(1,1,1)
            -- Print the text on the button.
            love.graphics.print(self.text, self.textX, self.textY, 0, scale, scale)
        end
    }
end

-- Return the 'button' function so it can be used externally.
return button
