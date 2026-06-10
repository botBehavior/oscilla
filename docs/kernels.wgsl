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
    var phi_893_: bool;
    var phi_149_: u32;
    var phi_152_: f32;
    var phi_162_: u32;
    var phi_165_: f32;
    var phi_705_: bool;
    var phi_237_: f32;
    var phi_690_: bool;
    var phi_238_: f32;
    var phi_720_: bool;
    var phi_252_: f32;
    var phi_253_: f32;
    var phi_254_: f32;
    var phi_255_: bool;
    var phi_750_: bool;
    var phi_289_: f32;
    var phi_735_: bool;
    var phi_290_: f32;
    var phi_291_: f32;
    var phi_292_: f32;
    var phi_316_: f32;
    var phi_317_: f32;
    var phi_163_: u32;
    var phi_166_: f32;
    var phi_889_: bool;
    var local_1: f32;
    var phi_918_: bool;
    var phi_150_: u32;
    var phi_153_: f32;
    var phi_917_: bool;
    var phi_333_: u32;
    var phi_334_: u32;
    var phi_919_: bool;
    var local_2: f32;

    switch bitcast<i32>(0u) {
        default: {
            let _e55 = arrayLength((&global_1.member));
            let _e57 = arrayLength((&global_2.member));
            local = array<f32, 128>(0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f);
            let _e60 = global.member.member_2;
            let _e63 = global.member.member_1;
            let _e66 = global.member.member_3;
            let _e70 = global.member.member.member_3;
            let _e73 = (1f - exp((_e70 * -0.0001308997f)));
            let _e75 = select(_e73, 0f, (_e73 < 0f));
            phi_893_ = false;
            phi_149_ = 0u;
            phi_152_ = _e66;
            loop {
                let _e81 = phi_893_;
                let _e83 = phi_149_;
                let _e85 = phi_152_;
                local_2 = _e85;
                let _e86 = (_e83 < 128u);
                if _e86 {
                    let _e87 = (_e63 + _e83);
                    phi_162_ = 0u;
                    phi_165_ = 0f;
                    loop {
                        let _e89 = phi_162_;
                        let _e91 = phi_165_;
                        local_1 = _e91;
                        let _e92 = (_e89 < select(_e60, _e55, (_e55 < _e60)));
                        if _e92 {
                            if (_e89 < _e55) {
                            } else {
                                phi_889_ = true;
                                break;
                            }
                            let _e97 = global_1.member[_e89].member_3;
                            if (_e97 == 0u) {
                                phi_317_ = 0f;
                            } else {
                                let _e102 = global_1.member[_e89].member_1;
                                let _e106 = global_1.member[_e89].member_2;
                                if (_e87 < _e102) {
                                    phi_292_ = 0f;
                                } else {
                                    let _e110 = (f32((_e87 - _e102)) * 0.000020833333f);
                                    if (_e106 == 4294967295u) {
                                        phi_254_ = f32();
                                        phi_255_ = true;
                                    } else {
                                        let _e112 = (_e87 < _e106);
                                        if _e112 {
                                            phi_253_ = f32();
                                        } else {
                                            let _e115 = (f32((_e106 - _e102)) * 0.000020833333f);
                                            let _e119 = global.member.member.member_4;
                                            if (_e115 < _e119) {
                                                if (_e119 != _e119) {
                                                    phi_690_ = true;
                                                } else {
                                                    phi_690_ = (0.00001f >= _e119);
                                                }
                                                let _e149 = phi_690_;
                                                phi_238_ = (_e115 / select(_e119, 0.00001f, _e149));
                                            } else {
                                                let _e121 = (_e115 - _e119);
                                                let _e125 = global.member.member.member_5;
                                                if (_e121 < _e125) {
                                                    let _e134 = global.member.member.member_6;
                                                    if (_e125 != _e125) {
                                                        phi_705_ = true;
                                                    } else {
                                                        phi_705_ = (0.00001f >= _e125);
                                                    }
                                                    let _e139 = phi_705_;
                                                    phi_237_ = (1f + ((_e134 - 1f) * (_e121 / select(_e125, 0.00001f, _e139))));
                                                } else {
                                                    let _e130 = global.member.member.member_6;
                                                    phi_237_ = _e130;
                                                }
                                                let _e145 = phi_237_;
                                                phi_238_ = _e145;
                                            }
                                            let _e153 = phi_238_;
                                            let _e160 = global.member.member.member_7;
                                            if (_e160 != _e160) {
                                                phi_720_ = true;
                                            } else {
                                                phi_720_ = (0.00001f >= _e160);
                                            }
                                            let _e164 = phi_720_;
                                            let _e167 = (1f - ((f32((_e87 - _e106)) * 0.000020833333f) / select(_e160, 0.00001f, _e164)));
                                            if (_e167 > 0f) {
                                                phi_252_ = (_e153 * _e167);
                                            } else {
                                                phi_252_ = 0f;
                                            }
                                            let _e171 = phi_252_;
                                            phi_253_ = _e171;
                                        }
                                        let _e173 = phi_253_;
                                        phi_254_ = _e173;
                                        phi_255_ = _e112;
                                    }
                                    let _e175 = phi_254_;
                                    let _e177 = phi_255_;
                                    if _e177 {
                                        let _e181 = global.member.member.member_4;
                                        if (_e110 < _e181) {
                                            if (_e181 != _e181) {
                                                phi_735_ = true;
                                            } else {
                                                phi_735_ = (0.00001f >= _e181);
                                            }
                                            let _e211 = phi_735_;
                                            phi_290_ = (_e110 / select(_e181, 0.00001f, _e211));
                                        } else {
                                            let _e183 = (_e110 - _e181);
                                            let _e187 = global.member.member.member_5;
                                            if (_e183 < _e187) {
                                                let _e196 = global.member.member.member_6;
                                                if (_e187 != _e187) {
                                                    phi_750_ = true;
                                                } else {
                                                    phi_750_ = (0.00001f >= _e187);
                                                }
                                                let _e201 = phi_750_;
                                                phi_289_ = (1f + ((_e196 - 1f) * (_e183 / select(_e187, 0.00001f, _e201))));
                                            } else {
                                                let _e192 = global.member.member.member_6;
                                                phi_289_ = _e192;
                                            }
                                            let _e207 = phi_289_;
                                            phi_290_ = _e207;
                                        }
                                        let _e215 = phi_290_;
                                        phi_291_ = _e215;
                                    } else {
                                        phi_291_ = _e175;
                                    }
                                    let _e217 = phi_291_;
                                    phi_292_ = _e217;
                                }
                                let _e219 = phi_292_;
                                if (_e219 <= 0f) {
                                    phi_316_ = 0f;
                                } else {
                                    let _e224 = global_1.member[_e89].member;
                                    let _e228 = global.member.member.member_1;
                                    let _e232 = global.member.member.member_2;
                                    let _e233 = f32(_e87);
                                    let _e234 = (_e233 * 0.000020833333f);
                                    let _e235 = (6.2831855f * _e224);
                                    let _e246 = global.member.member.member;
                                    let _e250 = ((_e224 * _e233) * 0.000020833333f);
                                    phi_316_ = (((sin(((_e235 * _e234) + (_e232 * sin(((_e235 * _e228) * _e234))))) * (1f - _e246)) + ((2f * (_e250 - floor((_e250 + 0.5f)))) * _e246)) * _e219);
                                }
                                let _e259 = phi_316_;
                                phi_317_ = _e259;
                            }
                            let _e261 = phi_317_;
                            phi_163_ = (_e89 + 1u);
                            phi_166_ = (_e91 + _e261);
                        } else {
                            phi_163_ = u32();
                            phi_166_ = f32();
                        }
                        let _e265 = phi_163_;
                        let _e267 = phi_166_;
                        continue;
                        continuing {
                            phi_162_ = _e265;
                            phi_165_ = _e267;
                            phi_889_ = _e81;
                            break if !(_e92);
                        }
                    }
                    let _e270 = phi_889_;
                    phi_917_ = _e270;
                    if _e270 {
                        break;
                    }
                    let _e274 = global.member.member.member_8;
                    let _e276 = local_1;
                    let _e277 = (_e276 * _e274);
                    let _e283 = (_e85 + (select(_e75, 1f, (_e75 > 1f)) * ((_e277 / (1f + abs(_e277))) - _e85)));
                    if _e86 {
                    } else {
                        phi_917_ = true;
                        break;
                    }
                    local[_e83] = _e283;
                    phi_918_ = _e270;
                    phi_150_ = (_e83 + 1u);
                    phi_153_ = _e283;
                } else {
                    phi_918_ = _e81;
                    phi_150_ = u32();
                    phi_153_ = f32();
                }
                let _e287 = phi_918_;
                let _e289 = phi_150_;
                let _e291 = phi_153_;
                continue;
                continuing {
                    phi_893_ = _e287;
                    phi_149_ = _e289;
                    phi_152_ = _e291;
                    phi_917_ = _e287;
                    break if !(_e86);
                }
            }
            let _e294 = phi_917_;
            if _e294 {
                break;
            }
            phi_333_ = 0u;
            loop {
                let _e296 = phi_333_;
                let _e297 = (_e296 < 128u);
                if _e297 {
                    if _e297 {
                    } else {
                        phi_919_ = true;
                        break;
                    }
                    let _e299 = local[_e296];
                    if (_e296 < _e57) {
                    } else {
                        phi_919_ = true;
                        break;
                    }
                    global_2.member[_e296] = _e299;
                    phi_334_ = (_e296 + 1u);
                } else {
                    phi_334_ = u32();
                }
                let _e305 = phi_334_;
                continue;
                continuing {
                    phi_333_ = _e305;
                    phi_919_ = _e294;
                    break if !(_e297);
                }
            }
            let _e308 = phi_919_;
            if _e308 {
                break;
            }
            if (128u < _e57) {
            } else {
                break;
            }
            let _e313 = local_2;
            global_2.member[128u] = _e313;
            break;
        }
    }
    return;
}

