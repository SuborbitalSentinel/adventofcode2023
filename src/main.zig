const day1 = @import("day1.zig");
const day2 = @import("day2.zig");

pub fn main() !void {
    const std = @import("std");

    std.debug.print("day1, part1: {d}\n", .{try day1.part1("./inputs/day1/puzzle")});
    std.debug.print("day1, part2: {d}\n", .{try day1.part2("./inputs/day1/puzzle")});
    std.debug.print("\n", .{});
    std.debug.print("day2, part1: {d}\n", .{try day2.part1("./inputs/day2/puzzle")});
    std.debug.print("day2, part2: {d}\n", .{try day2.part2("./inputs/day2/puzzle")});
}

test {
    @import("std").testing.refAllDecls(@This());
}
