# Custom Chat Names Script

This Lua script is designed for game servers to allow players to set custom names and chat in custom colors. It provides functionality for storing and displaying custom player names and chat messages.

## Features

- Set custom player names with color codes.
- Broadcast custom chat messages with player names in custom colors.
- View and display your custom player name.
- Automatic data saving to persist custom names.

## Installation

1. Place the `namechange.lua` script in your game server's resources directory.

2. Configure the `dataFilePath` variable in the script to specify the path where custom names will be saved in JSON format.

3. Make sure you have the necessary JSON library available in your Lua environment for encoding and decoding JSON data.

4. Ensure that this script is started with your game server's resource manager.

## Commands

- `/char [new name] [color number]`: Set your custom player name with an optional color code. Color codes range from 1 to 10, representing different colors. Example: `/char John 2` sets your name to "John" in green.

- `/showname`: View your custom player name.

## Usage

1. Use the `/char` command to set your custom player name. You can include an optional color code to specify the color of your name.

2. Chat messages sent by you and other players will appear in custom colors with custom names.

3. Use the `/showname` command to view your current custom player name.

4. Your custom player name and chat color settings will be saved automatically and persist across server sessions.

## Notes

- Color Codes:
  - `^1`: Red
  - `^2`: Green
  - `^3`: Yellow
  - `^4`: Blue
  - `^5`: Light Purple
  - `^6`: Orange
  - `^7`: White
  - `^8`: Gray
  - `^9`: Pink
  - `^0`: Black

- The script includes periodic data saving functionality, but you need to schedule it to run at regular intervals using your game server's timer or scheduler.

- When a player disconnects, their custom data is removed from the server to ensure data consistency.

---

Feel free to report any issues or suggest improvements by creating an issue in this repository.
