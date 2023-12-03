const std = @import("std");
const day1 = @import("day1.zig");

pub fn main() !void {
    std.debug.print("day1, part1: {d}\n", .{try day1.part1("./inputs/day1/puzzle")});
    std.debug.print("day1, part2: {d}\n", .{try day1.part2("./inputs/day1/puzzle")});
}

test {
    std.testing.refAllDecls(@This());
}
