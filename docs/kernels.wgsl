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
@group(0) @binding(2) 
var<storage> global_6: type_11;
@group(0) @binding(3) 
var<storage, read_write> global_7: type_11;

fn function_() {
    var local: array<f32, 128>;
    var phi_2086_: bool;
    var phi_229_: u32;
    var phi_232_: f32;
    var phi_242_: u32;
    var phi_245_: f32;
    var phi_1486_: bool;
    var phi_317_: f32;
    var phi_1471_: bool;
    var phi_318_: f32;
    var phi_1501_: bool;
    var phi_332_: f32;
    var phi_333_: f32;
    var phi_334_: f32;
    var phi_335_: bool;
    var phi_1531_: bool;
    var phi_369_: f32;
    var phi_1516_: bool;
    var phi_370_: f32;
    var phi_371_: f32;
    var phi_372_: f32;
    var phi_396_: f32;
    var phi_397_: f32;
    var phi_243_: u32;
    var phi_246_: f32;
    var phi_2082_: bool;
    var local_1: f32;
    var phi_2111_: bool;
    var phi_230_: u32;
    var phi_233_: f32;
    var phi_2110_: bool;
    var phi_413_: u32;
    var phi_414_: u32;
    var phi_2112_: bool;
    var local_2: f32;

    switch bitcast<i32>(0u) {
        default: {
            let _e115 = arrayLength((&global_1.member));
            let _e117 = arrayLength((&global_2.member));
            local = array<f32, 128>(0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f);
            let _e120 = global.member.member_2;
            let _e123 = global.member.member_1;
            let _e126 = global.member.member_3;
            let _e130 = global.member.member.member_3;
            let _e133 = (1f - exp((_e130 * -0.0001308997f)));
            let _e135 = select(_e133, 0f, (_e133 < 0f));
            phi_2086_ = false;
            phi_229_ = 0u;
            phi_232_ = _e126;
            loop {
                let _e141 = phi_2086_;
                let _e143 = phi_229_;
                let _e145 = phi_232_;
                local_2 = _e145;
                let _e146 = (_e143 < 128u);
                if _e146 {
                    let _e147 = (_e123 + _e143);
                    phi_242_ = 0u;
                    phi_245_ = 0f;
                    loop {
                        let _e149 = phi_242_;
                        let _e151 = phi_245_;
                        local_1 = _e151;
                        let _e152 = (_e149 < select(_e120, _e115, (_e115 < _e120)));
                        if _e152 {
                            if (_e149 < _e115) {
                            } else {
                                phi_2082_ = true;
                                break;
                            }
                            let _e157 = global_1.member[_e149].member_3;
                            if (_e157 == 0u) {
                                phi_397_ = 0f;
                            } else {
                                let _e162 = global_1.member[_e149].member_1;
                                let _e166 = global_1.member[_e149].member_2;
                                if (_e147 < _e162) {
                                    phi_372_ = 0f;
                                } else {
                                    let _e170 = (f32((_e147 - _e162)) * 0.000020833333f);
                                    if (_e166 == 4294967295u) {
                                        phi_334_ = f32();
                                        phi_335_ = true;
                                    } else {
                                        let _e172 = (_e147 < _e166);
                                        if _e172 {
                                            phi_333_ = f32();
                                        } else {
                                            let _e175 = (f32((_e166 - _e162)) * 0.000020833333f);
                                            let _e179 = global.member.member.member_4;
                                            if (_e175 < _e179) {
                                                if (_e179 != _e179) {
                                                    phi_1471_ = true;
                                                } else {
                                                    phi_1471_ = (0.00001f >= _e179);
                                                }
                                                let _e209 = phi_1471_;
                                                phi_318_ = (_e175 / select(_e179, 0.00001f, _e209));
                                            } else {
                                                let _e181 = (_e175 - _e179);
                                                let _e185 = global.member.member.member_5;
                                                if (_e181 < _e185) {
                                                    let _e194 = global.member.member.member_6;
                                                    if (_e185 != _e185) {
                                                        phi_1486_ = true;
                                                    } else {
                                                        phi_1486_ = (0.00001f >= _e185);
                                                    }
                                                    let _e199 = phi_1486_;
                                                    phi_317_ = (1f + ((_e194 - 1f) * (_e181 / select(_e185, 0.00001f, _e199))));
                                                } else {
                                                    let _e190 = global.member.member.member_6;
                                                    phi_317_ = _e190;
                                                }
                                                let _e205 = phi_317_;
                                                phi_318_ = _e205;
                                            }
                                            let _e213 = phi_318_;
                                            let _e220 = global.member.member.member_7;
                                            if (_e220 != _e220) {
                                                phi_1501_ = true;
                                            } else {
                                                phi_1501_ = (0.00001f >= _e220);
                                            }
                                            let _e224 = phi_1501_;
                                            let _e227 = (1f - ((f32((_e147 - _e166)) * 0.000020833333f) / select(_e220, 0.00001f, _e224)));
                                            if (_e227 > 0f) {
                                                phi_332_ = (_e213 * _e227);
                                            } else {
                                                phi_332_ = 0f;
                                            }
                                            let _e231 = phi_332_;
                                            phi_333_ = _e231;
                                        }
                                        let _e233 = phi_333_;
                                        phi_334_ = _e233;
                                        phi_335_ = _e172;
                                    }
                                    let _e235 = phi_334_;
                                    let _e237 = phi_335_;
                                    if _e237 {
                                        let _e241 = global.member.member.member_4;
                                        if (_e170 < _e241) {
                                            if (_e241 != _e241) {
                                                phi_1516_ = true;
                                            } else {
                                                phi_1516_ = (0.00001f >= _e241);
                                            }
                                            let _e271 = phi_1516_;
                                            phi_370_ = (_e170 / select(_e241, 0.00001f, _e271));
                                        } else {
                                            let _e243 = (_e170 - _e241);
                                            let _e247 = global.member.member.member_5;
                                            if (_e243 < _e247) {
                                                let _e256 = global.member.member.member_6;
                                                if (_e247 != _e247) {
                                                    phi_1531_ = true;
                                                } else {
                                                    phi_1531_ = (0.00001f >= _e247);
                                                }
                                                let _e261 = phi_1531_;
                                                phi_369_ = (1f + ((_e256 - 1f) * (_e243 / select(_e247, 0.00001f, _e261))));
                                            } else {
                                                let _e252 = global.member.member.member_6;
                                                phi_369_ = _e252;
                                            }
                                            let _e267 = phi_369_;
                                            phi_370_ = _e267;
                                        }
                                        let _e275 = phi_370_;
                                        phi_371_ = _e275;
                                    } else {
                                        phi_371_ = _e235;
                                    }
                                    let _e277 = phi_371_;
                                    phi_372_ = _e277;
                                }
                                let _e279 = phi_372_;
                                if (_e279 <= 0f) {
                                    phi_396_ = 0f;
                                } else {
                                    let _e284 = global_1.member[_e149].member;
                                    let _e288 = global.member.member.member_1;
                                    let _e292 = global.member.member.member_2;
                                    let _e293 = f32(_e147);
                                    let _e294 = (_e293 * 0.000020833333f);
                                    let _e295 = (6.2831855f * _e284);
                                    let _e306 = global.member.member.member;
                                    let _e310 = ((_e284 * _e293) * 0.000020833333f);
                                    phi_396_ = (((sin(((_e295 * _e294) + (_e292 * sin(((_e295 * _e288) * _e294))))) * (1f - _e306)) + ((2f * (_e310 - floor((_e310 + 0.5f)))) * _e306)) * _e279);
                                }
                                let _e319 = phi_396_;
                                phi_397_ = _e319;
                            }
                            let _e321 = phi_397_;
                            phi_243_ = (_e149 + 1u);
                            phi_246_ = (_e151 + _e321);
                        } else {
                            phi_243_ = u32();
                            phi_246_ = f32();
                        }
                        let _e325 = phi_243_;
                        let _e327 = phi_246_;
                        continue;
                        continuing {
                            phi_242_ = _e325;
                            phi_245_ = _e327;
                            phi_2082_ = _e141;
                            break if !(_e152);
                        }
                    }
                    let _e330 = phi_2082_;
                    phi_2110_ = _e330;
                    if _e330 {
                        break;
                    }
                    let _e334 = global.member.member.member_8;
                    let _e336 = local_1;
                    let _e337 = (_e336 * _e334);
                    let _e343 = (_e145 + (select(_e135, 1f, (_e135 > 1f)) * ((_e337 / (1f + abs(_e337))) - _e145)));
                    if _e146 {
                    } else {
                        phi_2110_ = true;
                        break;
                    }
                    local[_e143] = _e343;
                    phi_2111_ = _e330;
                    phi_230_ = (_e143 + 1u);
                    phi_233_ = _e343;
                } else {
                    phi_2111_ = _e141;
                    phi_230_ = u32();
                    phi_233_ = f32();
                }
                let _e347 = phi_2111_;
                let _e349 = phi_230_;
                let _e351 = phi_233_;
                continue;
                continuing {
                    phi_2086_ = _e347;
                    phi_229_ = _e349;
                    phi_232_ = _e351;
                    phi_2110_ = _e347;
                    break if !(_e146);
                }
            }
            let _e354 = phi_2110_;
            if _e354 {
                break;
            }
            phi_413_ = 0u;
            loop {
                let _e356 = phi_413_;
                let _e357 = (_e356 < 128u);
                if _e357 {
                    if _e357 {
                    } else {
                        phi_2112_ = true;
                        break;
                    }
                    let _e359 = local[_e356];
                    if (_e356 < _e117) {
                    } else {
                        phi_2112_ = true;
                        break;
                    }
                    global_2.member[_e356] = _e359;
                    phi_414_ = (_e356 + 1u);
                } else {
                    phi_414_ = u32();
                }
                let _e365 = phi_414_;
                continue;
                continuing {
                    phi_413_ = _e365;
                    phi_2112_ = _e354;
                    break if !(_e357);
                }
            }
            let _e368 = phi_2112_;
            if _e368 {
                break;
            }
            if (128u < _e117) {
            } else {
                break;
            }
            let _e373 = local_2;
            global_2.member[128u] = _e373;
            break;
        }
    }
    return;
}

