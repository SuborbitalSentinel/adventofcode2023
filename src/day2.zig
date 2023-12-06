const std = @import("std");
const utils = @import("utils.zig");

test "day1 part1" {
    try std.testing.expectEqual(@as(u32, 8), try part1("./inputs/day2/test1"));
}

// test "day1 part2" {
//     try std.testing.expect(try part2("./inputs/day2/test2") == 281);
// }

pub fn part1(filePath: []const u8) !u32 {
    _ = filePath;
    return 0;
}

pub fn part2(filePath: []const u8) !u32 {
    _ = filePath;
    return 0;
}
