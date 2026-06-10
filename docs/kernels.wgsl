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
var<storage> global_5: type_11;

fn function_() {
    var local: array<f32, 128>;
    var phi_730_: bool;
    var phi_136_: u32;
    var phi_139_: f32;
    var phi_149_: u32;
    var phi_152_: f32;
    var phi_572_: bool;
    var phi_224_: f32;
    var phi_557_: bool;
    var phi_225_: f32;
    var phi_587_: bool;
    var phi_239_: f32;
    var phi_240_: f32;
    var phi_241_: f32;
    var phi_242_: bool;
    var phi_617_: bool;
    var phi_276_: f32;
    var phi_602_: bool;
    var phi_277_: f32;
    var phi_278_: f32;
    var phi_279_: f32;
    var phi_303_: f32;
    var phi_304_: f32;
    var phi_150_: u32;
    var phi_153_: f32;
    var phi_726_: bool;
    var local_1: f32;
    var phi_755_: bool;
    var phi_137_: u32;
    var phi_140_: f32;
    var phi_754_: bool;
    var phi_320_: u32;
    var phi_321_: u32;
    var phi_756_: bool;
    var local_2: f32;

    switch bitcast<i32>(0u) {
        default: {
            let _e44 = arrayLength((&global_1.member));
            let _e46 = arrayLength((&global_2.member));
            local = array<f32, 128>(0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f);
            let _e49 = global.member.member_2;
            let _e52 = global.member.member_1;
            let _e55 = global.member.member_3;
            let _e59 = global.member.member.member_3;
            let _e62 = (1f - exp((_e59 * -0.0001308997f)));
            let _e64 = select(_e62, 0f, (_e62 < 0f));
            phi_730_ = false;
            phi_136_ = 0u;
            phi_139_ = _e55;
            loop {
                let _e70 = phi_730_;
                let _e72 = phi_136_;
                let _e74 = phi_139_;
                local_2 = _e74;
                let _e75 = (_e72 < 128u);
                if _e75 {
                    let _e76 = (_e52 + _e72);
                    phi_149_ = 0u;
                    phi_152_ = 0f;
                    loop {
                        let _e78 = phi_149_;
                        let _e80 = phi_152_;
                        local_1 = _e80;
                        let _e81 = (_e78 < select(_e49, _e44, (_e44 < _e49)));
                        if _e81 {
                            if (_e78 < _e44) {
                            } else {
                                phi_726_ = true;
                                break;
                            }
                            let _e86 = global_1.member[_e78].member_3;
                            if (_e86 == 0u) {
                                phi_304_ = 0f;
                            } else {
                                let _e91 = global_1.member[_e78].member_1;
                                let _e95 = global_1.member[_e78].member_2;
                                if (_e76 < _e91) {
                                    phi_279_ = 0f;
                                } else {
                                    let _e99 = (f32((_e76 - _e91)) * 0.000020833333f);
                                    if (_e95 == 4294967295u) {
                                        phi_241_ = f32();
                                        phi_242_ = true;
                                    } else {
                                        let _e101 = (_e76 < _e95);
                                        if _e101 {
                                            phi_240_ = f32();
                                        } else {
                                            let _e104 = (f32((_e95 - _e91)) * 0.000020833333f);
                                            let _e108 = global.member.member.member_4;
                                            if (_e104 < _e108) {
                                                if (_e108 != _e108) {
                                                    phi_557_ = true;
                                                } else {
                                                    phi_557_ = (0.00001f >= _e108);
                                                }
                                                let _e138 = phi_557_;
                                                phi_225_ = (_e104 / select(_e108, 0.00001f, _e138));
                                            } else {
                                                let _e110 = (_e104 - _e108);
                                                let _e114 = global.member.member.member_5;
                                                if (_e110 < _e114) {
                                                    let _e123 = global.member.member.member_6;
                                                    if (_e114 != _e114) {
                                                        phi_572_ = true;
                                                    } else {
                                                        phi_572_ = (0.00001f >= _e114);
                                                    }
                                                    let _e128 = phi_572_;
                                                    phi_224_ = (1f + ((_e123 - 1f) * (_e110 / select(_e114, 0.00001f, _e128))));
                                                } else {
                                                    let _e119 = global.member.member.member_6;
                                                    phi_224_ = _e119;
                                                }
                                                let _e134 = phi_224_;
                                                phi_225_ = _e134;
                                            }
                                            let _e142 = phi_225_;
                                            let _e149 = global.member.member.member_7;
                                            if (_e149 != _e149) {
                                                phi_587_ = true;
                                            } else {
                                                phi_587_ = (0.00001f >= _e149);
                                            }
                                            let _e153 = phi_587_;
                                            let _e156 = (1f - ((f32((_e76 - _e95)) * 0.000020833333f) / select(_e149, 0.00001f, _e153)));
                                            if (_e156 > 0f) {
                                                phi_239_ = (_e142 * _e156);
                                            } else {
                                                phi_239_ = 0f;
                                            }
                                            let _e160 = phi_239_;
                                            phi_240_ = _e160;
                                        }
                                        let _e162 = phi_240_;
                                        phi_241_ = _e162;
                                        phi_242_ = _e101;
                                    }
                                    let _e164 = phi_241_;
                                    let _e166 = phi_242_;
                                    if _e166 {
                                        let _e170 = global.member.member.member_4;
                                        if (_e99 < _e170) {
                                            if (_e170 != _e170) {
                                                phi_602_ = true;
                                            } else {
                                                phi_602_ = (0.00001f >= _e170);
                                            }
                                            let _e200 = phi_602_;
                                            phi_277_ = (_e99 / select(_e170, 0.00001f, _e200));
                                        } else {
                                            let _e172 = (_e99 - _e170);
                                            let _e176 = global.member.member.member_5;
                                            if (_e172 < _e176) {
                                                let _e185 = global.member.member.member_6;
                                                if (_e176 != _e176) {
                                                    phi_617_ = true;
                                                } else {
                                                    phi_617_ = (0.00001f >= _e176);
                                                }
                                                let _e190 = phi_617_;
                                                phi_276_ = (1f + ((_e185 - 1f) * (_e172 / select(_e176, 0.00001f, _e190))));
                                            } else {
                                                let _e181 = global.member.member.member_6;
                                                phi_276_ = _e181;
                                            }
                                            let _e196 = phi_276_;
                                            phi_277_ = _e196;
                                        }
                                        let _e204 = phi_277_;
                                        phi_278_ = _e204;
                                    } else {
                                        phi_278_ = _e164;
                                    }
                                    let _e206 = phi_278_;
                                    phi_279_ = _e206;
                                }
                                let _e208 = phi_279_;
                                if (_e208 <= 0f) {
                                    phi_303_ = 0f;
                                } else {
                                    let _e213 = global_1.member[_e78].member;
                                    let _e217 = global.member.member.member_1;
                                    let _e221 = global.member.member.member_2;
                                    let _e222 = f32(_e76);
                                    let _e223 = (_e222 * 0.000020833333f);
                                    let _e224 = (6.2831855f * _e213);
                                    let _e235 = global.member.member.member;
                                    let _e239 = ((_e213 * _e222) * 0.000020833333f);
                                    phi_303_ = (((sin(((_e224 * _e223) + (_e221 * sin(((_e224 * _e217) * _e223))))) * (1f - _e235)) + ((2f * (_e239 - floor((_e239 + 0.5f)))) * _e235)) * _e208);
                                }
                                let _e248 = phi_303_;
                                phi_304_ = _e248;
                            }
                            let _e250 = phi_304_;
                            phi_150_ = (_e78 + 1u);
                            phi_153_ = (_e80 + _e250);
                        } else {
                            phi_150_ = u32();
                            phi_153_ = f32();
                        }
                        let _e254 = phi_150_;
                        let _e256 = phi_153_;
                        continue;
                        continuing {
                            phi_149_ = _e254;
                            phi_152_ = _e256;
                            phi_726_ = _e70;
                            break if !(_e81);
                        }
                    }
                    let _e259 = phi_726_;
                    phi_754_ = _e259;
                    if _e259 {
                        break;
                    }
                    let _e263 = global.member.member.member_8;
                    let _e265 = local_1;
                    let _e266 = (_e265 * _e263);
                    let _e272 = (_e74 + (select(_e64, 1f, (_e64 > 1f)) * ((_e266 / (1f + abs(_e266))) - _e74)));
                    if _e75 {
                    } else {
                        phi_754_ = true;
                        break;
                    }
                    local[_e72] = _e272;
                    phi_755_ = _e259;
                    phi_137_ = (_e72 + 1u);
                    phi_140_ = _e272;
                } else {
                    phi_755_ = _e70;
                    phi_137_ = u32();
                    phi_140_ = f32();
                }
                let _e276 = phi_755_;
                let _e278 = phi_137_;
                let _e280 = phi_140_;
                continue;
                continuing {
                    phi_730_ = _e276;
                    phi_136_ = _e278;
                    phi_139_ = _e280;
                    phi_754_ = _e276;
                    break if !(_e75);
                }
            }
            let _e283 = phi_754_;
            if _e283 {
                break;
            }
            phi_320_ = 0u;
            loop {
                let _e285 = phi_320_;
                let _e286 = (_e285 < 128u);
                if _e286 {
                    if _e286 {
                    } else {
                        phi_756_ = true;
                        break;
                    }
                    let _e288 = local[_e285];
                    if (_e285 < _e46) {
                    } else {
                        phi_756_ = true;
                        break;
                    }
                    global_2.member[_e285] = _e288;
                    phi_321_ = (_e285 + 1u);
                } else {
                    phi_321_ = u32();
                }
                let _e294 = phi_321_;
                continue;
                continuing {
                    phi_320_ = _e294;
                    phi_756_ = _e283;
                    break if !(_e286);
                }
            }
            let _e297 = phi_756_;
            if _e297 {
                break;
            }
            if (128u < _e46) {
            } else {
                break;
            }
            let _e302 = local_2;
            global_2.member[128u] = _e302;
            break;
        }
    }
    return;
}