fn function_1() {
    var phi_854_: bool;
    var phi_869_: bool;
    var phi_884_: bool;
    var phi_492_: u32;
    var phi_495_: f32;
    var phi_496_: f32;
    var phi_493_: u32;
    var phi_497_: f32;
    var phi_922_: bool;
    var local_3: f32;
    var local_4: f32;
    var local_5: f32;
    var local_6: f32;
    var local_7: f32;
    var local_8: f32;
    var phi_797_: bool;
    var phi_812_: bool;
    var phi_538_: f32;
    var phi_574_: array<f32, 3>;

    switch bitcast<i32>(0u) {
        default: {
            let _e53 = global_3;
            let _e55 = arrayLength((&global_2.member));
            let _e58 = global_4.member[0u];
            let _e61 = global_4.member[1u];
            if (_e53.x >= _e58) {
            } else {
                if (_e53.y >= _e61) {
                } else {
                    let _e68 = (f32(_e53.x) / f32(_e58));
                    let _e75 = (1f - ((f32(_e53.y) / f32(_e61)) * 2f));
                    let _e78 = global_4.member[2u];
                    let _e83 = global_4.member[3u];
                    if (_e83 == 1u) {
                        let _e131 = (_e68 * 32f);
                        let _e136 = select(select(u32(_e131), 0u, (_e131 < 0f)), 4294967295u, (_e131 > 4294967000f));
                        let _e144 = (2f * cos((pow(100f, (f32(select(_e136, 31u, (31u < _e136))) * 0.032258064f)) * 0.010471975f)));
                        phi_492_ = 0u;
                        phi_495_ = 0f;
                        phi_496_ = 0f;
                        loop {
                            let _e146 = phi_492_;
                            let _e148 = phi_495_;
                            let _e150 = phi_496_;
                            local_3 = _e150;
                            local_4 = _e150;
                            local_5 = _e148;
                            local_6 = _e148;
                            local_7 = _e150;
                            local_8 = _e148;
                            let _e151 = (_e146 < 128u);
                            if _e151 {
                                if _e151 {
                                } else {
                                    phi_922_ = true;
                                    break;
                                }
                                let _e154 = global_5.member[_e146];
                                phi_493_ = (_e146 + 1u);
                                phi_497_ = ((_e154 + (_e144 * _e150)) - _e148);
                            } else {
                                phi_493_ = u32();
                                phi_497_ = f32();
                            }
                            let _e160 = phi_493_;
                            let _e162 = phi_497_;
                            continue;
                            continuing {
                                phi_492_ = _e160;
                                phi_495_ = _e150;
                                phi_496_ = _e162;
                                phi_922_ = false;
                                break if !(_e151);
                            }
                        }
                        let _e165 = phi_922_;
                        if _e165 {
                            break;
                        }
                        let _e167 = local_3;
                        let _e169 = local_4;
                        let _e172 = local_5;
                        let _e174 = local_6;
                        let _e178 = local_7;
                        let _e181 = local_8;
                        let _e183 = (((_e167 * _e169) + (_e172 * _e174)) - ((_e144 * _e178) * _e181));
                        if (_e183 != _e183) {
                            phi_797_ = true;
                        } else {
                            phi_797_ = (0f >= _e183);
                        }
                        let _e187 = phi_797_;
                        let _e190 = (sqrt(select(_e183, 0f, _e187)) * 0.0625f);
                        if (_e190 != _e190) {
                            phi_812_ = true;
                        } else {
                            phi_812_ = (1f <= _e190);
                        }
                        let _e194 = phi_812_;
                        let _e197 = ((select(_e190, 1f, _e194) * 1.8f) - 0.9f);
                        if (_e75 < _e197) {
                            phi_538_ = 1f;
                        } else {
                            phi_538_ = (exp((-14f * (_e75 - _e197))) * 0.6f);
                        }
                        let _e204 = phi_538_;
                        let _e205 = f32(_e136);
                        phi_574_ = array<f32, 3>((_e204 * (0.3f + (_e205 * 0.021875f))), ((_e204 * 0.9f) * (1f - (_e205 * 0.015625f))), (_e204 * (0.9f - (_e205 * 0.01875f))));
                    } else {
                        let _e85 = (_e68 * 127f);
                        let _e90 = select(select(u32(_e85), 0u, (_e85 < 0f)), 4294967295u, (_e85 > 4294967000f));
                        if (_e90 < 128u) {
                        } else {
                            break;
                        }
                        let _e94 = global_5.member[_e90];
                        let _e97 = abs((_e75 - (_e94 * 0.8f)));
                        let _e99 = exp((-60f * _e97));
                        let _e102 = (exp((-6f * _e97)) * (f32(_e78) * 0.001f));
                        let _e105 = ((0.9f * _e99) + (0.8f * _e102));
                        if (_e105 != _e105) {
                            phi_854_ = true;
                        } else {
                            phi_854_ = (1f <= _e105);
                        }
                        let _e109 = phi_854_;
                        let _e116 = (((0.5f * _e99) + (0.3f * _e102)) + (0.05f * abs(((_e68 * 2f) - 1f))));
                        if (_e116 != _e116) {
                            phi_869_ = true;
                        } else {
                            phi_869_ = (1f <= _e116);
                        }
                        let _e120 = phi_869_;
                        let _e124 = ((0.2f * _e99) + (0.6f * _e102));
                        if (_e124 != _e124) {
                            phi_884_ = true;
                        } else {
                            phi_884_ = (1f <= _e124);
                        }
                        let _e128 = phi_884_;
                        phi_574_ = array<f32, 3>(select(_e105, 1f, _e109), select(_e116, 1f, _e120), select(_e124, 1f, _e128));
                    }
                    let _e218 = phi_574_;
                    let _e221 = (((_e53.y * _e58) + _e53.x) * 3u);
                    if (_e221 < _e55) {
                    } else {
                        break;
                    }
                    global_2.member[_e221] = _e218[0];
                    let _e227 = (_e221 + 1u);
                    if (_e227 < _e55) {
                    } else {
                        break;
                    }
                    global_2.member[_e227] = _e218[1];
                    let _e232 = (_e221 + 2u);
                    if (_e232 < _e55) {
                    } else {
                        break;
                    }
                    global_2.member[_e232] = _e218[2];
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