fn function_1() {
    var phi_558_: u32;
    var phi_561_: f32;
    var phi_562_: f32;
    var phi_559_: u32;
    var phi_563_: f32;
    var phi_2115_: bool;
    var local_3: f32;
    var local_4: f32;
    var local_5: f32;
    var local_6: f32;
    var local_7: f32;
    var local_8: f32;
    var phi_1578_: bool;
    var phi_609_: u32;
    var phi_612_: f32;
    var phi_613_: f32;
    var phi_610_: u32;
    var phi_614_: f32;
    var phi_2119_: bool;
    var local_9: f32;
    var local_10: f32;
    var local_11: f32;
    var local_12: f32;
    var local_13: f32;
    var local_14: f32;
    var phi_1593_: bool;
    var phi_660_: u32;
    var phi_661_: u32;
    var phi_2125_: bool;
    var phi_769_: vec3<f32>;
    var phi_771_: vec3<f32>;
    var phi_772_: bool;
    var phi_773_: vec3<f32>;
    var phi_774_: bool;
    var phi_775_: vec3<f32>;
    var phi_776_: bool;
    var phi_799_: u32;
    var phi_802_: f32;
    var phi_803_: f32;
    var phi_800_: u32;
    var phi_804_: f32;
    var phi_2130_: bool;
    var local_15: f32;
    var local_16: f32;
    var local_17: f32;
    var local_18: f32;
    var local_19: f32;
    var local_20: f32;
    var phi_1643_: bool;
    var phi_850_: u32;
    var phi_853_: f32;
    var phi_854_: f32;
    var phi_851_: u32;
    var phi_855_: f32;
    var phi_2139_: bool;
    var local_21: f32;
    var local_22: f32;
    var local_23: f32;
    var local_24: f32;
    var local_25: f32;
    var local_26: f32;
    var phi_1658_: bool;
    var phi_901_: u32;
    var phi_904_: f32;
    var phi_905_: f32;
    var phi_902_: u32;
    var phi_906_: f32;
    var phi_2145_: bool;
    var local_27: f32;
    var local_28: f32;
    var local_29: f32;
    var local_30: f32;
    var local_31: f32;
    var local_32: f32;
    var phi_1673_: bool;
    var phi_1694_: u32;
    var phi_1695_: f32;
    var phi_1696_: f32;
    var phi_1697_: f32;
    var phi_1698_: vec2<f32>;
    var phi_1721_: u32;
    var phi_1722_: f32;
    var phi_1723_: f32;
    var phi_1724_: f32;
    var phi_1725_: vec2<f32>;
    var local_33: f32;
    var local_34: f32;
    var phi_1951_: bool;
    var phi_2057_: f32;
    var phi_2069_: f32;
    var phi_2081_: f32;

    switch bitcast<i32>(0u) {
        default: {
            let _e113 = global_3;
            let _e115 = arrayLength((&global_6.member));
            let _e117 = arrayLength((&global_7.member));
            let _e120 = global_4.member[0u];
            let _e123 = global_4.member[1u];
            if (_e113.x >= _e120) {
            } else {
                if (_e113.y >= _e123) {
                } else {
                    let _e128 = f32(_e120);
                    let _e129 = f32(_e123);
                    let _e130 = (_e128 / _e129);
                    let _e135 = ((((f32(_e113.x) / _e128) * 2f) - 1f) * _e130);
                    let _e139 = (1f - ((f32(_e113.y) / _e129) * 2f));
                    let _e142 = global_4.member[2u];
                    let _e143 = f32(_e142);
                    let _e147 = global_4.member[3u];
                    let _e148 = f32(_e147);
                    phi_558_ = 0u;
                    phi_561_ = 0f;
                    phi_562_ = 0f;
                    loop {
                        let _e150 = phi_558_;
                        let _e152 = phi_561_;
                        let _e154 = phi_562_;
                        local_3 = _e154;
                        local_4 = _e154;
                        local_5 = _e152;
                        local_6 = _e152;
                        local_7 = _e154;
                        local_8 = _e152;
                        let _e155 = (_e150 < 128u);
                        if _e155 {
                            if _e155 {
                            } else {
                                phi_2115_ = true;
                                break;
                            }
                            let _e158 = global_5.member[_e150];
                            phi_559_ = (_e150 + 1u);
                            phi_563_ = ((_e158 + (1.9995157f * _e154)) - _e152);
                        } else {
                            phi_559_ = u32();
                            phi_563_ = f32();
                        }
                        let _e164 = phi_559_;
                        let _e166 = phi_563_;
                        continue;
                        continuing {
                            phi_558_ = _e164;
                            phi_561_ = _e154;
                            phi_562_ = _e166;
                            phi_2115_ = false;
                            break if !(_e155);
                        }
                    }
                    let _e169 = phi_2115_;
                    if _e169 {
                        break;
                    }
                    let _e171 = local_3;
                    let _e173 = local_4;
                    let _e176 = local_5;
                    let _e178 = local_6;
                    let _e182 = local_7;
                    let _e185 = local_8;
                    let _e187 = (((_e171 * _e173) + (_e176 * _e178)) - ((1.9995157f * _e182) * _e185));
                    if (_e187 != _e187) {
                        phi_1578_ = true;
                    } else {
                        phi_1578_ = (0f >= _e187);
                    }
                    let _e191 = phi_1578_;
                    phi_609_ = 0u;
                    phi_612_ = 0f;
                    phi_613_ = 0f;
                    loop {
                        let _e195 = phi_609_;
                        let _e197 = phi_612_;
                        let _e199 = phi_613_;
                        local_9 = _e199;
                        local_10 = _e199;
                        local_11 = _e197;
                        local_12 = _e197;
                        local_13 = _e199;
                        local_14 = _e197;
                        let _e200 = (_e195 < 128u);
                        if _e200 {
                            if _e200 {
                            } else {
                                phi_2119_ = true;
                                break;
                            }
                            let _e203 = global_5.member[_e195];
                            phi_610_ = (_e195 + 1u);
                            phi_614_ = ((_e203 + (1.987291f * _e199)) - _e197);
                        } else {
                            phi_610_ = u32();
                            phi_614_ = f32();
                        }
                        let _e209 = phi_610_;
                        let _e211 = phi_614_;
                        continue;
                        continuing {
                            phi_609_ = _e209;
                            phi_612_ = _e199;
                            phi_613_ = _e211;
                            phi_2119_ = _e169;
                            break if !(_e200);
                        }
                    }
                    let _e214 = phi_2119_;
                    if _e214 {
                        break;
                    }
                    let _e216 = local_9;
                    let _e218 = local_10;
                    let _e221 = local_11;
                    let _e223 = local_12;
                    let _e227 = local_13;
                    let _e230 = local_14;
                    let _e232 = (((_e216 * _e218) + (_e221 * _e223)) - ((1.987291f * _e227) * _e230));
                    if (_e232 != _e232) {
                        phi_1593_ = true;
                    } else {
                        phi_1593_ = (0f >= _e232);
                    }
                    let _e236 = phi_1593_;
                    phi_660_ = 0u;
                    loop {
                        let _e240 = phi_660_;
                        let _e241 = (_e240 < 128u);
                        if _e241 {
                            if _e241 {
                            } else {
                                phi_2125_ = true;
                                break;
                            }
                            phi_661_ = (_e240 + 1u);
                        } else {
                            phi_661_ = u32();
                        }
                        let _e244 = phi_661_;
                        continue;
                        continuing {
                            phi_660_ = _e244;
                            phi_2125_ = _e214;
                            break if !(_e241);
                        }
                    }
                    let _e247 = phi_2125_;
                    if _e247 {
                        break;
                    }
                    let _e249 = (0.982f - (sqrt(select(_e187, 0f, _e191)) * 0.000234375f));
                    let _e251 = (0.004f + (sqrt(select(_e232, 0f, _e236)) * 0.00015625f));
                    let _e252 = sin(_e251);
                    let _e253 = cos(_e251);
                    let _e265 = (((((((_e135 * _e253) - (_e139 * _e252)) * _e249) / _e130) + 1f) * 0.5f) * _e128);
                    let _e272 = select(0i, select(select(i32(_e265), i32(-2147483648), (_e265 < -2147483600f)), 2147483647i, (_e265 > 2147483500f)), (_e265 == _e265));
                    let _e275 = (((1f - (((_e135 * _e252) + (_e139 * _e253)) * _e249)) * 0.5f) * _e129);
                    let _e282 = select(0i, select(select(i32(_e275), i32(-2147483648), (_e275 < -2147483600f)), 2147483647i, (_e275 > 2147483500f)), (_e275 == _e275));
                    if (_e272 >= 0i) {
                        if (_e272 < bitcast<i32>(_e120)) {
                            if (_e282 >= 0i) {
                                let _e288 = (_e282 < bitcast<i32>(_e123));
                                if _e288 {
                                    let _e293 = (((bitcast<u32>(_e282) * _e120) + bitcast<u32>(_e272)) * 3u);
                                    if (_e293 < _e115) {
                                    } else {
                                        break;
                                    }
                                    let _e297 = global_6.member[_e293];
                                    let _e298 = (_e293 + 1u);
                                    if (_e298 < _e115) {
                                    } else {
                                        break;
                                    }
                                    let _e302 = global_6.member[_e298];
                                    let _e303 = (_e293 + 2u);
                                    if (_e303 < _e115) {
                                    } else {
                                        break;
                                    }
                                    let _e307 = global_6.member[_e303];
                                    phi_769_ = vec3<f32>(_e297, _e302, _e307);
                                } else {
                                    phi_769_ = vec3<f32>();
                                }
                                let _e310 = phi_769_;
                                phi_771_ = _e310;
                                phi_772_ = select(true, false, _e288);
                            } else {
                                phi_771_ = vec3<f32>();
                                phi_772_ = true;
                            }
                            let _e313 = phi_771_;
                            let _e315 = phi_772_;
                            phi_773_ = _e313;
                            phi_774_ = _e315;
                        } else {
                            phi_773_ = vec3<f32>();
                            phi_774_ = true;
                        }
                        let _e317 = phi_773_;
                        let _e319 = phi_774_;
                        phi_775_ = _e317;
                        phi_776_ = _e319;
                    } else {
                        phi_775_ = vec3<f32>();
                        phi_776_ = true;
                    }
                    let _e321 = phi_775_;
                    let _e323 = phi_776_;
                    let _e325 = select(_e321, vec3<f32>(0f, 0f, 0f), vec3(_e323));
                    phi_799_ = 0u;
                    phi_802_ = 0f;
                    phi_803_ = 0f;
                    loop {
                        let _e327 = phi_799_;
                        let _e329 = phi_802_;
                        let _e331 = phi_803_;
                        local_15 = _e331;
                        local_16 = _e331;
                        local_17 = _e329;
                        local_18 = _e329;
                        local_19 = _e331;
                        local_20 = _e329;
                        let _e332 = (_e327 < 128u);
                        if _e332 {
                            if _e332 {
                            } else {
                                phi_2130_ = true;
                                break;
                            }
                            let _e335 = global_5.member[_e327];
                            phi_800_ = (_e327 + 1u);
                            phi_804_ = ((_e335 + (1.9995157f * _e331)) - _e329);
                        } else {
                            phi_800_ = u32();
                            phi_804_ = f32();
                        }
                        let _e341 = phi_800_;
                        let _e343 = phi_804_;
                        continue;
                        continuing {
                            phi_799_ = _e341;
                            phi_802_ = _e331;
                            phi_803_ = _e343;
                            phi_2130_ = _e247;
                            break if !(_e332);
                        }
                    }
                    let _e346 = phi_2130_;
                    if _e346 {
                        break;
                    }
                    let _e348 = local_15;
                    let _e350 = local_16;
                    let _e353 = local_17;
                    let _e355 = local_18;
                    let _e359 = local_19;
                    let _e362 = local_20;
                    let _e364 = (((_e348 * _e350) + (_e353 * _e355)) - ((1.9995157f * _e359) * _e362));
                    if (_e364 != _e364) {
                        phi_1643_ = true;
                    } else {
                        phi_1643_ = (0f >= _e364);
                    }
                    let _e368 = phi_1643_;
                    let _e370 = sqrt(select(_e364, 0f, _e368));
                    phi_850_ = 0u;
                    phi_853_ = 0f;
                    phi_854_ = 0f;
                    loop {
                        let _e372 = phi_850_;
                        let _e374 = phi_853_;
                        let _e376 = phi_854_;
                        local_21 = _e376;
                        local_22 = _e376;
                        local_23 = _e374;
                        local_24 = _e374;
                        local_25 = _e376;
                        local_26 = _e374;
                        let _e377 = (_e372 < 128u);
                        if _e377 {
                            if _e377 {
                            } else {
                                phi_2139_ = true;
                                break;
                            }
                            let _e380 = global_5.member[_e372];
                            phi_851_ = (_e372 + 1u);
                            phi_855_ = ((_e380 + (1.987291f * _e376)) - _e374);
                        } else {
                            phi_851_ = u32();
                            phi_855_ = f32();
                        }
                        let _e386 = phi_851_;
                        let _e388 = phi_855_;
                        continue;
                        continuing {
                            phi_850_ = _e386;
                            phi_853_ = _e376;
                            phi_854_ = _e388;
                            phi_2139_ = _e346;
                            break if !(_e377);
                        }
                    }
                    let _e391 = phi_2139_;
                    if _e391 {
                        break;
                    }
                    let _e393 = local_21;
                    let _e395 = local_22;
                    let _e398 = local_23;
                    let _e400 = local_24;
                    let _e404 = local_25;
                    let _e407 = local_26;
                    let _e409 = (((_e393 * _e395) + (_e398 * _e400)) - ((1.987291f * _e404) * _e407));
                    if (_e409 != _e409) {
                        phi_1658_ = true;
                    } else {
                        phi_1658_ = (0f >= _e409);
                    }
                    let _e413 = phi_1658_;
                    let _e415 = sqrt(select(_e409, 0f, _e413));
                    phi_901_ = 0u;
                    phi_904_ = 0f;
                    phi_905_ = 0f;
                    loop {
                        let _e417 = phi_901_;
                        let _e419 = phi_904_;
                        let _e421 = phi_905_;
                        local_27 = _e421;
                        local_28 = _e421;
                        local_29 = _e419;
                        local_30 = _e419;
                        local_31 = _e421;
                        local_32 = _e419;
                        let _e422 = (_e417 < 128u);
                        if _e422 {
                            if _e422 {
                            } else {
                                phi_2145_ = true;
                                break;
                            }
                            let _e425 = global_5.member[_e417];
                            phi_902_ = (_e417 + 1u);
                            phi_906_ = ((_e425 + (1.7568398f * _e421)) - _e419);
                        } else {
                            phi_902_ = u32();
                            phi_906_ = f32();
                        }
                        let _e431 = phi_902_;
                        let _e433 = phi_906_;
                        continue;
                        continuing {
                            phi_901_ = _e431;
                            phi_904_ = _e421;
                            phi_905_ = _e433;
                            phi_2145_ = _e391;
                            break if !(_e422);
                        }
                    }
                    let _e436 = phi_2145_;
                    if _e436 {
                        break;
                    }
                    let _e438 = local_27;
                    let _e440 = local_28;
                    let _e443 = local_29;
                    let _e445 = local_30;
                    let _e449 = local_31;
                    let _e452 = local_32;
                    let _e454 = (((_e438 * _e440) + (_e443 * _e445)) - ((1.7568398f * _e449) * _e452));
                    if (_e454 != _e454) {
                        phi_1673_ = true;
                    } else {
                        phi_1673_ = (0f >= _e454);
                    }
                    let _e458 = phi_1673_;
                    let _e460 = sqrt(select(_e454, 0f, _e458));
                    let _e461 = (_e460 * 0.015625f);
                    let _e465 = sqrt(((_e135 * _e135) + (_e139 * _e139)));
                    let _e466 = atan2(_e139, _e135);
                    let _e470 = ((_e466 + (_e148 * 0.00007f)) + (_e415 * 0.0234375f));
                    let _e476 = (1.6f + (_e415 * 0.03125f));
                    phi_1694_ = 0u;
                    phi_1695_ = 0f;
                    phi_1696_ = 0.5f;
                    phi_1697_ = 0f;
                    phi_1698_ = vec2<f32>((((_e465 * cos(_e470)) * _e476) + (_e148 * 0.000060000002f)), (((_e465 * sin(_e470)) * _e476) + (_e148 * -0.000045000004f)));
                    loop {
                        let _e485 = phi_1694_;
                        let _e487 = phi_1695_;
                        let _e489 = phi_1696_;
                        let _e491 = phi_1697_;
                        let _e493 = phi_1698_;
                        local_33 = _e491;
                        local_34 = _e487;
                        let _e494 = (_e485 < 5u);
                        if _e494 {
                            let _e498 = floor(_e493.x);
                            let _e499 = floor(_e493.y);
                            let _e506 = select(0i, select(select(i32(_e498), i32(-2147483648), (_e498 < -2147483600f)), 2147483647i, (_e498 > 2147483500f)), (_e498 == _e498));
                            let _e513 = select(0i, select(select(i32(_e499), i32(-2147483648), (_e499 < -2147483600f)), 2147483647i, (_e499 > 2147483500f)), (_e499 == _e499));
                            let _e514 = (_e493.x - _e498);
                            let _e518 = ((_e514 * _e514) * (3f - (2f * _e514)));
                            let _e519 = (_e493.y - _e499);
                            let _e525 = (bitcast<u32>(_e506) * 2376512323u);
                            let _e527 = (bitcast<u32>(_e513) * 3625334849u);
                            let _e529 = ((7u + _e485) * 2654435769u);
                            let _e530 = ((_e525 ^ _e527) ^ _e529);
                            let _e534 = ((_e530 ^ (_e530 >> bitcast<u32>(16i))) * 2146121005u);
                            let _e538 = ((_e534 ^ (_e534 >> bitcast<u32>(15i))) * 2221713035u);
                            let _e545 = (f32(((_e538 ^ (_e538 >> bitcast<u32>(16i))) >> bitcast<u32>(8i))) * 0.000000059604645f);
                            let _e548 = (bitcast<u32>((_e506 + 1i)) * 2376512323u);
                            let _e550 = ((_e548 ^ _e527) ^ _e529);
                            let _e554 = ((_e550 ^ (_e550 >> bitcast<u32>(16i))) * 2146121005u);
                            let _e558 = ((_e554 ^ (_e554 >> bitcast<u32>(15i))) * 2221713035u);
                            let _e568 = (bitcast<u32>((_e513 + 1i)) * 3625334849u);
                            let _e570 = ((_e525 ^ _e568) ^ _e529);
                            let _e574 = ((_e570 ^ (_e570 >> bitcast<u32>(16i))) * 2146121005u);
                            let _e578 = ((_e574 ^ (_e574 >> bitcast<u32>(15i))) * 2221713035u);
                            let _e585 = (f32(((_e578 ^ (_e578 >> bitcast<u32>(16i))) >> bitcast<u32>(8i))) * 0.000000059604645f);
                            let _e587 = ((_e548 ^ _e568) ^ _e529);
                            let _e591 = ((_e587 ^ (_e587 >> bitcast<u32>(16i))) * 2146121005u);
                            let _e595 = ((_e591 ^ (_e591 >> bitcast<u32>(15i))) * 2221713035u);
                            let _e605 = (_e545 + (((f32(((_e558 ^ (_e558 >> bitcast<u32>(16i))) >> bitcast<u32>(8i))) * 0.000000059604645f) - _e545) * _e518));
                            phi_1721_ = (_e485 + 1u);
                            phi_1722_ = (_e487 + _e489);
                            phi_1723_ = (_e489 * 0.5f);
                            phi_1724_ = (_e491 + ((_e605 + (((_e585 + (((f32(((_e595 ^ (_e595 >> bitcast<u32>(16i))) >> bitcast<u32>(8i))) * 0.000000059604645f) - _e585) * _e518)) - _e605) * ((_e519 * _e519) * (3f - (2f * _e519))))) * _e489));
                            phi_1725_ = vec2<f32>(((_e493.x * 2.03f) + 17.13f), ((_e493.y * 2.01f) - 9.71f));
                        } else {
                            phi_1721_ = u32();
                            phi_1722_ = f32();
                            phi_1723_ = f32();
                            phi_1724_ = f32();
                            phi_1725_ = vec2<f32>();
                        }
                        let _e623 = phi_1721_;
                        let _e625 = phi_1722_;
                        let _e627 = phi_1723_;
                        let _e629 = phi_1724_;
                        let _e631 = phi_1725_;
                        continue;
                        continuing {
                            phi_1694_ = _e623;
                            phi_1695_ = _e625;
                            phi_1696_ = _e627;
                            phi_1697_ = _e629;
                            phi_1698_ = _e631;
                            break if !(_e494);
                        }
                    }
                    let _e634 = local_33;
                    let _e636 = local_34;
                    let _e644 = (((((_e634 / _e636) * 0.5f) + (_e466 * 0.1f)) + (_e148 * 0.000025000001f)) + (_e460 * 0.01875f));
                    let _e657 = (vec3<f32>(0.5f, 0.5f, 0.5f) + vec3<f32>((0.5f * cos((_e644 * 6.2831855f))), (0.5f * cos(((_e644 + 0.33f) * 6.2831855f))), (0.5f * cos(((_e644 + 0.67f) * 6.2831855f)))));
                    let _e658 = (1.15f - _e465);
                    let _e660 = select(_e658, 0f, (_e658 < 0f));
                    let _e662 = select(_e660, 1f, (_e660 > 1f));
                    let _e666 = ((0.05f + (_e143 * 0.00040000002f)) + (_e370 * 0.0140625f));
                    let _e677 = ((_e466 * 0.15915494f) + 0.5f);
                    let _e679 = select(_e677, 0f, (_e677 < 0f));
                    let _e682 = (select(_e679, 0.999f, (_e679 > 0.999f)) * 127f);
                    let _e687 = select(select(u32(_e682), 0u, (_e682 < 0f)), 4294967295u, (_e682 > 4294967000f));
                    if (_e687 < 128u) {
                    } else {
                        break;
                    }
                    let _e691 = global_5.member[_e687];
                    let _e697 = abs((_e465 - ((0.45f + (_e691 * 0.22f)) + (_e370 * 0.0009375f))));
                    let _e699 = exp((-55f * _e697));
                    let _e703 = (0.35f + (_e143 * 0.0012f));
                    let _e711 = exp((-7f * _e697));
                    let _e715 = (0.2f + (_e143 * 0.001f));
                    let _e722 = (_e148 * 0.000050000002f);
                    let _e736 = (vec3<f32>(0.5f, 0.5f, 0.5f) + vec3<f32>((0.5f * cos(((_e722 + 0.6f) * 6.2831855f))), (0.5f * cos(((_e722 + 0.93000007f) * 6.2831855f))), (0.5f * cos(((_e722 + 1.27f) * 6.2831855f)))));
                    let _e744 = exp((-4.5f * _e465));
                    let _e755 = (0.6f + (_e370 * 0.001875f));
                    if (_e755 != _e755) {
                        phi_1951_ = true;
                    } else {
                        phi_1951_ = (0.8f <= _e755);
                    }
                    let _e759 = phi_1951_;
                    let _e760 = select(_e755, 0.8f, _e759);
                    let _e767 = ((((((_e657.x * _e666) * _e662) + ((0.95f * _e699) * _e703)) + ((_e657.x * _e711) * _e715)) + (((_e736.x * _e461) * _e744) * 1.5f)) + (_e325.x * _e760));
                    let _e768 = ((((((_e657.y * _e666) * _e662) + (_e699 * _e703)) + ((_e657.y * _e711) * _e715)) + (((_e736.y * _e461) * _e744) * 1.5f)) + (_e325.y * _e760));
                    let _e769 = ((((((_e657.z * _e666) * _e662) + ((0.92f * _e699) * _e703)) + ((_e657.z * _e711) * _e715)) + (((_e736.z * _e461) * _e744) * 1.5f)) + (_e325.z * _e760));
                    let _e791 = ((_e767 * ((2.51f * _e767) + 0.03f)) / ((_e767 * ((2.43f * _e767) + 0.59f)) + 0.14f));
                    let _e792 = ((_e768 * ((2.51f * _e768) + 0.03f)) / ((_e768 * ((2.43f * _e768) + 0.59f)) + 0.14f));
                    let _e793 = ((_e769 * ((2.51f * _e769) + 0.03f)) / ((_e769 * ((2.43f * _e769) + 0.59f)) + 0.14f));
                    let _e795 = select(0f, _e791, (_e791 > 0f));
                    let _e797 = select(0f, _e792, (_e792 > 0f));
                    let _e799 = select(0f, _e793, (_e793 > 0f));
                    let _e801 = select(1f, _e795, (_e795 < 1f));
                    let _e803 = select(1f, _e797, (_e797 < 1f));
                    let _e805 = select(1f, _e799, (_e799 < 1f));
                    if (_e801 <= 0.0031308f) {
                        phi_2057_ = (12.92f * _e801);
                    } else {
                        phi_2057_ = ((1.055f * pow(_e801, 0.41666666f)) - 0.055f);
                    }
                    let _e812 = phi_2057_;
                    if (_e803 <= 0.0031308f) {
                        phi_2069_ = (12.92f * _e803);
                    } else {
                        phi_2069_ = ((1.055f * pow(_e803, 0.41666666f)) - 0.055f);
                    }
                    let _e819 = phi_2069_;
                    if (_e805 <= 0.0031308f) {
                        phi_2081_ = (12.92f * _e805);
                    } else {
                        phi_2081_ = ((1.055f * pow(_e805, 0.41666666f)) - 0.055f);
                    }
                    let _e826 = phi_2081_;
                    let _e829 = (((_e113.y * _e120) + _e113.x) * 3u);
                    if (_e829 < _e117) {
                    } else {
                        break;
                    }
                    global_7.member[_e829] = _e812;
                    let _e833 = (_e829 + 1u);
                    if (_e833 < _e117) {
                    } else {
                        break;
                    }
                    global_7.member[_e833] = _e819;
                    let _e837 = (_e829 + 2u);
                    if (_e837 < _e117) {
                    } else {
                        break;
                    }
                    global_7.member[_e837] = _e826;
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
