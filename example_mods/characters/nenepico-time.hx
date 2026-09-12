
function onEvent(name, v1, v2){
    if (name == ''){
        switch(v1){
            case 'gfSuffix':
                gf.idleSuffix = '-' + v2;
        }
    }
}