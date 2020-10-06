import 'package:fixnum/fixnum.dart';

// Some primes between 2^63 and 2^64 for various uses.
final k0 = Int64(0xc3a5c85c97cb3127);
final k1 = Int64(0xb492b66fbe98f273);
final k2 = Int64(0x9ae16a3b2f90404f);

Int64 _fetch32(List<int> s) {
  // TODO: endianness. really. this only works for big-endian
  // Note: Int32 does not have .fromBytes().
  return Int64.fromBytes(s.sublist(0, 4) + [0, 0, 0, 0]);
}

Int64 _fetch64(List<int> s) {
  // TODO: endianness
  return Int64.fromBytes(s.sublist(0, 8));
}

Int64 _rotate64(Int64 value, int shift) {
  return shift == 0 ? value : ((value >> shift) | (value << (64 - shift)));
}

Int64 _hashLen16(Int64 u, Int64 v, Int64 mul) {
  // Murmur-inspired hashing.
  var a = (u ^ v) * mul;
  a ^= (a >> 47);
  var b = (v ^ a) * mul;
  b ^= (b >> 47);
  b *= mul;
  return b;
}

Int64 _hashLen0to16(List<int> s) {
  final len = s.length;
  if (len >= 8) {
    final mul = k2 + len * 2;
    final a = _fetch64(s) + k2;
    final b = _fetch64(s.sublist(len - 8));
    final c = _rotate64(b, 37) * mul + a;
    final d = (_rotate64(a, 25) + b) * mul;
    return _hashLen16(c, d, mul);
  }
  if (len >= 4) {
    final mul = k2 + len * 2;
    final a = _fetch32(s);
    return _hashLen16(Int64(len) + (a << 3), _fetch32(s.sublist(len - 4)), mul);
  }
  if (len > 0) {
    // TODO:
    return Int64();
  }
  return k2;
}

Int64 _hashLen17to32(List<int> s) {
  return Int64(0); 
}

Int64 _hashLen33to64(List<int> s) {
  return Int64(0); 
}

// Hash function for a byte array.
// May change from time to time, may differ on different platforms, may differ
// depending on NDEBUG.
Int64 fingerprint64(List<int> s) {
  final seed = 81;
  final len = s.length;
  if (len <= 32) {
    if (len <= 16) {
      return _hashLen0to16(s);
    } else {
      return _hashLen17to32(s);
    }
  } else if (len <= 64) {
    return _hashLen33to64(s);
  }

  // For strings over 64 bytes we loop.  Internal state consists of
  // 56 bytes: v, w, x, y, and z.
  var x = Int64(seed);
  var y = Int64(seed) * k1 + 113;

  return Int64(0); 
}
