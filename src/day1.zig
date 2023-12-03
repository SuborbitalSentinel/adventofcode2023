const std = @import("std");
const utils = @import("utils.zig");

test "day1 part1" {
    try std.testing.expect(try part1("./inputs/day1/test1") == 142);
}

test "day1 part2" {
    try std.testing.expect(try part2("./inputs/day1/test2") == 281);
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

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var map = std.StringHashMap(u8).init(allocator);
    var keyIter = map.keyIterator();
    defer {
        while (keyIter.next()) |key| {
            allocator.free(key.*);
        }
        map.deinit();
    }
    try map.put("e", '0');
    try map.put("ei", '0');
    try map.put("eig", '0');
    try map.put("eigh", '0');
    try map.put("eight", '8');
    try map.put("f", '0');
    try map.put("fi", '0');
    try map.put("fiv", '0');
    try map.put("five", '5');
    try map.put("fo", '0');
    try map.put("fou", '0');
    try map.put("four", '4');
    try map.put("n", '0');
    try map.put("ni", '0');
    try map.put("nin", '0');
    try map.put("nine", '9');
    try map.put("o", '0');
    try map.put("on", '0');
    try map.put("one", '1');
    try map.put("s", '0');
    try map.put("se", '0');
    try map.put("sev", '0');
    try map.put("seve", '0');
    try map.put("seven", '7');
    try map.put("si", '0');
    try map.put("six", '6');
    try map.put("t", '0');
    try map.put("th", '0');
    try map.put("thr", '0');
    try map.put("thre", '0');
    try map.put("three", '3');
    try map.put("tw", '0');
    try map.put("two", '2');

    for (try utils.readFile(filePath)) |line| {
        var choicecount: u8 = 0;
        var choices: [50]u8 = undefined;

        var buffcount: u8 = 0;
        var buf: [10]u8 = undefined;
        for (line) |char| {
            const is_integer = char >= 48 and char <= 57;
            if (is_integer) {
                choices[choicecount] = char;
                choicecount += 1;
                buffcount = 0;
                continue;
            }

            buf[buffcount] = char;
            buffcount += 1;

            if (map.get(buf[0..buffcount])) |value| {
                if (value != '0') {
                    choices[choicecount] = value;
                    choicecount += 1;

                    var temp: [10]u8 = undefined;
                    for (buf[1..buffcount], 0..) |x, i| {
                        temp[i] = x;
                    }
                    buf = temp;
                    buffcount -= 1;

                    while (buffcount > 0 and !map.contains(buf[0..buffcount])) {
                        for (buf[1..buffcount], 0..) |x, i| {
                            temp[i] = x;
                        }
                        buf = temp;
                        buffcount -= 1;
                    }
                }
            } else {
                while (buffcount > 0 and !map.contains(buf[0..buffcount])) {
                    var temp: [10]u8 = undefined;
                    for (buf[1..buffcount], 0..) |x, i| {
                        temp[i] = x;
                    }
                    buf = temp;
                    buffcount -= 1;
                }
            }
        }
        const value = try std.fmt.parseInt(u32, &[2]u8{ choices[0], choices[choicecount - 1] }, 10);
        total += value;
    }
    return total;
}
