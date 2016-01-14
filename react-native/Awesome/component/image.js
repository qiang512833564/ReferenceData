var Images = {
    getImage: (img) => {
        switch (img) {
            case 'p1': 
                return require('image!p1');
            case 'p2': 
                return require('image!p2');
            case 'p3': 
                return require('image!p3');
            case 'p4': 
                return require('image!p4');
            case 'p5': 
                return require('image!p5');
            case 'p6': 
                return require('image!p6');
            case 'p7': 
                return require('image!p7');
            case 'p8': 
                return require('image!p8');
            case 'p9': 
                return require('image!p9');
            case 'p10': 
                return require('image!p10');
            case 'p11': 
                return require('image!p11');
            case 'p12': 
                return require('image!p12');
            case 'p13': 
                return require('image!p13');
            case 'p14': 
                return require('image!p14');
            case 'p15': 
                return require('image!p15');
            
        }
    }
}

module.exports = Images;