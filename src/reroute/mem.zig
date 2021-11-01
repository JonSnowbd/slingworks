const std = @import("std");
const mem = std.mem;

pub fn RingBufferGenerate(comptime size: usize) type {
    return struct {
        var allocator: mem.Allocator = mem.Allocator{
            .allocFn = alloc,
            .resizeFn = mem.Allocator.noResize,
        };
        var end_index: usize = 0;
        var buffer: [size]u8 = undefined;
        fn alloc(a: *mem.Allocator, n: usize, ptr_align: u29, len_align: u29, ret_addr: usize) std.mem.Allocator.Error![]u8 {
            const addr = @ptrToInt(&buffer) + end_index;
            const adjusted_addr = mem.alignForward(addr, ptr_align);
            const adjusted_index = end_index + (adjusted_addr - addr);
            const new_end_index = adjusted_index + n;

            if (new_end_index > buffer.len) {
                // if more memory is requested then we have in our buffer leak like a sieve!
                if (n > buffer.len) {
                    std.debug.warn("\n---------\nwarning: tmp allocated more than is in our temp allocator. This memory WILL leak!\n--------\n", .{});
                    return allocator.allocFn(a, n, ptr_align, len_align, ret_addr);
                }

                const result = buffer[0..n];
                end_index = n;
                return result;
            }
            const result = buffer[adjusted_index..new_end_index];
            end_index = new_end_index;

            return result;
        }
    };
}

const internal = RingBufferGenerate(1024*1024*3);
/// Preferred allocator to use if you need to allocate yourself.
pub const Allocator = std.heap.c_allocator;
/// You can use this to allocate temp memory that you never have to free.
pub var RingBuffer: *std.mem.Allocator = &internal.allocator;