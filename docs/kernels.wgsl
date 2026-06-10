struct type_1 {
    member: f32,
    member_1: f32,
    member_2: f32,
    member_3: f32,
    member_4: f32,
    member_5: f32,
    member_6: f32,
    member_7: f32,
    member_8: f32,
    member_9: f32,
    member_10: f32,
    member_11: f32,
}

struct type_3 {
    member: type_1,
    member_1: u32,
    member_2: u32,
    member_3: f32,
    member_4: u32,
}

struct type_4 {
    member: type_3,
}

struct type_6 {
    member: f32,
    member_1: u32,
    member_2: u32,
    member_3: u32,
}

struct type_8 {
    member: array<type_6>,
}

struct type_11 {
    member: array<f32>,
}

struct type_22 {
    member: array<u32, 4>,
}

struct type_24 {
    member: array<f32, 128>,
}

@group(0) @binding(0) 
var<storage> global: type_4;
@group(0) @binding(1) 
var<storage> global_1: type_8;
@group(0) @binding(2) 
var<storage, read_write> global_2: type_11;
var<private> global_3: vec3<u32>;
@group(0) @binding(0) 
var<storage> global_4: type_22;
@group(0) @binding(1) 
var<storage> global_5: type_24;

fn function_() {
    var local: array<f32, 128>;
    var phi_2000_: bool;
    var phi_212_: u32;
    var phi_215_: f32;
    var phi_225_: u32;
    var phi_228_: f32;
    var phi_1131_: bool;
    var phi_300_: f32;
    var phi_1116_: bool;
    var phi_301_: f32;
    var phi_1146_: bool;
    var phi_315_: f32;
    var phi_316_: f32;
    var phi_317_: f32;
    var phi_318_: bool;
    var phi_1176_: bool;
    var phi_352_: f32;
    var phi_1161_: bool;
    var phi_353_: f32;
    var phi_354_: f32;
    var phi_355_: f32;
    var phi_379_: f32;
    var phi_380_: f32;
    var phi_226_: u32;
    var phi_229_: f32;
    var phi_1996_: bool;
    var local_1: f32;
    var phi_2025_: bool;
    var phi_213_: u32;
    var phi_216_: f32;
    var phi_2024_: bool;
    var phi_396_: u32;
    var phi_397_: u32;
    var phi_2026_: bool;
    var local_2: f32;

    switch bitcast<i32>(0u) {
        default: {
            let _e98 = arrayLength((&global_1.member));
            let _e100 = arrayLength((&global_2.member));
            local = array<f32, 128>(0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f);
            let _e103 = global.member.member_2;
            let _e106 = global.member.member_1;
            let _e109 = global.member.member_3;
            let _e113 = global.member.member.member_3;
            let _e116 = (1f - exp((_e113 * -0.0001308997f)));
            let _e118 = select(_e116, 0f, (_e116 < 0f));
            phi_2000_ = false;
            phi_212_ = 0u;
            phi_215_ = _e109;
            loop {
                let _e124 = phi_2000_;
                let _e126 = phi_212_;
                let _e128 = phi_215_;
                local_2 = _e128;
                let _e129 = (_e126 < 128u);
                if _e129 {
                    let _e130 = (_e106 + _e126);
                    phi_225_ = 0u;
                    phi_228_ = 0f;
                    loop {
                        let _e132 = phi_225_;
                        let _e134 = phi_228_;
                        local_1 = _e134;
                        let _e135 = (_e132 < select(_e103, _e98, (_e98 < _e103)));
                        if _e135 {
                            if (_e132 < _e98) {
                            } else {
                                phi_1996_ = true;
                                break;
                            }
                            let _e140 = global_1.member[_e132].member_3;
                            if (_e140 == 0u) {
                                phi_380_ = 0f;
                            } else {
                                let _e145 = global_1.member[_e132].member_1;
                                let _e149 = global_1.member[_e132].member_2;
                                if (_e130 < _e145) {
                                    phi_355_ = 0f;
                                } else {
                                    let _e153 = (f32((_e130 - _e145)) * 0.000020833333f);
                                    if (_e149 == 4294967295u) {
                                        phi_317_ = f32();
                                        phi_318_ = true;
                                    } else {
                                        let _e155 = (_e130 < _e149);
                                        if _e155 {
                                            phi_316_ = f32();
                                        } else {
                                            let _e158 = (f32((_e149 - _e145)) * 0.000020833333f);
                                            let _e162 = global.member.member.member_4;
                                            if (_e158 < _e162) {
                                                if (_e162 != _e162) {
                                                    phi_1116_ = true;
                                                } else {
                                                    phi_1116_ = (0.00001f >= _e162);
                                                }
                                                let _e192 = phi_1116_;
                                                phi_301_ = (_e158 / select(_e162, 0.00001f, _e192));
                                            } else {
                                                let _e164 = (_e158 - _e162);
                                                let _e168 = global.member.member.member_5;
                                                if (_e164 < _e168) {
                                                    let _e177 = global.member.member.member_6;
                                                    if (_e168 != _e168) {
                                                        phi_1131_ = true;
                                                    } else {
                                                        phi_1131_ = (0.00001f >= _e168);
                                                    }
                                                    let _e182 = phi_1131_;
                                                    phi_300_ = (1f + ((_e177 - 1f) * (_e164 / select(_e168, 0.00001f, _e182))));
                                                } else {
                                                    let _e173 = global.member.member.member_6;
                                                    phi_300_ = _e173;
                                                }
                                                let _e188 = phi_300_;
                                                phi_301_ = _e188;
                                            }
                                            let _e196 = phi_301_;
                                            let _e203 = global.member.member.member_7;
                                            if (_e203 != _e203) {
                                                phi_1146_ = true;
                                            } else {
                                                phi_1146_ = (0.00001f >= _e203);
                                            }
                                            let _e207 = phi_1146_;
                                            let _e210 = (1f - ((f32((_e130 - _e149)) * 0.000020833333f) / select(_e203, 0.00001f, _e207)));
                                            if (_e210 > 0f) {
                                                phi_315_ = (_e196 * _e210);
                                            } else {
                                                phi_315_ = 0f;
                                            }
                                            let _e214 = phi_315_;
                                            phi_316_ = _e214;
                                        }
                                        let _e216 = phi_316_;
                                        phi_317_ = _e216;
                                        phi_318_ = _e155;
                                    }
                                    let _e218 = phi_317_;
                                    let _e220 = phi_318_;
                                    if _e220 {
                                        let _e224 = global.member.member.member_4;
                                        if (_e153 < _e224) {
                                            if (_e224 != _e224) {
                                                phi_1161_ = true;
                                            } else {
                                                phi_1161_ = (0.00001f >= _e224);
                                            }
                                            let _e254 = phi_1161_;
                                            phi_353_ = (_e153 / select(_e224, 0.00001f, _e254));
                                        } else {
                                            let _e226 = (_e153 - _e224);
                                            let _e230 = global.member.member.member_5;
                                            if (_e226 < _e230) {
                                                let _e239 = global.member.member.member_6;
                                                if (_e230 != _e230) {
                                                    phi_1176_ = true;
                                                } else {
                                                    phi_1176_ = (0.00001f >= _e230);
                                                }
                                                let _e244 = phi_1176_;
                                                phi_352_ = (1f + ((_e239 - 1f) * (_e226 / select(_e230, 0.00001f, _e244))));
                                            } else {
                                                let _e235 = global.member.member.member_6;
                                                phi_352_ = _e235;
                                            }
                                            let _e250 = phi_352_;
                                            phi_353_ = _e250;
                                        }
                                        let _e258 = phi_353_;
                                        phi_354_ = _e258;
                                    } else {
                                        phi_354_ = _e218;
                                    }
                                    let _e260 = phi_354_;
                                    phi_355_ = _e260;
                                }
                                let _e262 = phi_355_;
                                if (_e262 <= 0f) {
                                    phi_379_ = 0f;
                                } else {
                                    let _e267 = global_1.member[_e132].member;
                                    let _e271 = global.member.member.member_1;
                                    let _e275 = global.member.member.member_2;
                                    let _e276 = f32(_e130);
                                    let _e277 = (_e276 * 0.000020833333f);
                                    let _e278 = (6.2831855f * _e267);
                                    let _e289 = global.member.member.member;
                                    let _e293 = ((_e267 * _e276) * 0.000020833333f);
                                    phi_379_ = (((sin(((_e278 * _e277) + (_e275 * sin(((_e278 * _e271) * _e277))))) * (1f - _e289)) + ((2f * (_e293 - floor((_e293 + 0.5f)))) * _e289)) * _e262);
                                }
                                let _e302 = phi_379_;
                                phi_380_ = _e302;
                            }
                            let _e304 = phi_380_;
                            phi_226_ = (_e132 + 1u);
                            phi_229_ = (_e134 + _e304);
                        } else {
                            phi_226_ = u32();
                            phi_229_ = f32();
                        }
                        let _e308 = phi_226_;
                        let _e310 = phi_229_;
                        continue;
                        continuing {
                            phi_225_ = _e308;
                            phi_228_ = _e310;
                            phi_1996_ = _e124;
                            break if !(_e135);
                        }
                    }
                    let _e313 = phi_1996_;
                    phi_2024_ = _e313;
                    if _e313 {
                        break;
                    }
                    let _e317 = global.member.member.member_8;
                    let _e319 = local_1;
                    let _e320 = (_e319 * _e317);
                    let _e326 = (_e128 + (select(_e118, 1f, (_e118 > 1f)) * ((_e320 / (1f + abs(_e320))) - _e128)));
                    if _e129 {
                    } else {
                        phi_2024_ = true;
                        break;
                    }
                    local[_e126] = _e326;
                    phi_2025_ = _e313;
                    phi_213_ = (_e126 + 1u);
                    phi_216_ = _e326;
                } else {
                    phi_2025_ = _e124;
                    phi_213_ = u32();
                    phi_216_ = f32();
                }
                let _e330 = phi_2025_;
                let _e332 = phi_213_;
                let _e334 = phi_216_;
                continue;
                continuing {
                    phi_2000_ = _e330;
                    phi_212_ = _e332;
                    phi_215_ = _e334;
                    phi_2024_ = _e330;
                    break if !(_e129);
                }
            }
            let _e337 = phi_2024_;
            if _e337 {
                break;
            }
            phi_396_ = 0u;
            loop {
                let _e339 = phi_396_;
                let _e340 = (_e339 < 128u);
                if _e340 {
                    if _e340 {
                    } else {
                        phi_2026_ = true;
                        break;
                    }
                    let _e342 = local[_e339];
                    if (_e339 < _e100) {
                    } else {
                        phi_2026_ = true;
                        break;
                    }
                    global_2.member[_e339] = _e342;
                    phi_397_ = (_e339 + 1u);
                } else {
                    phi_397_ = u32();
                }
                let _e348 = phi_397_;
                continue;
                continuing {
                    phi_396_ = _e348;
                    phi_2026_ = _e337;
                    break if !(_e340);
                }
            }
            let _e351 = phi_2026_;
            if _e351 {
                break;
            }
            if (128u < _e100) {
            } else {
                break;
            }
            let _e356 = local_2;
            global_2.member[128u] = _e356;
            break;
        }
    }
    return;
}

