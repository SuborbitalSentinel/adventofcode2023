const std = @import("std");
pub fn readFile(filePath: []const u8) ![][]const u8 {
    var file = try std.fs.cwd().openFile(filePath, .{ .mode = .read_only });
    defer file.close();

    var buffered = std.io.bufferedReader(file.reader());
    var reader = buffered.reader();

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var buf = std.ArrayList(u8).init(allocator);
    defer buf.deinit();

    var results = std.ArrayList([]const u8).init(allocator);
    defer results.deinit();

    while (true) {
        reader.streamUntilDelimiter(buf.writer(), '\n', null) catch |err| switch (err) {
            error.EndOfStream => break,
            else => return err,
        };
        try results.append(try buf.toOwnedSlice());
        buf.clearRetainingCapacity();
    }

    return try results.toOwnedSlice();
}
