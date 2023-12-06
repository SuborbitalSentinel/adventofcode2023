const std = @import("std");
const utils = @import("utils.zig");

test "day1 part1" {
    try std.testing.expectEqual(@as(u32, 142), try part1("./inputs/day1/test1"));
}

test "day1 part2" {
    try std.testing.expectEqual(@as(u32, 281), try part2("./inputs/day1/test2"));
}

pub fn part1(filePath: []const u8) !u32 {
    var total: u32 = 0;
    for (try utils.readFile(filePath)) |line| {
        var counter: u8 = 0;
        var buf: [50]u8 = undefined;
        for (line) |char| {
            const is_integer = char >= 48 and char <= 57;
            if (is_integer) {
                buf[counter] = char;
                counter += 1;
            }
        }
        total += try std.fmt.parseInt(u32, &[2]u8{ buf[0], buf[counter - 1] }, 10);
    }
    return total;
}

pub fn part2(filePath: []const u8) !u32 {
    var total: u32 = 0;

    for (try utils.readFile(filePath)) |line| {
        var choicecount: u8 = 0;
        var choices: [50]u8 = undefined;

        var bufcount: u8 = 0;
        var buf: [10]u8 = undefined;
        for (line) |char| {
            const is_integer = char >= 48 and char <= 57;
            if (is_integer) {
                choices[choicecount] = char;
                choicecount += 1;
                bufcount = 0;
                continue;
            }

            buf[bufcount] = char;
            bufcount += 1;

            if (validNums.get(buf[0..bufcount])) |value| {
                if (value != '0') {
                    choices[choicecount] = value;
                    choicecount += 1;
                    bufcount = rotateBufferUntilValidOrEmpty(&buf, bufcount);
                }
            } else {
                bufcount = rotateBufferUntilValidOrEmpty(&buf, bufcount);
            }
        }
        const value = try std.fmt.parseInt(u32, &[2]u8{ choices[0], choices[choicecount - 1] }, 10);
        total += value;
    }
    return total;
}

fn rotateBufferUntilValidOrEmpty(buf: *[10]u8, bufcount: u8) u8 {
    var tmpcnt = bufcount;
    var tmp: [10]u8 = undefined;
    for (buf[1..tmpcnt], 0..) |x, i| {
        tmp[i] = x;
    }
    @memcpy(buf, &tmp);
    tmpcnt -= 1;

    while (tmpcnt > 0 and !validNums.has(buf[0..tmpcnt])) {
        for (buf[1..tmpcnt], 0..) |x, i| {
            tmp[i] = x;
        }
        @memcpy(buf, &tmp);
        tmpcnt -= 1;
    }
    return tmpcnt;
}

const validNums = std.ComptimeStringMap(u8, .{
    .{ "e", '0' },
    .{ "ei", '0' },
    .{ "eig", '0' },
    .{ "eigh", '0' },
    .{ "eight", '8' },
    .{ "f", '0' },
    .{ "fi", '0' },
    .{ "fiv", '0' },
    .{ "five", '5' },
    .{ "fo", '0' },
    .{ "fou", '0' },
    .{ "four", '4' },
    .{ "n", '0' },
    .{ "ni", '0' },
    .{ "nin", '0' },
    .{ "nine", '9' },
    .{ "o", '0' },
    .{ "on", '0' },
    .{ "one", '1' },
    .{ "s", '0' },
    .{ "se", '0' },
    .{ "sev", '0' },
    .{ "seve", '0' },
    .{ "seven", '7' },
    .{ "si", '0' },
    .{ "six", '6' },
    .{ "t", '0' },
    .{ "th", '0' },
    .{ "thr", '0' },
    .{ "thre", '0' },
    .{ "three", '3' },
    .{ "tw", '0' },
    .{ "two", '2' },
});