fn function_1() {
    var phi_535_: u32;
    var phi_538_: f32;
    var phi_539_: f32;
    var phi_536_: u32;
    var phi_540_: f32;
    var phi_2029_: bool;
    var local_3: f32;
    var local_4: f32;
    var local_5: f32;
    var local_6: f32;
    var local_7: f32;
    var local_8: f32;
    var phi_1223_: bool;
    var phi_586_: u32;
    var phi_589_: f32;
    var phi_590_: f32;
    var phi_587_: u32;
    var phi_591_: f32;
    var phi_2033_: bool;
    var local_9: f32;
    var local_10: f32;
    var local_11: f32;
    var local_12: f32;
    var local_13: f32;
    var local_14: f32;
    var phi_1238_: bool;
    var phi_637_: u32;
    var phi_640_: f32;
    var phi_641_: f32;
    var phi_638_: u32;
    var phi_642_: f32;
    var phi_2039_: bool;
    var local_15: f32;
    var local_16: f32;
    var local_17: f32;
    var local_18: f32;
    var local_19: f32;
    var local_20: f32;
    var phi_1253_: bool;
    var phi_1274_: u32;
    var phi_1275_: f32;
    var phi_1276_: f32;
    var phi_1277_: f32;
    var phi_1278_: vec2<f32>;
    var phi_1301_: u32;
    var phi_1302_: f32;
    var phi_1303_: f32;
    var phi_1304_: f32;
    var phi_1305_: vec2<f32>;
    var local_21: f32;
    var local_22: f32;
    var phi_1466_: u32;
    var phi_1467_: f32;
    var phi_1468_: f32;
    var phi_1469_: f32;
    var phi_1470_: vec2<f32>;
    var phi_1493_: u32;
    var phi_1494_: f32;
    var phi_1495_: f32;
    var phi_1496_: f32;
    var phi_1497_: vec2<f32>;
    var local_23: f32;
    var local_24: f32;
    var phi_1658_: u32;
    var phi_1659_: f32;
    var phi_1660_: f32;
    var phi_1661_: f32;
    var phi_1662_: vec2<f32>;
    var phi_1685_: u32;
    var phi_1686_: f32;
    var phi_1687_: f32;
    var phi_1688_: f32;
    var phi_1689_: vec2<f32>;
    var local_25: f32;
    var local_26: f32;
    var phi_1971_: f32;
    var phi_1983_: f32;
    var phi_1995_: f32;

    switch bitcast<i32>(0u) {
        default: {
            let _e96 = global_3;
            let _e98 = arrayLength((&global_2.member));
            let _e101 = global_4.member[0u];
            let _e104 = global_4.member[1u];
            if (_e96.x >= _e101) {
            } else {
                if (_e96.y >= _e104) {
                } else {
                    let _e113 = (((f32(_e96.x) / f32(_e101)) * 2f) - 1f);
                    let _e118 = (1f - ((f32(_e96.y) / f32(_e104)) * 2f));
                    let _e121 = global_4.member[2u];
                    let _e122 = f32(_e121);
                    let _e123 = (_e122 * 0.001f);
                    let _e126 = global_4.member[3u];
                    let _e127 = f32(_e126);
                    phi_535_ = 0u;
                    phi_538_ = 0f;
                    phi_539_ = 0f;
                    loop {
                        let _e129 = phi_535_;
                        let _e131 = phi_538_;
                        let _e133 = phi_539_;
                        local_3 = _e133;
                        local_4 = _e133;
                        local_5 = _e131;
                        local_6 = _e131;
                        local_7 = _e133;
                        local_8 = _e131;
                        let _e134 = (_e129 < 128u);
                        if _e134 {
                            if _e134 {
                            } else {
                                phi_2029_ = true;
                                break;
                            }
                            let _e137 = global_5.member[_e129];
                            phi_536_ = (_e129 + 1u);
                            phi_540_ = ((_e137 + (1.9995157f * _e133)) - _e131);
                        } else {
                            phi_536_ = u32();
                            phi_540_ = f32();
                        }
                        let _e143 = phi_536_;
                        let _e145 = phi_540_;
                        continue;
                        continuing {
                            phi_535_ = _e143;
                            phi_538_ = _e133;
                            phi_539_ = _e145;
                            phi_2029_ = false;
                            break if !(_e134);
                        }
                    }
                    let _e148 = phi_2029_;
                    if _e148 {
                        break;
                    }
                    let _e150 = local_3;
                    let _e152 = local_4;
                    let _e155 = local_5;
                    let _e157 = local_6;
                    let _e161 = local_7;
                    let _e164 = local_8;
                    let _e166 = (((_e150 * _e152) + (_e155 * _e157)) - ((1.9995157f * _e161) * _e164));
                    if (_e166 != _e166) {
                        phi_1223_ = true;
                    } else {
                        phi_1223_ = (0f >= _e166);
                    }
                    let _e170 = phi_1223_;
                    let _e172 = sqrt(select(_e166, 0f, _e170));
                    phi_586_ = 0u;
                    phi_589_ = 0f;
                    phi_590_ = 0f;
                    loop {
                        let _e174 = phi_586_;
                        let _e176 = phi_589_;
                        let _e178 = phi_590_;
                        local_9 = _e178;
                        local_10 = _e178;
                        local_11 = _e176;
                        local_12 = _e176;
                        local_13 = _e178;
                        local_14 = _e176;
                        let _e179 = (_e174 < 128u);
                        if _e179 {
                            if _e179 {
                            } else {
                                phi_2033_ = true;
                                break;
                            }
                            let _e182 = global_5.member[_e174];
                            phi_587_ = (_e174 + 1u);
                            phi_591_ = ((_e182 + (1.987291f * _e178)) - _e176);
                        } else {
                            phi_587_ = u32();
                            phi_591_ = f32();
                        }
                        let _e188 = phi_587_;
                        let _e190 = phi_591_;
                        continue;
                        continuing {
                            phi_586_ = _e188;
                            phi_589_ = _e178;
                            phi_590_ = _e190;
                            phi_2033_ = _e148;
                            break if !(_e179);
                        }
                    }
                    let _e193 = phi_2033_;
                    if _e193 {
                        break;
                    }
                    let _e195 = local_9;
                    let _e197 = local_10;
                    let _e200 = local_11;
                    let _e202 = local_12;
                    let _e206 = local_13;
                    let _e209 = local_14;
                    let _e211 = (((_e195 * _e197) + (_e200 * _e202)) - ((1.987291f * _e206) * _e209));
                    if (_e211 != _e211) {
                        phi_1238_ = true;
                    } else {
                        phi_1238_ = (0f >= _e211);
                    }
                    let _e215 = phi_1238_;
                    phi_637_ = 0u;
                    phi_640_ = 0f;
                    phi_641_ = 0f;
                    loop {
                        let _e219 = phi_637_;
                        let _e221 = phi_640_;
                        let _e223 = phi_641_;
                        local_15 = _e223;
                        local_16 = _e223;
                        local_17 = _e221;
                        local_18 = _e221;
                        local_19 = _e223;
                        local_20 = _e221;
                        let _e224 = (_e219 < 128u);
                        if _e224 {
                            if _e224 {
                            } else {
                                phi_2039_ = true;
                                break;
                            }
                            let _e227 = global_5.member[_e219];
                            phi_638_ = (_e219 + 1u);
                            phi_642_ = ((_e227 + (1.7568398f * _e223)) - _e221);
                        } else {
                            phi_638_ = u32();
                            phi_642_ = f32();
                        }
                        let _e233 = phi_638_;
                        let _e235 = phi_642_;
                        continue;
                        continuing {
                            phi_637_ = _e233;
                            phi_640_ = _e223;
                            phi_641_ = _e235;
                            phi_2039_ = _e193;
                            break if !(_e224);
                        }
                    }
                    let _e238 = phi_2039_;
                    if _e238 {
                        break;
                    }
                    let _e240 = local_15;
                    let _e242 = local_16;
                    let _e245 = local_17;
                    let _e247 = local_18;
                    let _e251 = local_19;
                    let _e254 = local_20;
                    let _e256 = (((_e240 * _e242) + (_e245 * _e247)) - ((1.7568398f * _e251) * _e254));
                    if (_e256 != _e256) {
                        phi_1253_ = true;
                    } else {
                        phi_1253_ = (0f >= _e256);
                    }
                    let _e260 = phi_1253_;
                    let _e263 = (_e113 * 2f);
                    let _e264 = (_e118 * 2f);
                    phi_1274_ = 0u;
                    phi_1275_ = 0f;
                    phi_1276_ = 0.5f;
                    phi_1277_ = 0f;
                    phi_1278_ = vec2<f32>((_e263 + (_e127 * 0.000050000002f)), (_e264 + (_e127 * -0.000040000003f)));
                    loop {
                        let _e271 = phi_1274_;
                        let _e273 = phi_1275_;
                        let _e275 = phi_1276_;
                        let _e277 = phi_1277_;
                        let _e279 = phi_1278_;
                        local_21 = _e277;
                        local_22 = _e273;
                        let _e280 = (_e271 < 4u);
                        if _e280 {
                            let _e284 = floor(_e279.x);
                            let _e285 = floor(_e279.y);
                            let _e292 = select(0i, select(select(i32(_e284), i32(-2147483648), (_e284 < -2147483600f)), 2147483647i, (_e284 > 2147483500f)), (_e284 == _e284));
                            let _e299 = select(0i, select(select(i32(_e285), i32(-2147483648), (_e285 < -2147483600f)), 2147483647i, (_e285 > 2147483500f)), (_e285 == _e285));
                            let _e300 = (_e279.x - _e284);
                            let _e304 = ((_e300 * _e300) * (3f - (2f * _e300)));
                            let _e305 = (_e279.y - _e285);
                            let _e311 = (bitcast<u32>(_e292) * 2376512323u);
                            let _e313 = (bitcast<u32>(_e299) * 3625334849u);
                            let _e315 = ((11u + _e271) * 2654435769u);
                            let _e316 = ((_e311 ^ _e313) ^ _e315);
                            let _e320 = ((_e316 ^ (_e316 >> bitcast<u32>(16i))) * 2146121005u);
                            let _e324 = ((_e320 ^ (_e320 >> bitcast<u32>(15i))) * 2221713035u);
                            let _e331 = (f32(((_e324 ^ (_e324 >> bitcast<u32>(16i))) >> bitcast<u32>(8i))) * 0.000000059604645f);
                            let _e334 = (bitcast<u32>((_e292 + 1i)) * 2376512323u);
                            let _e336 = ((_e334 ^ _e313) ^ _e315);
                            let _e340 = ((_e336 ^ (_e336 >> bitcast<u32>(16i))) * 2146121005u);
                            let _e344 = ((_e340 ^ (_e340 >> bitcast<u32>(15i))) * 2221713035u);
                            let _e354 = (bitcast<u32>((_e299 + 1i)) * 3625334849u);
                            let _e356 = ((_e311 ^ _e354) ^ _e315);
                            let _e360 = ((_e356 ^ (_e356 >> bitcast<u32>(16i))) * 2146121005u);
                            let _e364 = ((_e360 ^ (_e360 >> bitcast<u32>(15i))) * 2221713035u);
                            let _e371 = (f32(((_e364 ^ (_e364 >> bitcast<u32>(16i))) >> bitcast<u32>(8i))) * 0.000000059604645f);
                            let _e373 = ((_e334 ^ _e354) ^ _e315);
                            let _e377 = ((_e373 ^ (_e373 >> bitcast<u32>(16i))) * 2146121005u);
                            let _e381 = ((_e377 ^ (_e377 >> bitcast<u32>(15i))) * 2221713035u);
                            let _e391 = (_e331 + (((f32(((_e344 ^ (_e344 >> bitcast<u32>(16i))) >> bitcast<u32>(8i))) * 0.000000059604645f) - _e331) * _e304));
                            phi_1301_ = (_e271 + 1u);
                            phi_1302_ = (_e273 + _e275);
                            phi_1303_ = (_e275 * 0.5f);
                            phi_1304_ = (_e277 + ((_e391 + (((_e371 + (((f32(((_e381 ^ (_e381 >> bitcast<u32>(16i))) >> bitcast<u32>(8i))) * 0.000000059604645f) - _e371) * _e304)) - _e391) * ((_e305 * _e305) * (3f - (2f * _e305))))) * _e275));
                            phi_1305_ = vec2<f32>(((_e279.x * 2.03f) + 17.13f), ((_e279.y * 2.01f) - 9.71f));
                        } else {
                            phi_1301_ = u32();
                            phi_1302_ = f32();
                            phi_1303_ = f32();
                            phi_1304_ = f32();
                            phi_1305_ = vec2<f32>();
                        }
                        let _e409 = phi_1301_;
                        let _e411 = phi_1302_;
                        let _e413 = phi_1303_;
                        let _e415 = phi_1304_;
                        let _e417 = phi_1305_;
                        continue;
                        continuing {
                            phi_1274_ = _e409;
                            phi_1275_ = _e411;
                            phi_1276_ = _e413;
                            phi_1277_ = _e415;
                            phi_1278_ = _e417;
                            break if !(_e280);
                        }
                    }
                    let _e420 = local_21;
                    let _e422 = local_22;
                    phi_1466_ = 0u;
                    phi_1467_ = 0f;
                    phi_1468_ = 0.5f;
                    phi_1469_ = 0f;
                    phi_1470_ = vec2<f32>(((_e263 + (_e127 * -0.000030000001f)) + 3.7f), ((_e264 + (_e127 * 0.000060000002f)) + 1.9f));
                    loop {
                        let _e432 = phi_1466_;
                        let _e434 = phi_1467_;
                        let _e436 = phi_1468_;
                        let _e438 = phi_1469_;
                        let _e440 = phi_1470_;
                        local_23 = _e438;
                        local_24 = _e434;
                        let _e441 = (_e432 < 4u);
                        if _e441 {
                            let _e445 = floor(_e440.x);
                            let _e446 = floor(_e440.y);
                            let _e453 = select(0i, select(select(i32(_e445), i32(-2147483648), (_e445 < -2147483600f)), 2147483647i, (_e445 > 2147483500f)), (_e445 == _e445));
                            let _e460 = select(0i, select(select(i32(_e446), i32(-2147483648), (_e446 < -2147483600f)), 2147483647i, (_e446 > 2147483500f)), (_e446 == _e446));
                            let _e461 = (_e440.x - _e445);
                            let _e465 = ((_e461 * _e461) * (3f - (2f * _e461)));
                            let _e466 = (_e440.y - _e446);
                            let _e472 = (bitcast<u32>(_e453) * 2376512323u);
                            let _e474 = (bitcast<u32>(_e460) * 3625334849u);
                            let _e476 = ((12u + _e432) * 2654435769u);
                            let _e477 = ((_e472 ^ _e474) ^ _e476);
                            let _e481 = ((_e477 ^ (_e477 >> bitcast<u32>(16i))) * 2146121005u);
                            let _e485 = ((_e481 ^ (_e481 >> bitcast<u32>(15i))) * 2221713035u);
                            let _e492 = (f32(((_e485 ^ (_e485 >> bitcast<u32>(16i))) >> bitcast<u32>(8i))) * 0.000000059604645f);
                            let _e495 = (bitcast<u32>((_e453 + 1i)) * 2376512323u);
                            let _e497 = ((_e495 ^ _e474) ^ _e476);
                            let _e501 = ((_e497 ^ (_e497 >> bitcast<u32>(16i))) * 2146121005u);
                            let _e505 = ((_e501 ^ (_e501 >> bitcast<u32>(15i))) * 2221713035u);
                            let _e515 = (bitcast<u32>((_e460 + 1i)) * 3625334849u);
                            let _e517 = ((_e472 ^ _e515) ^ _e476);
                            let _e521 = ((_e517 ^ (_e517 >> bitcast<u32>(16i))) * 2146121005u);
                            let _e525 = ((_e521 ^ (_e521 >> bitcast<u32>(15i))) * 2221713035u);
                            let _e532 = (f32(((_e525 ^ (_e525 >> bitcast<u32>(16i))) >> bitcast<u32>(8i))) * 0.000000059604645f);
                            let _e534 = ((_e495 ^ _e515) ^ _e476);
                            let _e538 = ((_e534 ^ (_e534 >> bitcast<u32>(16i))) * 2146121005u);
                            let _e542 = ((_e538 ^ (_e538 >> bitcast<u32>(15i))) * 2221713035u);
                            let _e552 = (_e492 + (((f32(((_e505 ^ (_e505 >> bitcast<u32>(16i))) >> bitcast<u32>(8i))) * 0.000000059604645f) - _e492) * _e465));
                            phi_1493_ = (_e432 + 1u);
                            phi_1494_ = (_e434 + _e436);
                            phi_1495_ = (_e436 * 0.5f);
                            phi_1496_ = (_e438 + ((_e552 + (((_e532 + (((f32(((_e542 ^ (_e542 >> bitcast<u32>(16i))) >> bitcast<u32>(8i))) * 0.000000059604645f) - _e532) * _e465)) - _e552) * ((_e466 * _e466) * (3f - (2f * _e466))))) * _e436));
                            phi_1497_ = vec2<f32>(((_e440.x * 2.03f) + 17.13f), ((_e440.y * 2.01f) - 9.71f));
                        } else {
                            phi_1493_ = u32();
                            phi_1494_ = f32();
                            phi_1495_ = f32();
                            phi_1496_ = f32();
                            phi_1497_ = vec2<f32>();
                        }
                        let _e570 = phi_1493_;
                        let _e572 = phi_1494_;
                        let _e574 = phi_1495_;
                        let _e576 = phi_1496_;
                        let _e578 = phi_1497_;
                        continue;
                        continuing {
                            phi_1466_ = _e570;
                            phi_1467_ = _e572;
                            phi_1468_ = _e574;
                            phi_1469_ = _e576;
                            phi_1470_ = _e578;
                            break if !(_e441);
                        }
                    }
                    let _e581 = local_23;
                    let _e583 = local_24;
                    let _e586 = (2.2f + (sqrt(select(_e211, 0f, _e215)) * 0.046875f));
                    let _e590 = (0.8f + (_e172 * 0.078125f));
                    phi_1658_ = 0u;
                    phi_1659_ = 0f;
                    phi_1660_ = 0.5f;
                    phi_1661_ = 0f;
                    phi_1662_ = vec2<f32>((((_e113 * _e586) + ((_e420 / _e422) * _e590)) + (_e127 * 0.000080000005f)), ((_e118 * _e586) + ((_e581 / _e583) * _e590)));
                    loop {
                        let _e599 = phi_1658_;
                        let _e601 = phi_1659_;
                        let _e603 = phi_1660_;
                        let _e605 = phi_1661_;
                        let _e607 = phi_1662_;
                        local_25 = _e605;
                        local_26 = _e601;
                        let _e608 = (_e599 < 5u);
                        if _e608 {
                            let _e612 = floor(_e607.x);
                            let _e613 = floor(_e607.y);
                            let _e620 = select(0i, select(select(i32(_e612), i32(-2147483648), (_e612 < -2147483600f)), 2147483647i, (_e612 > 2147483500f)), (_e612 == _e612));
                            let _e627 = select(0i, select(select(i32(_e613), i32(-2147483648), (_e613 < -2147483600f)), 2147483647i, (_e613 > 2147483500f)), (_e613 == _e613));
                            let _e628 = (_e607.x - _e612);
                            let _e632 = ((_e628 * _e628) * (3f - (2f * _e628)));
                            let _e633 = (_e607.y - _e613);
                            let _e639 = (bitcast<u32>(_e620) * 2376512323u);
                            let _e641 = (bitcast<u32>(_e627) * 3625334849u);
                            let _e643 = ((7u + _e599) * 2654435769u);
                            let _e644 = ((_e639 ^ _e641) ^ _e643);
                            let _e648 = ((_e644 ^ (_e644 >> bitcast<u32>(16i))) * 2146121005u);
                            let _e652 = ((_e648 ^ (_e648 >> bitcast<u32>(15i))) * 2221713035u);
                            let _e659 = (f32(((_e652 ^ (_e652 >> bitcast<u32>(16i))) >> bitcast<u32>(8i))) * 0.000000059604645f);
                            let _e662 = (bitcast<u32>((_e620 + 1i)) * 2376512323u);
                            let _e664 = ((_e662 ^ _e641) ^ _e643);
                            let _e668 = ((_e664 ^ (_e664 >> bitcast<u32>(16i))) * 2146121005u);
                            let _e672 = ((_e668 ^ (_e668 >> bitcast<u32>(15i))) * 2221713035u);
                            let _e682 = (bitcast<u32>((_e627 + 1i)) * 3625334849u);
                            let _e684 = ((_e639 ^ _e682) ^ _e643);
                            let _e688 = ((_e684 ^ (_e684 >> bitcast<u32>(16i))) * 2146121005u);
                            let _e692 = ((_e688 ^ (_e688 >> bitcast<u32>(15i))) * 2221713035u);
                            let _e699 = (f32(((_e692 ^ (_e692 >> bitcast<u32>(16i))) >> bitcast<u32>(8i))) * 0.000000059604645f);
                            let _e701 = ((_e662 ^ _e682) ^ _e643);
                            let _e705 = ((_e701 ^ (_e701 >> bitcast<u32>(16i))) * 2146121005u);
                            let _e709 = ((_e705 ^ (_e705 >> bitcast<u32>(15i))) * 2221713035u);
                            let _e719 = (_e659 + (((f32(((_e672 ^ (_e672 >> bitcast<u32>(16i))) >> bitcast<u32>(8i))) * 0.000000059604645f) - _e659) * _e632));
                            phi_1685_ = (_e599 + 1u);
                            phi_1686_ = (_e601 + _e603);
                            phi_1687_ = (_e603 * 0.5f);
                            phi_1688_ = (_e605 + ((_e719 + (((_e699 + (((f32(((_e709 ^ (_e709 >> bitcast<u32>(16i))) >> bitcast<u32>(8i))) * 0.000000059604645f) - _e699) * _e632)) - _e719) * ((_e633 * _e633) * (3f - (2f * _e633))))) * _e603));
                            phi_1689_ = vec2<f32>(((_e607.x * 2.03f) + 17.13f), ((_e607.y * 2.01f) - 9.71f));
                        } else {
                            phi_1685_ = u32();
                            phi_1686_ = f32();
                            phi_1687_ = f32();
                            phi_1688_ = f32();
                            phi_1689_ = vec2<f32>();
                        }
                        let _e737 = phi_1685_;
                        let _e739 = phi_1686_;
                        let _e741 = phi_1687_;
                        let _e743 = phi_1688_;
                        let _e745 = phi_1689_;
                        continue;
                        continuing {
                            phi_1658_ = _e737;
                            phi_1659_ = _e739;
                            phi_1660_ = _e741;
                            phi_1661_ = _e743;
                            phi_1662_ = _e745;
                            break if !(_e608);
                        }
                    }
                    let _e748 = local_25;
                    let _e750 = local_26;
                    let _e756 = ((((_e748 / _e750) * 0.6f) + (_e127 * 0.000020000001f)) + (sqrt(select(_e256, 0f, _e260)) * 0.0125f));
                    let _e769 = (vec3<f32>(0.5f, 0.5f, 0.5f) + vec3<f32>((0.5f * cos((_e756 * 6.2831855f))), (0.5f * cos(((_e756 + 0.33f) * 6.2831855f))), (0.5f * cos(((_e756 + 0.67f) * 6.2831855f)))));
                    let _e773 = ((0.12f + (_e122 * 0.0005f)) + (_e172 * 0.0125f));
                    let _e781 = ((_e113 * 0.5f) + 0.5f);
                    let _e783 = select(_e781, 0f, (_e781 < 0f));
                    let _e786 = (select(_e783, 0.999f, (_e783 > 0.999f)) * 127f);
                    let _e791 = select(select(u32(_e786), 0u, (_e786 < 0f)), 4294967295u, (_e786 > 4294967000f));
                    if (_e791 < 128u) {
                    } else {
                        break;
                    }
                    let _e795 = global_5.member[_e791];
                    let _e798 = abs((_e118 - (_e795 * 0.7f)));
                    let _e800 = exp((-40f * _e798));
                    let _e803 = (0.35f + _e123);
                    let _e811 = exp((-5f * _e798));
                    let _e821 = (((_e769.x * _e773) + ((0.9f * _e800) * _e803)) + (((_e769.x * _e811) * _e123) * 0.6f));
                    let _e822 = (((_e769.y * _e773) + (_e800 * _e803)) + (((_e769.y * _e811) * _e123) * 0.6f));
                    let _e823 = (((_e769.z * _e773) + ((0.95f * _e800) * _e803)) + (((_e769.z * _e811) * _e123) * 0.6f));
                    let _e845 = ((_e821 * ((2.51f * _e821) + 0.03f)) / ((_e821 * ((2.43f * _e821) + 0.59f)) + 0.14f));
                    let _e846 = ((_e822 * ((2.51f * _e822) + 0.03f)) / ((_e822 * ((2.43f * _e822) + 0.59f)) + 0.14f));
                    let _e847 = ((_e823 * ((2.51f * _e823) + 0.03f)) / ((_e823 * ((2.43f * _e823) + 0.59f)) + 0.14f));
                    let _e849 = select(0f, _e845, (_e845 > 0f));
                    let _e851 = select(0f, _e846, (_e846 > 0f));
                    let _e853 = select(0f, _e847, (_e847 > 0f));
                    let _e855 = select(1f, _e849, (_e849 < 1f));
                    let _e857 = select(1f, _e851, (_e851 < 1f));
                    let _e859 = select(1f, _e853, (_e853 < 1f));
                    if (_e855 <= 0.0031308f) {
                        phi_1971_ = (12.92f * _e855);
                    } else {
                        phi_1971_ = ((1.055f * pow(_e855, 0.41666666f)) - 0.055f);
                    }
                    let _e866 = phi_1971_;
                    if (_e857 <= 0.0031308f) {
                        phi_1983_ = (12.92f * _e857);
                    } else {
                        phi_1983_ = ((1.055f * pow(_e857, 0.41666666f)) - 0.055f);
                    }
                    let _e873 = phi_1983_;
                    if (_e859 <= 0.0031308f) {
                        phi_1995_ = (12.92f * _e859);
                    } else {
                        phi_1995_ = ((1.055f * pow(_e859, 0.41666666f)) - 0.055f);
                    }
                    let _e880 = phi_1995_;
                    let _e883 = (((_e96.y * _e101) + _e96.x) * 3u);
                    if (_e883 < _e98) {
                    } else {
                        break;
                    }
                    global_2.member[_e883] = _e866;
                    let _e887 = (_e883 + 1u);
                    if (_e887 < _e98) {
                    } else {
                        break;
                    }
                    global_2.member[_e887] = _e873;
                    let _e891 = (_e883 + 2u);
                    if (_e891 < _e98) {
                    } else {
                        break;
                    }
                    global_2.member[_e891] = _e880;
                }
            }
            break;
        }
    }
    return;
}

@compute @workgroup_size(1, 1, 1) 
fn synth_audio_cs() {
    function_();
}

@compute @workgroup_size(8, 8, 1) 
fn synth_visual_cs(@builtin(global_invocation_id) param: vec3<u32>) {
    global_3 = param;
    function_1();
}
