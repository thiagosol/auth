'use strict';

let exports = {};

Object.defineProperty(exports, '__esModule', { value: true });

/* eslint-disable @typescript-eslint/strict-boolean-expressions */

// ---------------------------------------------------------------------------
// Specific encodings
// ---------------------------------------------------------------------------
var base16Encoding = {
  chars: '0123456789ABCDEF',
  bits: 4
};
var base32Encoding = {
  chars: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567',
  bits: 5
};
var base32HexEncoding = {
  chars: '0123456789ABCDEFGHIJKLMNOPQRSTUV',
  bits: 5
};
var base64Encoding = {
  chars: 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/',
  bits: 6
};
var base64UrlEncoding = {
  chars: 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_',
  bits: 6
};
var base16 = {
  parse: function parse(string, opts) {
    return _parse(string.toUpperCase(), base16Encoding, opts);
  },
  stringify: function stringify(data, opts) {
    return _stringify(data, base16Encoding, opts);
  }
};
var base32 = {
  parse: function parse(string, opts) {
    if (opts === void 0) {
      opts = {};
    }
    return _parse(opts.loose ? string.toUpperCase().replace(/0/g, 'O').replace(/1/g, 'L').replace(/8/g, 'B') : string, base32Encoding, opts);
  },
  stringify: function stringify(data, opts) {
    return _stringify(data, base32Encoding, opts);
  }
};
var base32hex = {
  parse: function parse(string, opts) {
    return _parse(string, base32HexEncoding, opts);
  },
  stringify: function stringify(data, opts) {
    return _stringify(data, base32HexEncoding, opts);
  }
};
var base64 = {
  parse: function parse(string, opts) {
    return _parse(string, base64Encoding, opts);
  },
  stringify: function stringify(data, opts) {
    return _stringify(data, base64Encoding, opts);
  }
};
var base64url = {
  parse: function parse(string, opts) {
    return _parse(string, base64UrlEncoding, opts);
  },
  stringify: function stringify(data, opts) {
    return _stringify(data, base64UrlEncoding, opts);
  }
};

// ---------------------------------------------------------------------------
// Codec implementation
// ---------------------------------------------------------------------------

var codec = {
  parse: _parse,
  stringify: _stringify
};
function _parse(string, encoding, opts) {
  var _opts$out;
  if (opts === void 0) {
    opts = {};
  }
  // Build the character lookup table:
  if (!encoding.codes) {
    encoding.codes = {};
    for (var i = 0; i < encoding.chars.length; ++i) {
      encoding.codes[encoding.chars[i]] = i;
    }
  }

  // The string must have a whole number of bytes:
  if (!opts.loose && string.length * encoding.bits & 7) {
    throw new SyntaxError('Invalid padding');
  }

  // Count the padding bytes:
  var end = string.length;
  while (string[end - 1] === '=') {
    --end;

    // If we get a whole number of bytes, there is too much padding:
    if (!opts.loose && !((string.length - end) * encoding.bits & 7)) {
      throw new SyntaxError('Invalid padding');
    }
  }

  // Allocate the output:
  var out = new ((_opts$out = opts.out) != null ? _opts$out : Uint8Array)(end * encoding.bits / 8 | 0);

  // Parse the data:
  var bits = 0; // Number of bits currently in the buffer
  var buffer = 0; // Bits waiting to be written out, MSB first
  var written = 0; // Next byte to write
  for (var _i = 0; _i < end; ++_i) {
    // Read one character from the string:
    var value = encoding.codes[string[_i]];
    if (value === undefined) {
      throw new SyntaxError('Invalid character ' + string[_i]);
    }

    // Append the bits to the buffer:
    buffer = buffer << encoding.bits | value;
    bits += encoding.bits;

    // Write out some bits if the buffer has a byte's worth:
    if (bits >= 8) {
      bits -= 8;
      out[written++] = 0xff & buffer >> bits;
    }
  }

  // Verify that we have received just enough bits:
  if (bits >= encoding.bits || 0xff & buffer << 8 - bits) {
    throw new SyntaxError('Unexpected end of data');
  }
  return out;
}
function _stringify(data, encoding, opts) {
  if (opts === void 0) {
    opts = {};
  }
  var _opts = opts,
    _opts$pad = _opts.pad,
    pad = _opts$pad === void 0 ? true : _opts$pad;
  var mask = (1 << encoding.bits) - 1;
  var out = '';
  var bits = 0; // Number of bits currently in the buffer
  var buffer = 0; // Bits waiting to be written out, MSB first
  for (var i = 0; i < data.length; ++i) {
    // Slurp data into the buffer:
    buffer = buffer << 8 | 0xff & data[i];
    bits += 8;

    // Write out as much as we can:
    while (bits > encoding.bits) {
      bits -= encoding.bits;
      out += encoding.chars[mask & buffer >> bits];
    }
  }

  // Partial character:
  if (bits) {
    out += encoding.chars[mask & buffer << encoding.bits - bits];
  }

  // Add padding characters until we hit a byte boundary:
  if (pad) {
    while (out.length * encoding.bits & 7) {
      out += '=';
    }
  }
  return out;
}

//exports.default = base64url;
exports.base16 = base16;
exports.base32 = base32;
exports.base32hex = base32hex;
exports.base64 = base64;
exports.base64url = base64url;
exports.codec = codec;

export {base16, base32, base32hex, base64, base64url, codec};
