// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve2  2>&1 < %s| FileCheck %s


// --------------------------------------------------------------------------//
// Invalid result type.

ldnt1sh { z0.b }, p0/z, [z0.s]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction
// CHECK-NEXT: ldnt1sh { z0.b }, p0/z, [z0.s]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

ldnt1sh { z0.h }, p0/z, [z0.s]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction
// CHECK-NEXT: ldnt1sh { z0.h }, p0/z, [z0.s]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:


// --------------------------------------------------------------------------//
// Invalid base vector.

ldnt1sh { z0.s }, p0/z, [z0.b]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid element width
// CHECK-NEXT: ldnt1sh { z0.s }, p0/z, [z0.b]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

ldnt1sh { z0.d }, p0/z, [z0.h]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid element width
// CHECK-NEXT: ldnt1sh { z0.d }, p0/z, [z0.h]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:


// --------------------------------------------------------------------------//
// Invalid offset type.

ldnt1sh { z0.d }, p0/z, [z0.d, z1.d]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction
// CHECK-NEXT: ldnt1sh { z0.d }, p0/z, [z0.d, z1.d]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:


// --------------------------------------------------------------------------//
// Invalid predicate operation

ldnt1sh { z0.d }, p0/m, [z0.d]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction
// CHECK-NEXT: ldnt1sh { z0.d }, p0/m, [z0.d]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:


// --------------------------------------------------------------------------//
// restricted predicate has range [0, 7].

ldnt1sh { z27.d }, p8/z, [z0.d]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ldnt1sh { z27.d }, p8/z, [z0.d]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:


// --------------------------------------------------------------------------//
// Invalid vector list.

ldnt1sh { }, p0/z, [z0.d]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector register expected
// CHECK-NEXT: ldnt1sh { }, p0/z, [z0.d]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

ldnt1sh { z0.d, z1.d }, p0/z, [z0.d]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction
// CHECK-NEXT: ldnt1sh { z0.d, z1.d }, p0/z, [z0.d]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

ldnt1sh { v0.2d }, p0/z, [z0.d]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand for instruction
// CHECK-NEXT: ldnt1sh { v0.2d }, p0/z, [z0.d]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:


// --------------------------------------------------------------------------//
// Negative tests for instructions that are incompatible with movprfx

movprfx z0.d, p0/z, z7.d
ldnt1sh  { z0.d }, p0/z, [z0.d, x0]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: instruction is unpredictable when following a movprfx, suggest replacing movprfx with mov
// CHECK-NEXT: ldnt1sh  { z0.d }, p0/z, [z0.d, x0]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

movprfx z0, z7
ldnt1sh  { z0.s }, p0/z, [z0.s, x0]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: instruction is unpredictable when following a movprfx, suggest replacing movprfx with mov
// CHECK-NEXT: ldnt1sh  { z0.s }, p0/z, [z0.s, x0]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:
