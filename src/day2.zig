const std = @import("std");
const utils = @import("utils.zig");

test "day2 part1" {
    try std.testing.expectEqual(@as(u32, 8), try part1("./inputs/day2/test1"));
}

test "day2 part2" {
    try std.testing.expectEqual(@as(u32, 2286), try part2("./inputs/day2/test2"));
}

// POSSIBLE GAMES
// 12 red
// 13 green
// 14 blue
// Game 1:
pub fn part1(filePath: []const u8) !u32 {
    var gameSum: u32 = 0;
    for (try utils.readFile(filePath)) |line| {
        const gameNumberBegin = std.mem.indexOf(u8, line, " ").? + 1;
        const gameNumberEnd = std.mem.indexOf(u8, line, ":").?;
        const gameNumber = try std.fmt.parseInt(u8, line[gameNumberBegin..gameNumberEnd], 10);

        const colors = enum { red, green, blue };
        var gameState = [3]i8{ 12, 13, 14 };
        var gameInvalid: bool = false;

        var sets = std.mem.splitSequence(u8, line[gameNumberEnd + 2 ..], "; ");
        while (sets.next()) |game| {
            if (gameInvalid) break;

            var tokens = std.mem.splitSequence(u8, game, ", ");
            while (tokens.next()) |token| {
                var values = std.mem.splitScalar(u8, token, ' ');
                const number = try std.fmt.parseInt(i8, values.first(), 10);
                const color = std.meta.stringToEnum(colors, values.next().?).?;
                gameState[@intFromEnum(color)] -= number;
            }
            gameInvalid = !validGame(gameState);
            resetGame(&gameState);
        }
        if (!gameInvalid) gameSum += gameNumber;
    }
    return gameSum;
}

pub fn part2(filePath: []const u8) !u32 {
    var gameSum: u32 = 0;
    for (try utils.readFile(filePath)) |line| {
        const gameNumberEnd = std.mem.indexOf(u8, line, ":").?;

        const colors = enum { red, green, blue };
        var maximumRequired = [3]u32{ 0, 0, 0 };

        var sets = std.mem.splitSequence(u8, line[gameNumberEnd + 2 ..], "; ");
        while (sets.next()) |game| {
            var tokens = std.mem.splitSequence(u8, game, ", ");
            while (tokens.next()) |token| {
                var values = std.mem.splitScalar(u8, token, ' ');
                const number = try std.fmt.parseInt(u32, values.first(), 10);
                const color = @intFromEnum(std.meta.stringToEnum(colors, values.next().?).?);
                if (number > maximumRequired[color]) maximumRequired[color] = number;
            }
        }
        gameSum += maximumRequired[0] * maximumRequired[1] * maximumRequired[2];
    }
    return gameSum;
}

fn validGame(gameState: [3]i8) bool {
    return gameState[0] >= 0 and gameState[1] >= 0 and gameState[2] >= 0;
}

fn resetGame(gameState: *[3]i8) void {
    gameState[0] = 12;
    gameState[1] = 13;
    gameState[2] = 14;
}