fn function_1() {
    var phi_691_: bool;
    var phi_706_: bool;
    var phi_721_: bool;

    switch bitcast<i32>(0u) {
        default: {
            let _e42 = global_3;
            let _e46 = arrayLength((&global_2.member));
            let _e49 = global_4.member[0u];
            let _e52 = global_4.member[1u];
            if (_e42.x >= _e49) {
            } else {
                if (_e42.y >= _e52) {
                } else {
                    let _e59 = (f32(_e42.x) / f32(_e49));
                    let _e67 = (_e59 * 127f);
                    let _e72 = select(select(u32(_e67), 0u, (_e67 < 0f)), 4294967295u, (_e67 > 4294967000f));
                    let _e75 = global_4.member[2u];
                    if (_e72 < arrayLength((&global_5.member))) {
                    } else {
                        break;
                    }
                    let _e81 = global_5.member[_e72];
                    let _e84 = abs(((1f - ((f32(_e42.y) / f32(_e52)) * 2f)) - (_e81 * 0.8f)));
                    let _e86 = exp((-60f * _e84));
                    let _e89 = (exp((-6f * _e84)) * (f32(_e75) * 0.001f));
                    let _e92 = ((0.9f * _e86) + (0.8f * _e89));
                    if (_e92 != _e92) {
                        phi_691_ = true;
                    } else {
                        phi_691_ = (1f <= _e92);
                    }
                    let _e96 = phi_691_;
                    let _e103 = (((0.5f * _e86) + (0.3f * _e89)) + (0.05f * abs(((_e59 * 2f) - 1f))));
                    if (_e103 != _e103) {
                        phi_706_ = true;
                    } else {
                        phi_706_ = (1f <= _e103);
                    }
                    let _e107 = phi_706_;
                    let _e111 = ((0.2f * _e86) + (0.6f * _e89));
                    if (_e111 != _e111) {
                        phi_721_ = true;
                    } else {
                        phi_721_ = (1f <= _e111);
                    }
                    let _e115 = phi_721_;
                    let _e119 = (((_e42.y * _e49) + _e42.x) * 3u);
                    if (_e119 < _e46) {
                    } else {
                        break;
                    }
                    global_2.member[_e119] = select(_e92, 1f, _e96);
                    let _e123 = (_e119 + 1u);
                    if (_e123 < _e46) {
                    } else {
                        break;
                    }
                    global_2.member[_e123] = select(_e103, 1f, _e107);
                    let _e127 = (_e119 + 2u);
                    if (_e127 < _e46) {
                    } else {
                        break;
                    }
                    global_2.member[_e127] = select(_e111, 1f, _e115);
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
